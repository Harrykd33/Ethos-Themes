"""Theme Studio for Ethos — Windows desktop interface."""
from pathlib import Path
import queue
import sys
import threading
import tkinter as tk
from tkinter import filedialog

import customtkinter as ctk
from PIL import Image, ImageOps, ImageTk

from core import Catalog, detect_radios, install, is_radio_root, categorized_themes
from preview import ThemePreview
from packages import WIZARD, load_packages, remote_packages, package_files

BG = "#0c111b"
PANEL = "#141c29"
CARD = "#1b2636"
MUTED = "#91a2ba"
TEXT = "#eff5ff"
ACCENT = "#d8e312"
BLUE = "#78a8ff"
STAGES = ["connect", "download", "verify", "install"]


def studio_assets():
    if getattr(sys, "frozen", False):
        return Path(sys._MEIPASS) / "assets"
    return Path(__file__).resolve().parent / "assets"


def bundled_themes():
    if getattr(sys, "frozen", False):
        return Path(sys._MEIPASS) / "Themes"
    return Path(__file__).resolve().parents[1] / "Themes"


class App(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.title("Theme Studio for Ethos")
        self.after(250, lambda: self.iconbitmap(str(studio_assets() / "kevindrc.ico")))
        height = min(900, max(680, self.winfo_screenheight() - 70))
        width = min(1320, self.winfo_screenwidth() - 60)
        self.geometry(f"{width}x{height}+20+20")
        self.minsize(960, 680)
        self.configure(fg_color=BG)
        self.catalog = None
        self.choices = {}
        self.theme_filter = tk.StringVar(value="All Themes")
        self.script_choices = {}
        self.package_load_error = None
        try:
            self.script_packages = load_packages(studio_assets() / "script-packages.json" if getattr(sys, "frozen", False) else Path(__file__).resolve().parents[1] / "script-packages.json")
        except Exception as error:
            self.script_packages = [WIZARD]
            self.package_load_error = str(error)
        self.busy = False
        self.events = queue.Queue()
        self.phase = -1
        self.finished = False
        self.tick = 0
        self.preview_theme = None
        self.preview_mode = tk.StringVar(value="Dashboard")
        self.preview_sources = {}
        for name, filename in (("Dashboard", "preview-dashboard.png"), ("Model menu", "preview-model-menu.png")):
            with Image.open(studio_assets() / filename) as screenshot:
                self.preview_sources[name] = ThemePreview(screenshot, name)
        self.drive = tk.StringVar()
        self.protocol("WM_DELETE_WINDOW", self.close_app)
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(2, weight=1)
        self.build_header()
        self.build_storage()
        self.build_library()
        self.build_transfer()
        self.render_scripts()
        if self.package_load_error:
            self.log_line("Bundled script catalog could not be read: " + self.package_load_error)
        self.rescan()
        self.load_bundled()
        self.after(100, self.process_events)
        self.after(70, self.animate)
        self.after(300, self.refresh)

    def label(self, parent, text, size=14, color=TEXT, bold=False, **kwargs):
        kwargs.setdefault("height", size + 6)
        return ctk.CTkLabel(parent, text=text, text_color=color,
                            font=ctk.CTkFont("Segoe UI", size, weight="bold" if bold else "normal"), **kwargs)

    def button(self, parent, text, command, primary=False, **kwargs):
        return ctk.CTkButton(parent, text=text, command=command, height=36, corner_radius=8,
                            fg_color=ACCENT if primary else CARD, hover_color="#edf46c" if primary else "#28384e",
                            text_color=BG if primary else TEXT, font=ctk.CTkFont("Segoe UI", 13, weight="bold"), **kwargs)

    def build_header(self):
        frame = ctk.CTkFrame(self, fg_color="transparent")
        frame.grid(row=0, column=0, sticky="ew", padx=28, pady=(8, 10))
        frame.grid_columnconfigure(0, weight=1, uniform="header_sides")
        frame.grid_columnconfigure(2, weight=1, uniform="header_sides")
        with Image.open(studio_assets() / "kevindrc-logo.png") as logo:
            self.logo_image = ctk.CTkImage(light_image=logo.copy(), dark_image=logo.copy(), size=(144, 81))
        ctk.CTkLabel(frame, text="", image=self.logo_image, fg_color="transparent").grid(row=0, column=1, rowspan=3)
        self.label(frame, "Theme Studio for Ethos", 24, color=ACCENT, bold=True, height=32, justify="left", anchor="w").grid(row=0, column=0, sticky="w")
        self.label(frame, "Ethos 26 Required", 12, ACCENT, True).grid(row=1, column=0, sticky="w")
        self.label(frame, "Choose a palette. Connect your radio. Make it yours.", 12, MUTED).grid(row=2, column=0, sticky="w")

    def build_storage(self):
        frame = ctk.CTkFrame(self, fg_color=PANEL, corner_radius=14)
        frame.grid(row=1, column=0, sticky="ew", padx=28, pady=(0, 16))
        frame.grid_columnconfigure(1, weight=1)
        self.label(frame, "01", 17, ACCENT, True).grid(row=0, column=0, rowspan=2, padx=(18, 14))
        self.label(frame, "Radio storage", 15, bold=True).grid(row=0, column=1, sticky="w", pady=(12, 0))
        self.drive_hint = self.label(frame, "Connect via USB and choose storage mode on the radio.", 12, MUTED)
        self.drive_hint.grid(row=1, column=1, sticky="w", pady=(0, 12))
        self.drive_menu = ctk.CTkComboBox(frame, variable=self.drive, values=["No radio detected"], width=165,
                                        fg_color=CARD, border_color="#304058", button_color="#304058",
                                        command=lambda value: self.update_selection())
        self.drive_menu.grid(row=0, column=2, rowspan=2, padx=8)
        self.scan_button = self.button(frame, "Rescan", self.rescan, width=82)
        self.scan_button.grid(row=0, column=3, rowspan=2, padx=4)
        self.browse_button = self.button(frame, "Browse…", self.browse, width=90)
        self.browse_button.grid(row=0, column=4, rowspan=2, padx=(4, 16))

    def build_library(self):
        body = ctk.CTkFrame(self, fg_color="transparent")
        body.grid(row=2, column=0, sticky="nsew", padx=28, pady=(0, 16))
        body.grid_columnconfigure(0, weight=7)
        body.grid_columnconfigure(1, weight=3)
        body.grid_rowconfigure(0, weight=1)
        library = ctk.CTkFrame(body, fg_color=PANEL, corner_radius=14)
        library.grid(row=0, column=0, sticky="nsew", padx=(0, 16))
        library.grid_columnconfigure((0, 1), weight=1, uniform="package_columns")
        library.grid_rowconfigure(3, weight=1)
        heading = ctk.CTkFrame(library, fg_color="transparent")
        heading.grid(row=0, column=0, columnspan=2, sticky="ew", padx=18, pady=(14, 8))
        heading.grid_columnconfigure(0, weight=1)
        self.label(heading, "02   Installable packages", 16, bold=True).grid(row=0, column=0, sticky="w")
        self.refresh_button = self.button(heading, "Refresh GitHub", self.refresh, width=122)
        self.refresh_button.grid(row=0, column=1)
        theme_header = ctk.CTkFrame(library, fg_color="transparent")
        theme_header.grid(row=1, column=0, sticky="ew", padx=(18, 8))
        theme_header.grid_columnconfigure(0, weight=1)
        self.label(theme_header, "Themes", 15, bold=True).grid(row=0, column=0, sticky="w")
        filters = ctk.CTkFrame(theme_header, fg_color="transparent")
        filters.grid(row=0, column=1, sticky="e")
        for category in ("Dark", "Light", "All Themes"):
            ctk.CTkRadioButton(filters, text=category, variable=self.theme_filter, value=category, command=self.render_themes,
                width=55 if category != "All Themes" else 85, height=24, radiobutton_width=14, radiobutton_height=14,
                border_width_unchecked=2, border_width_checked=4, fg_color=ACCENT, hover_color="#b1bc0c",
                text_color=TEXT, font=ctk.CTkFont("Segoe UI", 11)).pack(side="left", padx=(8, 0))
        script_header = ctk.CTkFrame(library, fg_color="transparent")
        script_header.grid(row=1, column=1, sticky="ew", padx=(8, 14))
        script_header.grid_columnconfigure(0, weight=1)
        self.label(script_header, "Script Packages", 15, bold=True).grid(row=0, column=0, sticky="w")
        self.source_label = self.label(library, "Loading themes…", 12, MUTED, anchor="w")
        self.source_label.grid(row=2, column=0, sticky="ew", padx=18, pady=(2, 8))
        self.script_source_label = self.label(library, "KevinD RC · bundled catalog", 11, MUTED, anchor="w")
        self.script_source_label.grid(row=2, column=1, sticky="ew", padx=10, pady=(2, 8))
        self.theme_list = ctk.CTkScrollableFrame(library, fg_color="transparent", height=200)
        self.theme_list.grid(row=3, column=0, sticky="nsew", padx=(10, 2))
        self.theme_list.grid_columnconfigure(0, weight=1)
        self.script_list = ctk.CTkScrollableFrame(library, fg_color="transparent", height=200)
        self.script_list.grid(row=3, column=1, sticky="nsew", padx=(2, 10))
        self.script_list.grid_columnconfigure(0, weight=1)
        footer = ctk.CTkFrame(library, fg_color="transparent")
        footer.grid(row=4, column=0, columnspan=2, sticky="ew", padx=18, pady=10)
        self.selection_label = self.label(footer, "", 12, MUTED)
        self.selection_label.pack(side="left")
        self.button(footer, "Select all", lambda: self.select_all(True), width=90).pack(side="right", padx=(6, 0))
        self.button(footer, "Clear", lambda: self.select_all(False), width=65).pack(side="right")
        preview = ctk.CTkFrame(body, fg_color=PANEL, corner_radius=14)
        preview.grid(row=0, column=1, sticky="nsew")
        preview.grid_columnconfigure(0, weight=1)
        preview.grid_rowconfigure(3, weight=1)
        self.label(preview, "Radio preview", 16, bold=True).grid(row=0, column=0, sticky="w", padx=20, pady=(14, 0))
        self.preview_name = self.label(preview, "", 13, ACCENT)
        self.preview_name.grid(row=1, column=0, sticky="w", padx=20, pady=(0, 4))
        ctk.CTkSegmentedButton(preview, values=["Dashboard", "Model menu"], variable=self.preview_mode,
                               command=lambda value: self.draw_preview(), height=28,
                               selected_color="#394960", selected_hover_color="#475b75",
                               fg_color=CARD, unselected_color=CARD).grid(row=2, column=0, sticky="ew", padx=18, pady=(0, 6))
        self.preview = tk.Canvas(preview, bg=PANEL, highlightthickness=0, height=160)
        self.preview.grid(row=3, column=0, sticky="nsew", padx=16)
        self.preview.bind("<Configure>", lambda event: self.draw_preview())
        self.label(preview, "Live palette preview · approximate radio appearance", 11, MUTED).grid(row=4, column=0, pady=(4, 10))

    def build_transfer(self):
        frame = ctk.CTkFrame(self, fg_color=PANEL, corner_radius=14)
        frame.grid(row=3, column=0, sticky="ew", padx=28, pady=(0, 22))
        frame.grid_columnconfigure(0, weight=1)
        top = ctk.CTkFrame(frame, fg_color="transparent")
        top.grid(row=0, column=0, sticky="ew", padx=20, pady=(14, 0))
        top.grid_columnconfigure(0, weight=1)
        self.label(top, "03   Transfer activity", 16, bold=True).grid(row=0, column=0, sticky="w")
        self.install_button = self.button(top, "Install selected packages  →", self.start_install, primary=True, width=225)
        self.install_button.grid(row=0, column=1)
        self.pipeline = tk.Canvas(frame, bg=PANEL, highlightthickness=0, height=56)
        self.pipeline.grid(row=1, column=0, sticky="ew", padx=28, pady=(4, 0))
        self.pipeline.bind("<Configure>", lambda event: self.draw_pipeline())
        self.progress = ctk.CTkProgressBar(frame, fg_color=CARD, progress_color=ACCENT, height=6)
        self.progress.grid(row=2, column=0, sticky="ew", padx=22, pady=(4, 5))
        self.progress.set(0)
        self.status_label = self.label(frame, "Ready when you are.", 12, MUTED, anchor="w")
        self.status_label.grid(row=3, column=0, sticky="ew", padx=22)
        self.log = ctk.CTkTextbox(frame, height=46, fg_color=BG, text_color=MUTED,
                                 font=ctk.CTkFont("Consolas", 11), corner_radius=8, wrap="word")
        self.log.grid(row=4, column=0, sticky="ew", padx=20, pady=(8, 14))
        self.log.configure(state="disabled")

    def render_scripts(self):
        old = {key for key, value in self.script_choices.items() if value.get()}
        for child in self.script_list.winfo_children():
            child.destroy()
        self.script_choices = {}
        for index, package in enumerate(self.script_packages):
            card = ctk.CTkFrame(self.script_list, fg_color=CARD, corner_radius=9)
            card.grid(row=index, column=0, sticky="ew", pady=(0, 8))
            card.grid_columnconfigure(0, weight=1)
            variable = tk.BooleanVar(value=package.identity in old)
            self.script_choices[package.identity] = variable
            ctk.CTkCheckBox(card, text=package.name[:32], variable=variable, command=self.update_selection,
                fg_color=ACCENT, hover_color="#b1bc0c", checkmark_color=BG, border_color="#536580",
                text_color=TEXT, font=ctk.CTkFont("Segoe UI", 12, weight="bold"), checkbox_width=19,
                checkbox_height=19).grid(row=0, column=0, sticky="w", padx=12, pady=(12, 4))
            self.label(card, f"scripts/{package.folder}", 11, MUTED, height=26,
                justify="left", anchor="w", wraplength=265).grid(row=1, column=0, sticky="w", padx=12, pady=(0, 6))
        self.update_selection()

    def show_catalog(self, catalog):
        old_selection = {key for key, variable in self.choices.items() if variable.get()}
        first = self.catalog is None
        self.catalog = catalog
        self.choices = {theme.key: tk.BooleanVar(value=first or theme.key in old_selection) for theme in catalog.themes}
        label = "BUNDLED · included with this app" if catalog.local_folder else f"LIVE · main / {catalog.revision[:8]}"
        self.source_label.configure(text=label)
        self.render_themes()

    def render_themes(self):
        if not self.catalog:
            return
        for child in self.theme_list.winfo_children():
            child.destroy()
        visible = categorized_themes(self.catalog.themes, self.theme_filter.get())
        source = "bundled" if self.catalog.local_folder else "live GitHub"
        self.source_label.configure(text=f"{self.theme_filter.get()} · {len(visible)} shown · {source}")
        for index, theme in enumerate(visible):
            row = ctk.CTkFrame(self.theme_list, fg_color=CARD, corner_radius=9)
            row.grid(row=index, column=0, sticky="ew", pady=(0, 6))
            row.grid_columnconfigure(0, weight=1)
            variable = self.choices[theme.key]
            check = ctk.CTkCheckBox(row, text=theme.name, variable=variable, fg_color=ACCENT, hover_color="#b1bc0c",
                                   checkmark_color=BG, border_color="#536580", text_color=TEXT,
                                   font=ctk.CTkFont("Segoe UI", 13), checkbox_width=19, checkbox_height=19,
                                   command=lambda theme=theme: self.select_preview(theme))
            check.grid(row=0, column=0, sticky="w", padx=13, pady=10)
            swatch = tk.Canvas(row, width=66, height=20, bg=CARD, highlightthickness=0, cursor="hand2")
            swatch.grid(row=0, column=1, padx=8)
            for color_index, color in enumerate((theme.colors[5:6] + theme.colors[1:3] + theme.colors[7:8])[:4]):
                swatch.create_rectangle(color_index * 17, 1, color_index * 17 + 13, 19, fill=color, outline="")
            swatch.bind("<Button-1>", lambda event, theme=theme: self.select_preview(theme))
        if not visible:
            self.label(self.theme_list, "No themes in this category.", 12, MUTED).grid(row=0, column=0, sticky="w", padx=8, pady=15)
        elif not self.preview_theme or self.preview_theme.key not in {theme.key for theme in visible}:
            self.select_preview(visible[0])
        else:
            current = next(theme for theme in visible if theme.key == self.preview_theme.key)
            self.select_preview(current)
        self.update_selection()

    def select_preview(self, theme):
        self.preview_theme = theme
        self.preview_name.configure(text=theme.name)
        self.draw_preview()
        self.update_selection()

    def draw_preview(self):
        self.preview.delete("all")
        theme = self.preview_theme
        if not theme:
            return
        width, height = self.preview.winfo_width(), self.preview.winfo_height()
        if width < 20 or height < 45:
            return
        source = self.preview_sources[self.preview_mode.get()].render(theme.colors)
        image = ImageOps.contain(source, (width - 8, height - 32), Image.Resampling.LANCZOS)
        self.preview_photo = ImageTk.PhotoImage(image, master=self)
        self.preview.create_image(width / 2, (height - 28) / 2, image=self.preview_photo)
        colors = (theme.colors[5:6] + theme.colors[1:3] + theme.colors[:1])[:4]
        for index, color in enumerate(colors):
            x = 4 + (width - 8) * index / len(colors)
            right = 4 + (width - 8) * (index + 1) / len(colors)
            self.preview.create_rectangle(x, height - 19, right - 4, height - 4, fill=color, outline="")

    def draw_pipeline(self):
        canvas = self.pipeline
        canvas.delete("all")
        width = canvas.winfo_width()
        points = [38 + (width - 76) * i / 3 for i in range(4)]
        labels = ["GitHub / source", "Download", "Verify files", "USB radio"]
        for index in range(3):
            color = ACCENT if self.finished or index < self.phase else "#304058"
            canvas.create_line(points[index] + 17, 19, points[index + 1] - 17, 19, fill=color, width=2)
        for index, x in enumerate(points):
            done = self.finished or index < self.phase
            active = self.busy and index == self.phase
            color = ACCENT if done or active else "#304058"
            canvas.create_oval(x - 13, 6, x + 13, 32, fill=color if done else PANEL, outline=color, width=2)
            canvas.create_text(x, 19, text="✓" if done else str(index + 1), fill=BG if done else color, font=("Segoe UI", 11, "bold"))
            canvas.create_text(x, 49, text=labels[index], fill=TEXT if done or active else MUTED, font=("Segoe UI", 10))
        if self.busy and self.phase >= 0:
            index = min(self.phase, 2)
            x = points[index] + 18 + (points[index + 1] - points[index] - 36) * ((self.tick % 35) / 35)
            canvas.create_oval(x - 4, 15, x + 4, 23, fill=BLUE, outline="")

    def animate(self):
        self.tick += 1
        if self.busy:
            self.draw_pipeline()
        self.after(70, self.animate)

    def report(self, stage, text, current, total):
        self.events.put(("progress", (stage, text, current, total)))

    def log_line(self, text):
        self.log.configure(state="normal")
        self.log.insert("end", text + "\n")
        self.log.see("end")
        self.log.configure(state="disabled")

    def run_worker(self, operation, kind):
        if self.busy:
            return
        self.busy = True
        self.finished = False
        self.phase = 0
        self.progress.set(0)
        for widget in (self.install_button, self.refresh_button, self.scan_button, self.browse_button, self.drive_menu):
            widget.configure(state="disabled")
        def work():
            try:
                self.events.put((kind, operation()))
            except Exception as error:
                self.events.put(("error", (kind, str(error))))
        threading.Thread(target=work, daemon=True).start()

    def finish_worker(self):
        self.busy = False
        for widget in (self.refresh_button, self.scan_button, self.browse_button, self.drive_menu):
            widget.configure(state="normal")
        self.update_selection()
        self.draw_pipeline()

    def process_events(self):
        try:
            while True:
                kind, data = self.events.get_nowait()
                if kind == "progress":
                    stage, text, current, total = data
                    self.phase = STAGES.index(stage)
                    self.progress.set((self.phase + min(1, current / total if total else 0)) / 4)
                    self.status_label.configure(text=text, text_color=MUTED)
                    self.log_line(text)
                elif kind == "catalog":
                    if data["themes"] is not None:
                        self.show_catalog(data["themes"])
                    if data["scripts"] is not None:
                        self.script_packages = data["scripts"]
                        self.render_scripts()
                        self.script_source_label.configure(text="KevinD RC · live GitHub catalog")
                    for error in data["errors"]:
                        self.log_line(error)
                    self.status_label.configure(text="GitHub refresh complete." if not data["errors"] else "Some GitHub checks failed. Current catalogs remain available.", text_color=ACCENT if not data["errors"] else "#f3c47b")
                    self.progress.set(0)
                    self.phase = -1
                    self.finish_worker()
                elif kind == "installed":
                    self.finished = True
                    self.progress.set(1)
                    self.finish_worker()
                    self.status_label.configure(text="Complete · Eject the drive, disconnect and restart your radio.", text_color=ACCENT)
                    self.log_line("Selected packages installed. Replaced package files were deleted; no backup was saved.")
                    message = "Your selected packages are installed.\n\nEject the USB drive in Windows, disconnect and restart the radio."
                    if data["themes"]:
                        message += "\n\nThemes: System → General → Theme."
                    if data["wizard"]:
                        message += "\n\nHeli Wizard: on Ethos 26.2, open Model → Model select → + → Create model → Heli Wizard. On older firmware, open System → Heli Wizard."
                        message += "\nBefore use, turn OFF System → Sticks → First four channels fixed."
                    others = [name for name in data["scripts"] if name != WIZARD.name]
                    if others:
                        message += "\n\nScript packages installed: " + ", ".join(others) + ". See each repository's usage instructions."
                    message += "\n\nReplaced package files were deleted. No backup was saved."
                    self.show_dialog("Packages installed", message)
                elif kind == "error":
                    operation, error = data
                    self.phase = -1
                    self.finish_worker()
                    if operation == "catalog" and self.catalog:
                        text = "GitHub unavailable · Keeping the current catalog. " + error
                        self.status_label.configure(text="GitHub unavailable. Current catalog remains available.", text_color="#f3c47b")
                        self.log_line(text)
                    else:
                        self.status_label.configure(text="Transfer stopped · See activity log for details.", text_color="#ff8a95")
                        self.log_line(error)
                        self.show_dialog("Unable to complete transfer", error, error=True)
        except queue.Empty:
            pass
        self.after(100, self.process_events)

    def load_bundled(self):
        try:
            self.show_catalog(Catalog.from_folder(bundled_themes()))
        except Exception as error:
            self.log_line(f"Bundled catalog unavailable: {error}")

    def refresh(self):
        def operation():
            result = {"themes": None, "scripts": None, "errors": []}
            for key, fetch in (("themes", lambda: Catalog.from_github(self.report)), ("scripts", lambda: remote_packages(self.report))):
                try:
                    result[key] = fetch()
                except Exception as error:
                    result["errors"].append(f"{key.title()} catalog: {error}")
            return result
        self.run_worker(operation, "catalog")

    def rescan(self):
        roots = [str(root) for root in detect_radios()]
        current = self.drive.get()
        if current and is_radio_root(Path(current)) and current not in roots:
            roots.append(current)
        self.drive_menu.configure(values=roots or ["No radio detected"])
        self.drive.set(current if current in roots else roots[0] if roots else "No radio detected")
        self.drive_hint.configure(text="Ethos storage found · Ready to install" if roots else "Connect via USB and choose storage mode on the radio.")
        self.update_selection()

    def browse(self):
        folder = filedialog.askdirectory(title="Select Ethos storage root (contains radio.bin and models)")
        if folder:
            if not is_radio_root(Path(folder)):
                self.show_dialog("Choose Ethos storage", "Select the root folder containing radio.bin and the models folder.\nConnect the radio in USB storage mode.", error=True)
                return
            self.drive.set(folder)
            self.rescan()

    def select_all(self, value):
        for variable in self.choices.values():
            variable.set(value)
        if not value:
            for variable in self.script_choices.values():
                variable.set(False)
        self.update_selection()

    def update_selection(self):
        count = sum(variable.get() for variable in self.choices.values())
        scripts = sum(variable.get() for variable in self.script_choices.values())
        self.selection_label.configure(text=f"{count} themes · {scripts} script packages selected")
        self.install_button.configure(state="normal" if (count or scripts) and not self.busy and is_radio_root(Path(self.drive.get())) else "disabled")

    def start_install(self):
        if self.busy:
            return
        keys = [key for key, variable in self.choices.items() if variable.get()]
        selected_scripts = [p for p in self.script_packages if self.script_choices[p.identity].get()]
        include_wizard = any(p.identity == WIZARD.identity for p in selected_scripts)
        root = Path(self.drive.get())
        if not (keys or selected_scripts) or not is_radio_root(root):
            self.rescan()
            return
        names = [theme.name for theme in self.catalog.themes if theme.key in keys] if self.catalog else []
        text = "Install selected packages:\n"
        if keys:
            text += f"\nThemes → {root / 'scripts' / 'Themes'}\n" + ", ".join(names)
        for package in selected_scripts:
            names.append(package.name)
            text += f"\n\n{package.name} → {root / 'scripts' / package.folder}"
        if include_wizard:
            if (root / "scripts/rfsuite/lib/register_model_wizard.lua").is_file():
                text += "\nYour RF Suite wizard registration takes precedence over the standalone wizard."
        text += "\n\nOnly the selected package folders are replaced. Old package files will be deleted. No backup is saved. Ethos 26.x required. Continue?"
        if not self.show_dialog("Install selected packages", text, confirm=True):
            return
        catalog = self.catalog
        self.log_line(f"Install requested: {', '.join(names)} → {root}")
        def operation():
            self.report("connect", f"Connected storage: {root}", 1, 1)
            theme_package = catalog.files(keys, self.report) if keys else None
            script_downloads = [(package, package_files(package, self.report)) for package in selected_scripts]
            completed = []
            try:
                if theme_package:
                    install(root, theme_package, self.report)
                    completed.append("Themes")
                for package, files in script_downloads:
                    install(root, files, self.report, folder=package.folder)
                    completed.append(package.name)
            except Exception as error:
                if completed:
                    raise OSError(f"Already installed: {', '.join(completed)}. Remaining package failed: {error}") from error
                raise
            return {"themes": bool(keys), "wizard": include_wizard, "scripts": [p.name for p in selected_scripts]}
        self.run_worker(operation, "installed")

    def close_app(self):
        if self.busy:
            self.show_dialog("Transfer in progress", "Please let the current transfer finish before closing the app.")
            return
        self.destroy()

    def show_dialog(self, title, message, *, confirm=False, error=False):
        dialog = ctk.CTkToplevel(self)
        dialog.withdraw()
        dialog.title(title)
        dialog.configure(fg_color=BG)
        dialog.resizable(False, False)
        dialog.transient(self)
        dialog.grid_columnconfigure(0, weight=1)
        result = False

        def finish(accepted=False):
            nonlocal result
            result = accepted
            dialog.grab_release()
            dialog.destroy()

        self.label(dialog, "THEME STUDIO FOR ETHOS", 12, ACCENT, True).grid(row=0, column=0, sticky="w", padx=26, pady=(22, 8))
        self.label(dialog, title, 23, "#ff8a95" if error else TEXT, True).grid(row=1, column=0, sticky="w", padx=26, pady=(0, 14))
        content = ctk.CTkFrame(dialog, fg_color=PANEL, corner_radius=12)
        content.grid(row=2, column=0, sticky="ew", padx=22)
        self.label(content, message, 14, TEXT, wraplength=490, justify="left", anchor="w").pack(padx=18, pady=18, fill="x")
        actions = ctk.CTkFrame(dialog, fg_color="transparent")
        actions.grid(row=3, column=0, sticky="e", padx=24, pady=20)
        if confirm:
            self.button(actions, "Cancel", lambda: finish(False), width=100).pack(side="left", padx=(0, 10))
        self.button(actions, "Install packages" if confirm else "OK", lambda: finish(True), primary=True, width=140 if confirm else 100).pack(side="left")
        dialog.protocol("WM_DELETE_WINDOW", lambda: finish(False))
        dialog.bind("<Escape>", lambda event: finish(False))
        dialog.bind("<Return>", lambda event: finish(True))
        dialog.update_idletasks()
        width, height = max(570, dialog.winfo_reqwidth()), dialog.winfo_reqheight()
        x = max(0, min(self.winfo_rootx() + (self.winfo_width() - width) // 2, self.winfo_screenwidth() - width))
        y = max(0, min(self.winfo_rooty() + (self.winfo_height() - height) // 2, self.winfo_screenheight() - height - 40))
        dialog.geometry(f"{width}x{height}+{x}+{y}")
        dialog.deiconify()
        dialog.after(250, lambda: dialog.iconbitmap(str(studio_assets() / "kevindrc.ico")) if dialog.winfo_exists() else None)
        dialog.wait_visibility()
        dialog.grab_set()
        dialog.focus_set()
        self.wait_window(dialog)
        return result


if __name__ == "__main__":
    ctk.set_appearance_mode("dark")
    ctk.set_default_color_theme("blue")
    App().mainloop()
