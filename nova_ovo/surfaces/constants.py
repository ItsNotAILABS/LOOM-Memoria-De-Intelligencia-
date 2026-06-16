"""
Design Constants — PHI Geometry, Schumann, Glassmorphism
=========================================================
Foundational constants for all UI surfaces.

PHI Geometry:
- Golden ratio for all proportions and scaling
- Golden angle for spiral layouts
- PHI-based spacing and sizing

Schumann Frequencies:
- Base: 7.83 Hz (Earth's electromagnetic resonance)
- Harmonics: 14.3, 20.8, 27.3, 33.8 Hz
- Used for lighting cycles and animations

Glassmorphism:
- Blur, opacity, border radius constants
- Color palette with transparency
- Full UI redesign system
"""

import math

# ============================================================================ #
# PHI GEOMETRY                                                                   #
# ============================================================================ #

# Golden Ratio φ = (1 + √5) / 2
PHI = (1 + math.sqrt(5)) / 2  # ≈ 1.6180339887

# PHI powers
PHI_SQUARED = PHI ** 2        # ≈ 2.618
PHI_CUBED = PHI ** 3          # ≈ 4.236
PHI_INVERSE = 1 / PHI         # ≈ 0.618 (also PHI - 1)

# Golden Angle (radians) — for spiral arrangements
GOLDEN_ANGLE = 2 * math.pi / (PHI ** 2)  # ≈ 137.5°

# PHI-based spacing scale (for UI)
PHI_SPACING = {
    "xs": 4,
    "sm": round(4 * PHI),      # 6
    "md": round(4 * PHI ** 2),  # 10
    "lg": round(4 * PHI ** 3),  # 17
    "xl": round(4 * PHI ** 4),  # 28
    "2xl": round(4 * PHI ** 5), # 45
    "3xl": round(4 * PHI ** 6), # 73
}

# PHI-based font scale
PHI_FONT_SCALE = {
    "xs": 10,
    "sm": round(10 * PHI_INVERSE),  # 6
    "base": 10,
    "md": round(10 * PHI),          # 16
    "lg": round(10 * PHI ** 2),     # 26
    "xl": round(10 * PHI ** 3),     # 42
    "2xl": round(10 * PHI ** 4),    # 68
}

# ============================================================================ #
# SCHUMANN FREQUENCIES                                                           #
# ============================================================================ #

# Earth's electromagnetic resonance base frequency
SCHUMANN_BASE = 7.83  # Hz

# Schumann harmonics
SCHUMANN_HARMONICS = [
    7.83,   # 1st harmonic (base)
    14.3,   # 2nd harmonic
    20.8,   # 3rd harmonic
    27.3,   # 4th harmonic
    33.8,   # 5th harmonic
    39.0,   # 6th harmonic
    45.0,   # 7th harmonic
]

# Animation timing based on Schumann (in milliseconds)
SCHUMANN_TIMING = {
    "slow": round(1000 / SCHUMANN_BASE * 4),      # ~512ms
    "normal": round(1000 / SCHUMANN_BASE * 2),    # ~256ms
    "fast": round(1000 / SCHUMANN_BASE),          # ~128ms
    "instant": round(1000 / SCHUMANN_BASE / 2),   # ~64ms
}

# ============================================================================ #
# GLASSMORPHISM DESIGN SYSTEM                                                    #
# ============================================================================ #

# Blur values (CSS backdrop-filter: blur)
GLASS_BLUR = {
    "none": "0px",
    "sm": "4px",
    "md": "8px",
    "lg": "12px",
    "xl": "16px",
    "2xl": "24px",
    "3xl": "40px",
}

# Opacity values for glass effect
GLASS_OPACITY = {
    "transparent": 0.0,
    "very_light": 0.1,
    "light": 0.2,
    "medium": 0.4,
    "heavy": 0.6,
    "opaque": 0.8,
}

# Border radius
GLASS_BORDER = {
    "none": "0px",
    "sm": "4px",
    "md": "8px",
    "lg": "16px",
    "xl": "24px",
    "2xl": "32px",
    "full": "9999px",
}

# Color palette with transparency (RGBA)
GLASS_COLORS = {
    # Primary
    "primary": "rgba(59, 130, 246, 0.8)",        # Blue
    "primary_light": "rgba(96, 165, 250, 0.6)",
    "primary_dark": "rgba(30, 64, 175, 0.9)",
    
    # Secondary
    "secondary": "rgba(168, 85, 247, 0.8)",      # Purple
    "secondary_light": "rgba(192, 132, 252, 0.6)",
    "secondary_dark": "rgba(107, 33, 168, 0.9)",
    
    # Accent (Golden/PHI)
    "accent": "rgba(251, 191, 36, 0.8)",         # Amber/Gold
    "accent_light": "rgba(253, 224, 71, 0.6)",
    "accent_dark": "rgba(180, 83, 9, 0.9)",
    
    # Neutral
    "background": "rgba(15, 23, 42, 0.7)",       # Slate dark
    "surface": "rgba(30, 41, 59, 0.6)",
    "card": "rgba(51, 65, 85, 0.5)",
    
    # Semantic
    "success": "rgba(34, 197, 94, 0.8)",         # Green
    "warning": "rgba(250, 204, 21, 0.8)",        # Yellow
    "error": "rgba(239, 68, 68, 0.8)",           # Red
    "info": "rgba(59, 130, 246, 0.8)",           # Blue
    
    # Text
    "text_primary": "rgba(248, 250, 252, 1.0)",
    "text_secondary": "rgba(203, 213, 225, 0.9)",
    "text_muted": "rgba(148, 163, 184, 0.7)",
    
    # Glass effects
    "glass_white": "rgba(255, 255, 255, 0.1)",
    "glass_black": "rgba(0, 0, 0, 0.2)",
    "glass_border": "rgba(255, 255, 255, 0.2)",
}

# Shadow system
GLASS_SHADOWS = {
    "none": "none",
    "sm": "0 1px 2px 0 rgba(0, 0, 0, 0.05)",
    "md": "0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1)",
    "lg": "0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1)",
    "xl": "0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1)",
    "glow": "0 0 20px rgba(59, 130, 246, 0.5)",
    "glow_gold": "0 0 20px rgba(251, 191, 36, 0.5)",
}

# ============================================================================ #
# SURFACE FEATURE FLAGS                                                          #
# ============================================================================ #

SURFACE_FLAGS = {
    "the_world": True,
    "designer_hub": True,
    "forma_leaderboard": True,
    "architecture_stack": True,
    "glassmorphism": True,
}


def is_surface_enabled(surface_name: str) -> bool:
    """Check if a surface is enabled."""
    return SURFACE_FLAGS.get(surface_name, False)
