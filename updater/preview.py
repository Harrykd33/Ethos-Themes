"""Render the supplied radio screens with the selected Ethos color roles."""
from PIL import Image, ImageColor


class ThemePreview:
    def __init__(self, source: Image.Image, mode: str):
        self.source = source.convert("RGBA")
        self.indexed = source.convert("RGB").quantize(colors=256, dither=Image.Dither.NONE)
        # Reference screenshot colors paired with their Ethos palette indexes.
        common = [((33, 93, 148), 7), ((33, 40, 41), 0), ((41, 52, 49), 0),
                  ((49, 215, 74), 8), ((165, 16, 33), 10), ((123, 138, 140), 12)]
        if mode == "Dashboard":
            roles = [((239, 243, 247), 5), ((255, 251, 255), 9), ((214, 223, 222), 1)] + common
            self.logos = [(0.035, 0.36, 0.395, 0.49), (0.43, 0, 0.59, 0.075)]
        else:
            roles = [((255, 251, 255), 5), ((239, 243, 247), 1), ((214, 223, 222), 1),
                     ((74, 142, 189), 14), ((255, 75, 25), 2)] + common
            self.logos = [(0.415, 0.025, 0.585, 0.115)]
        self.mapping = []
        palette = self.indexed.getpalette()
        for offset in range(0, len(palette), 3):
            color = palette[offset:offset + 3]
            # Preserve antialiasing by fitting each source color between two roles.
            best = (float("inf"), 0, 0, 0)
            for i, (first, _) in enumerate(roles):
                for j in range(i, len(roles)):
                    second = roles[j][0]
                    direction = [b - a for a, b in zip(first, second)]
                    length = sum(value * value for value in direction)
                    mix = max(0, min(1, sum((c - a) * d for c, a, d in zip(color, first, direction)) / length)) if length else 0
                    error = sum((c - (a + mix * d)) ** 2 for c, a, d in zip(color, first, direction))
                    if error < best[0]:
                        best = (error, roles[i][1], roles[j][1], mix)
            self.mapping.append(best[1:])
        self.cache = {}

    def render(self, colors: tuple[str, ...]) -> Image.Image:
        if len(colors) < 18:
            return self.source.copy()
        if colors in self.cache:
            return self.cache[colors]
        rgb = [ImageColor.getrgb(color) for color in colors]
        palette = []
        for first, second, mix in self.mapping:
            palette.extend(round(a + (b - a) * mix) for a, b in zip(rgb[first], rgb[second]))
        indexed = self.indexed.copy()
        indexed.putpalette(palette)
        result = indexed.convert("RGBA")
        result.putalpha(self.source.getchannel("A"))
        # Brand artwork remains unchanged; UI text, panels, icons and gauges recolor.
        width, height = self.source.size
        for bounds in self.logos:
            box = tuple(round(value * (width if index % 2 == 0 else height)) for index, value in enumerate(bounds))
            artwork = self.source.crop(box)
            mask = Image.new("L", artwork.size)
            mask.putdata([255 if min(pixel[:3]) < 150 or max(pixel[:3]) - min(pixel[:3]) > 40 else 0
                          for pixel in artwork.getdata()])
            result.paste(artwork, box, mask)
        if len(self.cache) >= 32:
            self.cache.clear()
        self.cache[colors] = result
        return result
