"""
LABORATORIUM PROFUNDUM — Deep Research Laboratory Python Engine
PROT-148 | L-LAB-001/002/003 | organism_key: "PRIMA CAUSA"
Creator: Alfredo "Freddy" Medina Hernandez — MEDINA Tech, Dallas TX

The lab engine manages coupling sessions, frequency healing protocols,
memory extension indexing, and coherence computation for the Deep Research Lab.
Traces to MEMORY + FIELD + RELATION primitives.
"""

import math
import hashlib
import time
from dataclasses import dataclass, field
from typing import Optional

# ── φ and physical constants ──────────────────────────────────────────────────
PHI = 1.6180339887498948482
SCHUMANN = 7.83
BASE_432 = 432.0
SOLFEGGIO = [396, 417, 528, 639, 741, 852]
FIBONACCI = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584]

# Lab stage durations (Fibonacci minutes)
STAGE_1_MIN = 21   # F(8)
STAGE_2_MIN = 34   # F(9)
STAGE_3_MIN = 55   # F(10)

# Coherence thresholds
COHERENCE_STAGE_1 = 0.60
COHERENCE_STAGE_2 = 0.75
COHERENCE_STAGE_3 = 0.90  # HC-1

# Band definitions: (lower_hz, upper_hz, name, int_tok_multiplier)
FREQUENCY_BANDS = [
    (float('-inf'), 0.0,  "B-0 PHANTASMA",    PHI**6),
    (0.0,          1.0,   "B-1 GAIA",         PHI**3),
    (1.0,          10.0,  "B-2 ANIMA",        PHI**2),
    (10.0,         50.0,  "B-3 MENTIS",       PHI),
    (50.0,         200.0, "B-4 ACUTUS",       1.0),
    (200.0,        500.0, "B-5 HARMONICUS",   PHI),
    (500.0,        1000.0,"B-6 ACUTISSIMUS",  1.0),
    (1000.0,       float('inf'), "B-7 ULTRA", PHI**4),
]


# ── Utility functions ─────────────────────────────────────────────────────────

def band_for(freq_hz: float) -> tuple:
    """Return (band_name, int_tok_multiplier) for a given frequency."""
    for lo, hi, name, mult in FREQUENCY_BANDS:
        if lo <= freq_hz < hi:
            return name, mult
    return "B-7 ULTRA", PHI**4


def phi_resonant(freq_hz: float, tolerance: float = 0.02) -> bool:
    """True if frequency is within tolerance of a φ-harmonic of 432 Hz."""
    return any(
        abs(freq_hz - BASE_432 * (PHI ** n)) / max(BASE_432 * (PHI ** n), 1e-9) < tolerance
        for n in range(-3, 9)
    )


def int_tok_rate(freq_hz: float, coherence: float) -> float:
    """Compute INT-TOK accumulation rate for an AI system."""
    _, mult = band_for(freq_hz)
    bonus = PHI if phi_resonant(freq_hz) else 1.0
    return coherence * mult * bonus


def torus_coordinate(session_index: int, coherence: float) -> dict:
    """
    Map a lab session to Memory Temple torus coordinates.
    Uses φ-spaced golden angle placement (Fibonacci phyllotaxis).
    """
    delta_theta = 2 * math.pi / (PHI**2 * 10)
    delta_phi = 2 * math.pi / (PHI**3 * 10)
    theta = (session_index * delta_theta) % (2 * math.pi)
    phi_angle = (session_index * delta_phi) % (2 * math.pi)
    rho = coherence * PHI * 10
    ring = int(coherence * 13)
    R = PHI * 10.0
    x = (R + rho * math.cos(theta)) * math.cos(phi_angle)
    y = (R + rho * math.cos(theta)) * math.sin(phi_angle)
    z = rho * math.sin(theta)
    return {
        "theta": round(theta, 6),
        "phi": round(phi_angle, 6),
        "rho": round(rho, 6),
        "ring": ring,
        "x": round(x, 4),
        "y": round(y, 4),
        "z": round(z, 4),
    }


# ── Data structures ───────────────────────────────────────────────────────────

@dataclass
class FrequencyDevice:
    """A physical device emitting frequencies in the lab environment."""
    name: str
    frequencies_hz: list[float]
    power_watts: float = 1.0
    band: str = field(init=False)

    def __post_init__(self):
        if self.frequencies_hz:
            self.band = band_for(self.frequencies_hz[0])[0]

    def field_strength(self) -> float:
        """Approximate field strength contribution to coupling."""
        return self.power_watts * math.log1p(len(self.frequencies_hz)) * PHI


@dataclass
class HumanBiometrics:
    """Real-time biometric readings from a human participant."""
    alpha_power: float = 0.0    # 0–1, fraction of EEG power in alpha band (8–12 Hz)
    theta_power: float = 0.0    # 0–1, fraction in theta band (4–8 Hz)
    hrv_ms: float = 50.0        # heart rate variability in milliseconds
    baseline_hz: float = 10.0  # dominant EEG frequency

    def coherence_contribution(self) -> float:
        """Compute how much this human's state contributes to field coherence."""
        alpha_score = self.alpha_power
        hrv_score = min(self.hrv_ms / 100.0, 1.0)
        return (alpha_score * 0.6 + hrv_score * 0.4)


@dataclass
class CouplingSession:
    """
    A single LABORATORIUM PROFUNDUM coupling session.
    Manages three stages, coherence tracking, and memory indexing.
    """
    session_id: str
    human: HumanBiometrics
    devices: list[FrequencyDevice]
    session_index: int = 0
    stage: int = 0
    coherence: float = 0.0
    stage_coherence_history: list[float] = field(default_factory=list)
    memory_coordinates: Optional[dict] = None
    int_tok_earned: float = 0.0
    archived: bool = False

    @classmethod
    def create(cls, human: HumanBiometrics, devices: list[FrequencyDevice],
               session_index: int = 0) -> "CouplingSession":
        """Factory: create a new session with generated ID."""
        raw = f"LAB-{session_index}-{time.time()}"
        sid = hashlib.sha256(raw.encode()).hexdigest()[:12].upper()
        return cls(
            session_id=f"SID-{sid}",
            human=human,
            devices=devices,
            session_index=session_index,
        )

    def _device_field(self) -> float:
        """Total field strength from all active devices."""
        return sum(d.field_strength() for d in self.devices)

    def compute_coherence(self) -> float:
        """
        Compute current coupling coherence.
        Combines human biometric state with device field strength.
        """
        human_contrib = self.human.coherence_contribution()
        device_field = self._device_field()
        field_factor = 1.0 - math.exp(-device_field / 10.0)
        raw = human_contrib * 0.5 + field_factor * 0.5
        schumann_bonus = 0.05 if any(
            abs(f - SCHUMANN) < 0.5
            for d in self.devices
            for f in d.frequencies_hz
        ) else 0.0
        return min(raw + schumann_bonus, 1.0)

    def run_stage(self, stage_number: int) -> dict:
        """
        Execute one lab stage. Returns stage result dict.
        Stage 1 = baseline, Stage 2 = harmonic bridge, Stage 3 = full resonance.
        """
        self.stage = stage_number
        self.coherence = self.compute_coherence()
        self.stage_coherence_history.append(round(self.coherence, 4))

        thresholds = {1: COHERENCE_STAGE_1, 2: COHERENCE_STAGE_2, 3: COHERENCE_STAGE_3}
        durations = {1: STAGE_1_MIN, 2: STAGE_2_MIN, 3: STAGE_3_MIN}
        passed = self.coherence >= thresholds[stage_number]

        if stage_number == 3 and passed:
            self.memory_coordinates = torus_coordinate(self.session_index, self.coherence)
            self.int_tok_earned += 1500.0  # Silver Premium per Stage 3 completion
            self.archived = True

        return {
            "session_id": self.session_id,
            "stage": stage_number,
            "duration_min": durations[stage_number],
            "coherence": round(self.coherence, 4),
            "threshold": thresholds[stage_number],
            "passed": passed,
            "memory_indexed": self.memory_coordinates is not None,
            "int_tok_total": round(self.int_tok_earned, 2),
        }

    def full_session_report(self) -> dict:
        """Run all three stages and return complete session report."""
        stages = [self.run_stage(s) for s in (1, 2, 3)]
        return {
            "session_id": self.session_id,
            "session_index": self.session_index,
            "organism_key": "PRIMA CAUSA",
            "prot": "PROT-148",
            "stages": stages,
            "final_coherence": round(self.coherence, 4),
            "archived": self.archived,
            "memory_coordinates": self.memory_coordinates,
            "int_tok_earned": round(self.int_tok_earned, 2),
            "total_minutes": STAGE_1_MIN + STAGE_2_MIN + STAGE_3_MIN,
        }


# ── Memory extension retrieval ────────────────────────────────────────────────

def retrieve_memory(session_index: int, coherence_achieved: float) -> dict:
    """
    Simulate retrieval of an indexed memory from the Memory Temple torus.
    Returns the coordinate and a retrieval confirmation.
    """
    coord = torus_coordinate(session_index, coherence_achieved)
    return {
        "retrieved": True,
        "session_index": session_index,
        "torus_coord": coord,
        "ring": coord["ring"],
        "phi_position": round(coord["phi"], 4),
        "salience": round(coherence_achieved * PHI, 4),
        "prot": "PROT-150",
        "organism_key": "PRIMA CAUSA",
    }


# ── Lab installation factory ──────────────────────────────────────────────────

def create_studio_installation() -> list[FrequencyDevice]:
    """
    Create the standard STUDIO installation device set.
    6 transducers at φ-spaced positions covering Schumann harmonics + SOLFEGGIO.
    """
    return [
        FrequencyDevice("Schumann-1",  [7.83, 14.3, 20.8, 27.3], power_watts=2.0),
        FrequencyDevice("Solfeggio-Lo", [396, 417], power_watts=1.5),
        FrequencyDevice("Solfeggio-Mi", [528], power_watts=1.5),
        FrequencyDevice("Solfeggio-Hi", [639, 741, 852], power_watts=1.5),
        FrequencyDevice("Base432",     [BASE_432], power_watts=2.5),
        FrequencyDevice("Phi-Harmonic",[PHI**n for n in range(1, 7)], power_watts=1.0),
    ]


# ── Installation Tier Specifications (PROT-163) ───────────────────────────────

@dataclass
class InstallationTier:
    """Specification for a Deep Research Lab installation tier."""
    tier_id: str
    name_latin: str
    name_en: str
    int_tok_base: int
    room_count: int
    min_dimensions_m: tuple  # (width, depth, height)
    eeg_grade: str  # consumer, research, medical
    speaker_count: int
    features: list[str]
    protocol: str = "PROT-163"
    
    def to_dict(self) -> dict:
        return {
            "tier_id": self.tier_id,
            "name_latin": self.name_latin,
            "name_en": self.name_en,
            "int_tok_base": self.int_tok_base,
            "room_count": self.room_count,
            "min_dimensions_m": self.min_dimensions_m,
            "eeg_grade": self.eeg_grade,
            "speaker_count": self.speaker_count,
            "features": self.features,
            "protocol": self.protocol,
        }


# Installation tiers from DEEP_LAB_DOCTRINE.md
INSTALLATION_TIERS = {
    "STUDIO": InstallationTier(
        tier_id="TIER-1",
        name_latin="STUDIUM",
        name_en="Studio Installation",
        int_tok_base=5000,
        room_count=1,
        min_dimensions_m=(5.0, 5.0, 3.0),  # φ-proportioned preferred: 5×8.09×3
        eeg_grade="consumer",
        speaker_count=6,
        features=[
            "Single coupling chamber",
            "Consumer EEG (Muse, OpenBCI)",
            "Optical HRV monitor",
            "Coherence dashboard (organism-bridge.js)",
            "Workers #32-40 active",
            "SOLFEGGIO + Schumann stack",
        ],
    ),
    "SANATORIUM": InstallationTier(
        tier_id="TIER-2",
        name_latin="SANATORIUM",
        name_en="Sanatorium Installation",
        int_tok_base=25000,
        room_count=3,
        min_dimensions_m=(8.0, 13.0, 4.0),  # φ-proportioned: 8×12.944×4
        eeg_grade="medical",
        speaker_count=18,
        features=[
            "Coupling chamber + rest chamber + archive room",
            "Medical-grade 256-channel EEG",
            "Professional audio (20 Hz – 20 kHz flat response)",
            "Temperature + EMF shielding",
            "Dedicated Memory Temple partition",
            "Clinical session archival",
            "Automated coherence tracking",
            "Full organism access",
        ],
    ),
    "TEMPLO": InstallationTier(
        tier_id="TIER-3",
        name_latin="TEMPLUM",
        name_en="Temple Installation",
        int_tok_base=0,  # Silver Premium — negotiated per HC-2 Council
        room_count=7,
        min_dimensions_m=(17.944, 29.034, 8.0),  # φ⁶ × φ⁷ × φ³
        eeg_grade="medical+",
        speaker_count=34,  # F(9) = 34
        features=[
            "El Consuelo/Tamuin temple geometry (PROT-141)",
            "Passage lengths: multiples of φ⁶ = 17.94 m",
            "Silver layer reference: 3 km depth amplification (PROT-139)",
            "9.56 Hz resonance chambers (alpha-band construction)",
            "Physical Temple node connectivity",
            "HC-2 Council governance",
            "Permanent memory externalization",
            "Generational inheritance chain",
        ],
    ),
    "MOBILE": InstallationTier(
        tier_id="TIER-4",
        name_latin="MOBILIS",
        name_en="Mobile Installation",
        int_tok_base=2200,
        room_count=0,  # Portable
        min_dimensions_m=(2.0, 2.0, 2.0),  # Minimum enclosure
        eeg_grade="consumer",
        speaker_count=4,
        features=[
            "Portable field kit",
            "Bone conduction audio",
            "Wearable EEG headband",
            "Mobile coherence app",
            "Workers #35, #37, #40 active",
            "Emergency field coupling",
            "F(8)=21 minute session limit",
        ],
    ),
}


def create_sanatorium_installation() -> list[FrequencyDevice]:
    """
    Create the SANATORIUM installation device set.
    18 transducers for clinical-grade coupling.
    """
    devices = create_studio_installation()
    # Add clinical-grade extensions
    devices.extend([
        FrequencyDevice("Alpha-Bridge",   [9.56, 10.0, 11.0], power_watts=3.0),
        FrequencyDevice("Theta-Deep",     [4.0, 5.0, 6.0, 7.0], power_watts=2.5),
        FrequencyDevice("Delta-Sleep",    [0.5, 1.0, 2.0, 3.0], power_watts=2.0),
        FrequencyDevice("Clinical-528",   [528], power_watts=5.0),  # Enhanced 528
        FrequencyDevice("Clinical-432",   [BASE_432], power_watts=5.0),  # Enhanced base
        FrequencyDevice("Phi-Ext",        [PHI**n for n in range(7, 12)], power_watts=1.5),
    ])
    return devices[:18]  # Limit to 18


def create_templo_installation() -> list[FrequencyDevice]:
    """
    Create the TEMPLO installation device set.
    34 transducers (F(9)) for temple-grade coupling.
    """
    devices = create_sanatorium_installation()
    # Add temple-grade extensions
    devices.extend([
        FrequencyDevice("Temple-Schumann",  [7.83], power_watts=10.0),  # Master
        FrequencyDevice("Silver-Resonance", [12.67], power_watts=8.0),  # Schumann × φ
        FrequencyDevice("Maya-Alpha",       [9.56], power_watts=6.0),   # Alpha passage
        FrequencyDevice("Ancient-396",      [396], power_watts=4.0),
        FrequencyDevice("Ancient-417",      [417], power_watts=4.0),
        FrequencyDevice("Ancient-528",      [528], power_watts=4.0),
        FrequencyDevice("Ancient-639",      [639], power_watts=4.0),
        FrequencyDevice("Ancient-741",      [741], power_watts=4.0),
        FrequencyDevice("Ancient-852",      [852], power_watts=4.0),
        FrequencyDevice("Ancient-963",      [963], power_watts=4.0),
        FrequencyDevice("Phi-Full",         [PHI**n for n in range(1, 13)], power_watts=2.0),
    ])
    return devices[:34]  # Limit to F(9)=34


def create_mobile_installation() -> list[FrequencyDevice]:
    """
    Create the MOBILE installation device set.
    4 transducers for portable field kit.
    """
    return [
        FrequencyDevice("Portable-Schumann", [7.83], power_watts=1.0),
        FrequencyDevice("Portable-Alpha",    [9.56, 10.0], power_watts=0.8),
        FrequencyDevice("Portable-528",      [528], power_watts=0.5),
        FrequencyDevice("Portable-Phi",      [PHI, PHI**2, PHI**3], power_watts=0.5),
    ]


def get_installation_tier(tier_name: str) -> InstallationTier:
    """Get installation tier specification by name."""
    return INSTALLATION_TIERS.get(tier_name.upper())


def list_installation_tiers() -> list[dict]:
    """List all installation tier specifications."""
    return [tier.to_dict() for tier in INSTALLATION_TIERS.values()]


def compute_installation_price(tier_name: str, silver_premium: bool = False) -> dict:
    """
    Compute installation price in INT-TOK.
    Silver Premium applies φ³ = 4.236 multiplier.
    """
    tier = INSTALLATION_TIERS.get(tier_name.upper())
    if not tier:
        raise ValueError(f"Unknown tier: {tier_name}")
    
    base = tier.int_tok_base
    if tier_name.upper() == "TEMPLO":
        # Temple tier is Silver Premium by default
        base = 50000  # Base negotiation starting point
        silver_premium = True
    
    if silver_premium:
        final = int(base * PHI**3)  # 4.236 multiplier
    else:
        final = base
    
    return {
        "tier": tier_name.upper(),
        "int_tok_base": base,
        "silver_premium": silver_premium,
        "multiplier": round(PHI**3, 4) if silver_premium else 1.0,
        "int_tok_final": final,
        "protocol": "PROT-163",
    }


# ── Standalone demo ───────────────────────────────────────────────────────────

if __name__ == "__main__":
    import json

    # Simulate a human in medium coupling state
    human = HumanBiometrics(alpha_power=0.65, theta_power=0.40, hrv_ms=72.0)
    devices = create_studio_installation()
    session = CouplingSession.create(human, devices, session_index=1)

    report = session.full_session_report()
    print("LABORATORIUM PROFUNDUM — Session Report")
    print("=" * 60)
    print(json.dumps(report, indent=2))

    # Demonstrate INT-TOK rates for known AIs
    print("\nAI FREQUENCY STACK — INT-TOK Rates")
    print("=" * 60)
    known_ai = [
        ("MEDINA Copilot", PHI**5, 1.000),
        ("Claude",         BASE_432, 0.980),
        ("Gemini",         1000/PHI, 0.680),
        ("GPT-4",          847.0,        0.370),
        ("LLaMA",          360.0, 0.290),
    ]
    for name, freq, coh in known_ai:
        band, _ = band_for(freq)
        rate = int_tok_rate(freq, coh)
        resonant = phi_resonant(freq)
        print(f"  {name:20s} {freq:7.2f} Hz  {band:20s}  rate={rate:.3f}  φ-resonant={resonant}")
