"""
UX AI — Theme Engine (PROT-585)
Dynamic theming with phi-harmonic color theory and adaptive palettes.
"""

from __future__ import annotations
from typing import Any, Dict, List, Optional, Tuple
from dataclasses import dataclass, field
import math

PHI: float = 1.6180339887498948482


@dataclass
class ColorHSL:
    """Color in HSL space."""
    h: float  # 0-360
    s: float  # 0-100
    l: float  # 0-100

    def to_hex(self) -> str:
        """Convert HSL to hex."""
        h, s, l = self.h / 360, self.s / 100, self.l / 100
        if s == 0:
            r = g = b = l
        else:
            def hue_to_rgb(p, q, t):
                if t < 0: t += 1
                if t > 1: t -= 1
                if t < 1/6: return p + (q - p) * 6 * t
                if t < 1/2: return q
                if t < 2/3: return p + (q - p) * (2/3 - t) * 6
                return p
            q = l * (1 + s) if l < 0.5 else l + s - l * s
            p = 2 * l - q
            r = hue_to_rgb(p, q, h + 1/3)
            g = hue_to_rgb(p, q, h)
            b = hue_to_rgb(p, q, h - 1/3)
        return f"#{int(r*255):02x}{int(g*255):02x}{int(b*255):02x}"

    def to_css(self) -> str:
        return f"hsl({self.h:.0f}, {self.s:.0f}%, {self.l:.0f}%)"


@dataclass
class ThemePalette:
    """A complete theme color palette."""
    name: str
    primary: ColorHSL
    secondary: ColorHSL
    accent: ColorHSL
    background: ColorHSL
    surface: ColorHSL
    text: ColorHSL
    text_secondary: ColorHSL
    success: ColorHSL
    warning: ColorHSL
    error: ColorHSL
    info: ColorHSL


class ThemeEngine:
    """
    Dynamic Theme Engine — PROT-585
    Generates harmonious color palettes using golden angle distribution.
    """

    GOLDEN_ANGLE = 360 / (PHI * PHI)  # ~137.5°

    def __init__(self):
        self.palettes: Dict[str, ThemePalette] = {}
        self._init_default_palettes()

    def _init_default_palettes(self):
        """Initialize sovereign default palettes."""
        self.palettes["sovereign-dark"] = ThemePalette(
            name="sovereign-dark",
            primary=ColorHSL(42, 55, 57),      # Gold #c9a55c
            secondary=ColorHSL(262, 83, 58),   # Purple #8b5cf6
            accent=ColorHSL(160, 84, 39),      # Emerald #10b981
            background=ColorHSL(240, 25, 4),   # Deep dark #0a0a0f
            surface=ColorHSL(240, 20, 9),      # Surface #12121a
            text=ColorHSL(0, 0, 90),           # Light text #e5e5e5
            text_secondary=ColorHSL(0, 0, 53), # Muted #888
            success=ColorHSL(160, 84, 39),     # Green
            warning=ColorHSL(38, 92, 50),      # Amber
            error=ColorHSL(0, 84, 60),         # Red
            info=ColorHSL(217, 91, 60),        # Blue
        )

        self.palettes["sovereign-light"] = ThemePalette(
            name="sovereign-light",
            primary=ColorHSL(42, 55, 40),
            secondary=ColorHSL(262, 83, 45),
            accent=ColorHSL(160, 84, 30),
            background=ColorHSL(0, 0, 98),
            surface=ColorHSL(0, 0, 100),
            text=ColorHSL(0, 0, 10),
            text_secondary=ColorHSL(0, 0, 40),
            success=ColorHSL(160, 84, 30),
            warning=ColorHSL(38, 92, 40),
            error=ColorHSL(0, 84, 50),
            info=ColorHSL(217, 91, 50),
        )

    def generate_phi_palette(self, base_hue: float, mode: str = "dark") -> ThemePalette:
        """Generate a complete palette from a base hue using golden angle."""
        hues = []
        h = base_hue
        for _ in range(6):
            hues.append(h % 360)
            h += self.GOLDEN_ANGLE

        if mode == "dark":
            return ThemePalette(
                name=f"phi-{int(base_hue)}-dark",
                primary=ColorHSL(hues[0], 70, 55),
                secondary=ColorHSL(hues[1], 75, 55),
                accent=ColorHSL(hues[2], 80, 45),
                background=ColorHSL(hues[0], 20, 5),
                surface=ColorHSL(hues[0], 15, 10),
                text=ColorHSL(0, 0, 90),
                text_secondary=ColorHSL(0, 0, 55),
                success=ColorHSL(hues[3], 75, 40),
                warning=ColorHSL(hues[4], 85, 50),
                error=ColorHSL(0, 80, 55),
                info=ColorHSL(hues[5], 80, 55),
            )
        else:
            return ThemePalette(
                name=f"phi-{int(base_hue)}-light",
                primary=ColorHSL(hues[0], 70, 40),
                secondary=ColorHSL(hues[1], 75, 40),
                accent=ColorHSL(hues[2], 80, 35),
                background=ColorHSL(0, 0, 98),
                surface=ColorHSL(0, 0, 100),
                text=ColorHSL(0, 0, 10),
                text_secondary=ColorHSL(0, 0, 40),
                success=ColorHSL(hues[3], 75, 35),
                warning=ColorHSL(hues[4], 85, 40),
                error=ColorHSL(0, 80, 45),
                info=ColorHSL(hues[5], 80, 45),
            )

    def export_css(self, palette_name: str) -> str:
        """Export a palette as CSS custom properties."""
        palette = self.palettes.get(palette_name)
        if not palette:
            return ""

        fields = [
            ("primary", palette.primary),
            ("secondary", palette.secondary),
            ("accent", palette.accent),
            ("bg", palette.background),
            ("surface", palette.surface),
            ("text", palette.text),
            ("text-secondary", palette.text_secondary),
            ("success", palette.success),
            ("warning", palette.warning),
            ("error", palette.error),
            ("info", palette.info),
        ]

        lines = [f"/* Theme: {palette.name} */", ":root {"]
        for name, color in fields:
            lines.append(f"  --color-{name}: {color.to_hex()};")
            lines.append(f"  --color-{name}-hsl: {color.to_css()};")
        lines.append("}")

        return "\n".join(lines)

    def get_contrast_ratio(self, fg: ColorHSL, bg: ColorHSL) -> float:
        """Calculate WCAG contrast ratio between two colors."""
        def relative_luminance(color: ColorHSL) -> float:
            # Approximate from lightness
            l = color.l / 100
            return l * l  # Simplified approximation

        l1 = relative_luminance(fg)
        l2 = relative_luminance(bg)
        lighter = max(l1, l2)
        darker = min(l1, l2)
        return (lighter + 0.05) / (darker + 0.05)

    def ensure_wcag_aa(self, palette: ThemePalette) -> Dict[str, bool]:
        """Check if palette meets WCAG AA contrast requirements."""
        checks = {
            "text_on_bg": self.get_contrast_ratio(palette.text, palette.background) >= 4.5,
            "text_on_surface": self.get_contrast_ratio(palette.text, palette.surface) >= 4.5,
            "secondary_on_bg": self.get_contrast_ratio(palette.text_secondary, palette.background) >= 3.0,
        }
        return checks

    def status(self) -> Dict[str, Any]:
        return {
            "protocol": "PROT-585",
            "palettes_registered": len(self.palettes),
            "golden_angle": self.GOLDEN_ANGLE,
            "palette_names": list(self.palettes.keys()),
        }


# Singleton
theme_engine = ThemeEngine()

__all__ = ["ThemeEngine", "ThemePalette", "ColorHSL", "theme_engine"]
