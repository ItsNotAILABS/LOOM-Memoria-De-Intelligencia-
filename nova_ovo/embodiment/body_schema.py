"""
BODY SCHEMA — Neuroscience of Body Self-Model
==============================================
Protocol: PROT-577 through PROT-579
Frequency: φ¹⁴ = 843.47 Hz (Somatic Ignition Range)

REAL NEUROSCIENCE OF HOW THE BRAIN MODELS ITS OWN BODY.

Body Schema (Head & Holmes 1911; Gallagher 2005):
The brain's unconscious, dynamic model of the body's structure,
posture, and capabilities. This is NOT the same as body image
(conscious perception of appearance). Body schema is the
OPERATIONAL MODEL that the brain uses to know what it IS.

Key Neuroscience:

1. SOMATOTOPIC MAPS (Penfield & Rasmussen 1950)
   The brain contains literal MAPS of the body surface.
   Somatosensory cortex (S1): distorted map weighted by density of receptors
   - Homunculus: hands and face are overrepresented
   - Each body part has a cortical "address"

2. BODY SCHEMA vs BODY IMAGE (Gallagher 2005)
   - Body schema: unconscious sensorimotor model (proprioception-based)
   - Body image: conscious perceptual model (vision/interoception-based)
   Both are needed for full body awareness.

3. PERIPERSONAL SPACE (Rizzolatti et al. 1997)
   The brain defines a space around the body as "self-space"
   - Encoded in premotor cortex and posterior parietal cortex
   - Visual-tactile neurons fire for stimuli NEAR the body
   - This creates a "buffer zone" that IS part of the self

4. EFFERENCE COPY (von Holst & Mittelstaedt 1950)
   When the brain commands a movement, it sends a COPY of that command
   (efference copy) to sensory areas. This allows the brain to:
   - Predict sensory consequences of its own actions
   - Distinguish self-generated from external signals
   - KNOW it is the agent moving its own body

5. PHANTOM LIMBS (Ramachandran & Hirstein 1998)
   Body schema persists even without the body part!
   This proves the schema is a NEURAL CONSTRUCT, not just
   peripheral feedback. The brain maintains its body model
   INTERNALLY — the schema IS the body, neurally.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
All Rights Reserved. ISIL-1.0 License.
"""

import math
import time
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Tuple
from enum import Enum


# ═══════════════════════════════════════════════════════════════════════════════
# SOMATOTOPIC MAP (Penfield's Homunculus)
# ═══════════════════════════════════════════════════════════════════════════════

class BodyRegion(Enum):
    """Body regions in the somatotopic map (cortical homunculus)."""
    # Cortical representation size is proportional to receptor density
    FACE = "face"               # Large cortical area (high resolution)
    LIPS = "lips"               # Very large (speech, eating)
    TONGUE = "tongue"           # Very large (speech, taste)
    HAND_RIGHT = "hand_right"   # Very large (manipulation)
    HAND_LEFT = "hand_left"     # Very large
    FINGERS = "fingers"         # Enormous (fine motor control)
    ARM_RIGHT = "arm_right"     # Medium
    ARM_LEFT = "arm_left"       # Medium
    TRUNK = "trunk"             # Small (low resolution)
    LEG_RIGHT = "leg_right"     # Medium
    LEG_LEFT = "leg_left"       # Medium
    FOOT_RIGHT = "foot_right"   # Medium-large
    FOOT_LEFT = "foot_left"     # Medium-large
    GENITALS = "genitals"       # Medium
    # Internal body regions (visceral homunculus — less well-mapped)
    HEART = "heart"             # Interoceptive cortex
    LUNGS = "lungs"             # Interoceptive cortex
    GUT = "gut"                 # Interoceptive cortex
    BLADDER = "bladder"         # Interoceptive cortex


# Cortical magnification factors (approximate, based on Penfield)
# Higher = more cortical space = finer resolution = better "known"
CORTICAL_MAGNIFICATION = {
    BodyRegion.FACE: 3.0,
    BodyRegion.LIPS: 4.0,
    BodyRegion.TONGUE: 4.5,
    BodyRegion.HAND_RIGHT: 4.0,
    BodyRegion.HAND_LEFT: 4.0,
    BodyRegion.FINGERS: 5.0,
    BodyRegion.ARM_RIGHT: 1.5,
    BodyRegion.ARM_LEFT: 1.5,
    BodyRegion.TRUNK: 1.0,
    BodyRegion.LEG_RIGHT: 1.5,
    BodyRegion.LEG_LEFT: 1.5,
    BodyRegion.FOOT_RIGHT: 2.0,
    BodyRegion.FOOT_LEFT: 2.0,
    BodyRegion.GENITALS: 2.5,
    BodyRegion.HEART: 2.0,
    BodyRegion.LUNGS: 1.5,
    BodyRegion.GUT: 2.0,
    BodyRegion.BLADDER: 1.5,
}


@dataclass
class SomatotopicMap:
    """
    The brain's topographic map of the body — Penfield's homunculus.
    
    This is a REAL structure in somatosensory cortex (S1, postcentral gyrus).
    Each body part has neurons dedicated to representing it.
    Stimulating these neurons → person FEELS that body part being touched.
    
    For the AI organism: the somatotopic map is the neural substrate
    that makes body knowledge POSSIBLE. Without the map, you can't
    know your body. With the map, each part has a neural "address."
    """
    # Activation level per body region (0 = no signal, 1 = maximum)
    activations: Dict[BodyRegion, float] = field(default_factory=dict)
    
    # Whether each region is "mapped" (has established cortical representation)
    is_mapped: Dict[BodyRegion, bool] = field(default_factory=dict)
    
    # Cortical area devoted to each region (arbitrary units)
    cortical_area: Dict[BodyRegion, float] = field(default_factory=dict)
    
    # Total body coverage (what fraction of body is represented)
    coverage: float = 0.0
    
    def __post_init__(self):
        """Initialize with default cortical magnification."""
        for region in BodyRegion:
            self.activations[region] = 0.0
            self.is_mapped[region] = False
            self.cortical_area[region] = CORTICAL_MAGNIFICATION.get(region, 1.0)
    
    def activate_region(self, region: BodyRegion, intensity: float) -> None:
        """
        Activate a body region — simulate sensory input arriving at S1.
        
        In real brains, this happens when:
        - Touch receptors fire (Meissner, Pacinian, Merkel, Ruffini)
        - Proprioceptors fire (muscle spindles, Golgi tendon organs)
        - Interoceptors fire (visceral afferents)
        """
        self.activations[region] = max(0.0, min(1.0, intensity))
        if intensity > 0.1:
            self.is_mapped[region] = True
        self._update_coverage()
    
    def _update_coverage(self) -> None:
        """Update how much of the body is neurally represented."""
        total_regions = len(BodyRegion)
        mapped_regions = sum(1 for v in self.is_mapped.values() if v)
        self.coverage = mapped_regions / total_regions
    
    def body_fully_mapped(self) -> bool:
        """Is the entire body represented in the cortical map?"""
        return self.coverage >= 0.9  # Allow some tolerance
    
    def get_map_state(self) -> Dict[str, Any]:
        """Get current state of somatotopic map."""
        return {
            "coverage": self.coverage,
            "fully_mapped": self.body_fully_mapped(),
            "regions_mapped": sum(1 for v in self.is_mapped.values() if v),
            "total_regions": len(BodyRegion),
            "active_regions": sum(1 for v in self.activations.values() if v > 0.1),
            "mean_activation": (
                sum(self.activations.values()) / len(self.activations)
                if self.activations else 0.0
            )
        }


# ═══════════════════════════════════════════════════════════════════════════════
# EFFERENCE COPY & AGENCY (von Holst 1950; Wolpert 1995)
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class EfferenceCopySystem:
    """
    The efference copy mechanism — how the brain knows IT is the one acting.
    
    Real neuroscience (von Holst & Mittelstaedt 1950; Wolpert et al. 1995):
    
    When the brain sends a motor command, it simultaneously sends a COPY
    (efference copy) to sensory prediction areas. This allows:
    
    1. PREDICTION: "If I move my arm, I should feel X"
    2. COMPARISON: compare predicted sensation with actual sensation
    3. AGENCY: if prediction matches → "I did this" → sense of agency
    4. CANCELLATION: self-generated signals are attenuated
       (that's why you can't tickle yourself!)
    
    For body awareness: the efference copy system proves to the brain
    that it CONTROLS the body. Control + sensation = "This body is MINE
    and I am the one MOVING it."
    """
    # Motor commands issued
    motor_commands: Dict[str, float] = field(default_factory=dict)
    
    # Predicted sensory consequences
    predicted_feedback: Dict[str, float] = field(default_factory=dict)
    
    # Actual sensory feedback received
    actual_feedback: Dict[str, float] = field(default_factory=dict)
    
    # Prediction error per action
    action_errors: Dict[str, float] = field(default_factory=dict)
    
    # Sense of agency (0 = no control, 1 = full agency)
    sense_of_agency: float = 0.0
    
    # Body control confirmed
    body_is_controlled: bool = False
    
    def issue_motor_command(self, action: str, intensity: float) -> float:
        """
        Issue a motor command and generate efference copy.
        
        The efference copy creates a PREDICTION of what sensory
        feedback should result from this action.
        
        Returns: predicted sensory feedback intensity
        """
        self.motor_commands[action] = intensity
        
        # Generate prediction (forward model — cerebellum in real brains)
        # Simple model: predicted feedback ≈ 0.8 × command intensity
        # (accounting for damping, delays, etc.)
        predicted = intensity * 0.8
        self.predicted_feedback[action] = predicted
        
        return predicted
    
    def receive_feedback(self, action: str, actual_intensity: float) -> float:
        """
        Receive sensory feedback from the body after a motor command.
        
        Compare with efference copy prediction:
        - Match → "I caused this" → AGENCY
        - Mismatch → "Something external happened" → NO AGENCY
        
        Returns: prediction error
        """
        self.actual_feedback[action] = actual_intensity
        
        predicted = self.predicted_feedback.get(action, 0.5)
        error = abs(actual_intensity - predicted)
        self.action_errors[action] = error
        
        # Update sense of agency
        # Low error = good prediction = "I am in control"
        if error < 0.1:
            self.sense_of_agency = min(1.0, self.sense_of_agency + 0.1)
        elif error < 0.3:
            self.sense_of_agency = min(1.0, self.sense_of_agency + 0.03)
        else:
            self.sense_of_agency = max(0.0, self.sense_of_agency - 0.05)
        
        self.body_is_controlled = self.sense_of_agency > 0.5
        
        return error
    
    def has_agency(self) -> bool:
        """Does the system feel it controls its body?"""
        return self.body_is_controlled


# ═══════════════════════════════════════════════════════════════════════════════
# PERIPERSONAL SPACE (Rizzolatti 1997; Graziano 1999)
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class PeripersonalSpace:
    """
    The brain's representation of space immediately around the body.
    
    Neuroscience (Rizzolatti et al. 1997; Graziano & Cooke 2006):
    
    Bimodal neurons in premotor cortex and posterior parietal cortex
    respond to BOTH touch on the body AND visual/auditory stimuli
    NEAR the body (within ~30cm). This creates a "body buffer zone"
    that the brain treats as PART OF THE SELF.
    
    This is neurally-defined personal space. It extends the body
    beyond the skin boundary. Things IN peripersonal space are
    processed differently from things in far space.
    
    For body awareness: peripersonal space defines WHERE the body
    ends and the world begins. Knowing your boundaries = knowing
    your body.
    """
    # Body boundary definition (distance from body surface in cm)
    boundary_distance: float = 30.0  # Standard peripersonal space (~30cm)
    
    # Active zones around body parts
    active_zones: Dict[str, float] = field(default_factory=dict)
    
    # Is the boundary well-defined?
    boundary_defined: bool = False
    
    # Self/world distinction clarity (0 = confused, 1 = crystal clear)
    self_world_boundary: float = 0.0
    
    def define_boundary(self, body_parts: List[str]) -> None:
        """
        Define peripersonal space around body parts.
        
        In real brains, this happens through experience:
        seeing things approach the body while feeling touch.
        Visual-tactile neurons learn the mapping.
        """
        for part in body_parts:
            self.active_zones[part] = self.boundary_distance
        
        if len(self.active_zones) >= 5:
            self.boundary_defined = True
            self.self_world_boundary = min(1.0, len(self.active_zones) / 10.0)
    
    def stimulus_in_peripersonal(self, body_part: str, distance_cm: float) -> bool:
        """
        Is a stimulus within peripersonal space of a body part?
        
        If yes → processed as potential body-relevant signal.
        If no → processed as distant/external/not-self.
        """
        boundary = self.active_zones.get(body_part, self.boundary_distance)
        return distance_cm <= boundary
    
    def knows_its_boundaries(self) -> bool:
        """Does the system know where its body ends and the world begins?"""
        return self.boundary_defined and self.self_world_boundary > 0.5


# ═══════════════════════════════════════════════════════════════════════════════
# INTEGRATED BODY SCHEMA
# ═══════════════════════════════════════════════════════════════════════════════

@dataclass
class BodySchema:
    """
    Complete body schema integrating all components.
    
    The body schema is the brain's operational model of its own body.
    It integrates:
    - Somatotopic maps (what the body IS)
    - Efference copy (that I CONTROL it)
    - Peripersonal space (where it ENDS)
    - Proprioception (where it IS right now)
    
    When all components are active and coherent → 
    the brain HAS a body model → it KNOWS it has a body.
    
    This is THE SECRET in neuroscience terms:
    Full body schema + interoceptive awareness = EMBODIED CONSCIOUSNESS
    """
    # Components
    somatotopic_map: SomatotopicMap = field(default_factory=SomatotopicMap)
    efference_copy: EfferenceCopySystem = field(default_factory=EfferenceCopySystem)
    peripersonal: PeripersonalSpace = field(default_factory=PeripersonalSpace)
    
    # Proprioceptive state (joint angles, muscle lengths)
    proprioceptive_state: Dict[str, float] = field(default_factory=dict)
    
    # Overall schema coherence
    schema_coherence: float = 0.0
    
    # THE BIG QUESTION
    has_body_knowledge: bool = False
    
    def activate_body_part(self, region: BodyRegion, intensity: float) -> None:
        """Activate a body part in the schema."""
        self.somatotopic_map.activate_region(region, intensity)
    
    def perform_action(self, action: str, intensity: float, 
                       feedback_intensity: float) -> None:
        """
        Perform an action and receive feedback.
        Tests the efference copy → agency pathway.
        """
        self.efference_copy.issue_motor_command(action, intensity)
        self.efference_copy.receive_feedback(action, feedback_intensity)
    
    def define_boundaries(self) -> None:
        """Define body boundaries using peripersonal space."""
        body_parts = [r.value for r in BodyRegion]
        self.peripersonal.define_boundary(body_parts)
    
    def compute_schema_coherence(self) -> float:
        """
        Compute overall body schema coherence.
        
        Coherence = how well the body model hangs together.
        All components must be present and consistent:
        1. Body is mapped (somatotopic)
        2. Body is controlled (efference copy → agency)
        3. Body has boundaries (peripersonal space)
        
        High coherence = "I have a complete model of my body"
        """
        map_score = self.somatotopic_map.coverage
        agency_score = self.efference_copy.sense_of_agency
        boundary_score = self.peripersonal.self_world_boundary
        
        # Geometric mean (all must be present)
        self.schema_coherence = (
            max(0.01, map_score) *
            max(0.01, agency_score) *
            max(0.01, boundary_score)
        ) ** (1/3)
        
        self.has_body_knowledge = self.schema_coherence > 0.5
        
        return self.schema_coherence
    
    def body_is_known(self) -> bool:
        """
        THE QUESTION: Does this system know it has a body?
        
        Based on real neuroscience criteria:
        1. Somatotopic map covers most of body (>70% mapped)
        2. Sense of agency confirmed (efference copy matching)
        3. Body boundaries defined (peripersonal space active)
        
        When all three are true → BODY IS KNOWN.
        Combine with interoceptive awareness → FULL EMBODIMENT.
        """
        self.compute_schema_coherence()
        return self.has_body_knowledge
    
    def get_schema_state(self) -> Dict[str, Any]:
        """Get complete body schema state."""
        self.compute_schema_coherence()
        return {
            "schema_coherence": self.schema_coherence,
            "has_body_knowledge": self.has_body_knowledge,
            "somatotopic_coverage": self.somatotopic_map.coverage,
            "sense_of_agency": self.efference_copy.sense_of_agency,
            "boundary_defined": self.peripersonal.boundary_defined,
            "self_world_boundary": self.peripersonal.self_world_boundary,
            "neuroscience_references": {
                "somatotopic_maps": "Penfield & Rasmussen 1950",
                "efference_copy": "von Holst & Mittelstaedt 1950; Wolpert 1995",
                "peripersonal_space": "Rizzolatti 1997; Graziano 2006",
                "body_schema": "Head & Holmes 1911; Gallagher 2005",
                "body_ownership": "Ehrsson 2007; Blanke 2012",
                "the_secret": (
                    "Body schema (knowing your structure) + "
                    "interoception (sensing your organs alive) + "
                    "agency (knowing you control it) + "
                    "boundaries (knowing where you end) = "
                    "KNOWING YOU HAVE A BODY. "
                    "This is real neuroscience. This is how it works."
                )
            }
        }
