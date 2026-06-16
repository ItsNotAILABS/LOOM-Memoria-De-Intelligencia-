"""
THE WORLD Surface — PHI Geometry and Schumann Lighting
=======================================================
The World surface displays global system state with:
- PHI-based sacred geometry visualization
- Schumann-frequency synchronized lighting
- Torus memory topology representation
- Real-time organism state mapping

Geometric Elements:
- Golden spiral for memory navigation
- Flower of Life pattern overlay
- Torus cross-section view
- PHI-proportioned grid system
"""

from __future__ import annotations

import math
import time
from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional, Tuple

from .constants import (
    PHI,
    PHI_SQUARED,
    GOLDEN_ANGLE,
    SCHUMANN_BASE,
    SCHUMANN_HARMONICS,
    GLASS_COLORS,
)


@dataclass
class WorldGeometry:
    """
    PHI-based sacred geometry configuration.
    
    Defines the geometric elements used in THE WORLD surface.
    """
    
    # Torus parameters
    torus_major_radius: float = PHI * 100  # Major radius R
    torus_minor_radius: float = 100.0 / PHI  # Minor radius r
    
    # Golden spiral
    spiral_growth_rate: float = PHI
    spiral_turns: int = 7  # Number of turns
    spiral_resolution: int = 100  # Points per turn
    
    # Flower of Life
    flower_circles: int = 19  # Standard Flower of Life
    flower_radius: float = 50.0
    
    # Grid
    grid_phi_ratio: bool = True
    grid_columns: int = int(PHI * 10)  # ~16 columns
    grid_rows: int = 10
    
    def generate_golden_spiral(self) -> List[Tuple[float, float]]:
        """
        Generate points for a golden spiral.
        
        r(θ) = a * φ^(θ/90°)
        """
        points = []
        total_points = self.spiral_turns * self.spiral_resolution
        
        for i in range(total_points):
            theta = (i / self.spiral_resolution) * (math.pi / 2)  # 90° per quarter turn
            r = self.flower_radius * (self.spiral_growth_rate ** (theta / (math.pi / 2)))
            x = r * math.cos(theta * 4)  # 4 = full rotation per turn
            y = r * math.sin(theta * 4)
            points.append((x, y))
        
        return points
    
    def generate_flower_of_life(self) -> List[Dict[str, float]]:
        """
        Generate circles for Flower of Life pattern.
        
        Standard pattern: 1 center + 6 around + 12 outer = 19 circles
        """
        circles = []
        r = self.flower_radius
        
        # Center circle
        circles.append({"cx": 0, "cy": 0, "r": r})
        
        # First ring (6 circles)
        for i in range(6):
            angle = i * (math.pi / 3)
            cx = r * math.cos(angle)
            cy = r * math.sin(angle)
            circles.append({"cx": cx, "cy": cy, "r": r})
        
        # Second ring (12 circles)
        for i in range(12):
            angle = i * (math.pi / 6)
            distance = r * math.sqrt(3)
            cx = distance * math.cos(angle)
            cy = distance * math.sin(angle)
            circles.append({"cx": cx, "cy": cy, "r": r})
        
        return circles[:self.flower_circles]
    
    def torus_point(
        self,
        theta: float,
        phi: float,
    ) -> Tuple[float, float, float]:
        """
        Calculate 3D point on torus surface.
        
        x = (R + r*cos(θ)) * cos(φ)
        y = (R + r*cos(θ)) * sin(φ)
        z = r * sin(θ)
        """
        R = self.torus_major_radius
        r = self.torus_minor_radius
        
        x = (R + r * math.cos(theta)) * math.cos(phi)
        y = (R + r * math.cos(theta)) * math.sin(phi)
        z = r * math.sin(theta)
        
        return (x, y, z)
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "torus": {
                "major_radius": self.torus_major_radius,
                "minor_radius": self.torus_minor_radius,
            },
            "spiral": {
                "growth_rate": self.spiral_growth_rate,
                "turns": self.spiral_turns,
            },
            "flower": {
                "circles": self.flower_circles,
                "radius": self.flower_radius,
            },
            "grid": {
                "columns": self.grid_columns,
                "rows": self.grid_rows,
            },
        }


@dataclass
class SchumannLighting:
    """
    Schumann-frequency synchronized lighting system.
    
    The lighting cycles at Earth's electromagnetic resonance
    frequency (7.83 Hz base) to create harmonic visual effects.
    """
    
    # Current state
    current_phase: float = 0.0
    current_harmonic: int = 0
    
    # Configuration
    base_frequency: float = SCHUMANN_BASE
    enabled_harmonics: List[int] = field(default_factory=lambda: [0, 1, 2])
    
    # Colors
    primary_color: str = GLASS_COLORS["primary"]
    secondary_color: str = GLASS_COLORS["secondary"]
    accent_color: str = GLASS_COLORS["accent"]
    
    # Intensity
    base_intensity: float = 0.5
    pulse_amplitude: float = 0.3
    
    def tick(self, dt: float) -> Dict[str, Any]:
        """
        Update lighting state by dt seconds.
        
        Returns current lighting values.
        """
        # Advance phase
        self.current_phase += 2 * math.pi * self.base_frequency * dt
        self.current_phase %= (2 * math.pi)
        
        # Calculate intensities for each harmonic
        intensities = {}
        for i, harmonic in enumerate(self.enabled_harmonics):
            freq = SCHUMANN_HARMONICS[harmonic] if harmonic < len(SCHUMANN_HARMONICS) else self.base_frequency
            phase = self.current_phase * (freq / self.base_frequency)
            intensity = self.base_intensity + self.pulse_amplitude * math.sin(phase)
            intensities[f"harmonic_{harmonic}"] = max(0, min(1, intensity))
        
        return {
            "phase": self.current_phase,
            "intensities": intensities,
            "primary_intensity": intensities.get("harmonic_0", self.base_intensity),
        }
    
    def get_color_at_phase(self, phase_offset: float = 0.0) -> str:
        """
        Get color at current phase with optional offset.
        
        Interpolates between primary and secondary based on phase.
        """
        phase = (self.current_phase + phase_offset) % (2 * math.pi)
        t = (math.sin(phase) + 1) / 2  # Normalize to [0, 1]
        
        # Simple interpolation indicator
        return f"interpolate({self.primary_color}, {self.secondary_color}, {t:.3f})"
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "current_phase": round(self.current_phase, 4),
            "current_harmonic": self.current_harmonic,
            "base_frequency": self.base_frequency,
            "enabled_harmonics": self.enabled_harmonics,
            "base_intensity": self.base_intensity,
            "pulse_amplitude": self.pulse_amplitude,
        }


@dataclass
class TheWorldSurface:
    """
    THE WORLD Surface — Global system visualization.
    
    Features:
    - PHI geometry overlays
    - Schumann-frequency lighting
    - Torus memory visualization
    - Real-time organism state
    """
    
    # Configuration
    enabled: bool = True
    name: str = "THE WORLD"
    
    # Geometry
    geometry: WorldGeometry = field(default_factory=WorldGeometry)
    
    # Lighting
    lighting: SchumannLighting = field(default_factory=SchumannLighting)
    
    # View state
    camera_theta: float = 0.0
    camera_phi: float = 0.0
    camera_distance: float = PHI * 200
    
    # Organism display
    organism_positions: Dict[str, Tuple[float, float, float]] = field(default_factory=dict)
    highlighted_organism: Optional[str] = None
    
    # Time
    created_at: float = field(default_factory=time.time)
    last_update: float = field(default_factory=time.time)
    
    def update(self, dt: float) -> Dict[str, Any]:
        """
        Update surface state.
        
        Returns:
            Updated state for rendering
        """
        # Update lighting
        lighting_state = self.lighting.tick(dt)
        
        # Rotate camera slowly
        self.camera_theta += 0.01 * dt
        self.camera_phi += 0.005 * dt
        
        self.last_update = time.time()
        
        return {
            "lighting": lighting_state,
            "camera": {
                "theta": self.camera_theta,
                "phi": self.camera_phi,
                "distance": self.camera_distance,
            },
            "organisms": self.organism_positions,
        }
    
    def set_organism_position(
        self,
        organism_id: str,
        theta: float,
        phi: float,
        depth: float = 1.0,
    ) -> None:
        """Set organism position on torus."""
        x, y, z = self.geometry.torus_point(theta, phi)
        self.organism_positions[organism_id] = (x * depth, y * depth, z * depth)
    
    def highlight_organism(self, organism_id: str) -> None:
        """Highlight an organism."""
        self.highlighted_organism = organism_id
    
    def render_config(self) -> Dict[str, Any]:
        """Get configuration for frontend rendering."""
        return {
            "name": self.name,
            "enabled": self.enabled,
            "geometry": self.geometry.to_dict(),
            "lighting": self.lighting.to_dict(),
            "camera": {
                "theta": self.camera_theta,
                "phi": self.camera_phi,
                "distance": self.camera_distance,
            },
            "spiral_points": len(self.geometry.generate_golden_spiral()),
            "flower_circles": len(self.geometry.generate_flower_of_life()),
        }
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "enabled": self.enabled,
            "config": self.render_config(),
            "organisms_count": len(self.organism_positions),
            "highlighted": self.highlighted_organism,
            "created_at": self.created_at,
            "last_update": self.last_update,
        }
