"""
Resonance Catalog — Complete Registry of Cognitive Collision Products
=====================================================================

Catalogs all known and theoretical resonances produced in
cognitive collisions between human intent and AI prediction.

Protocol: PROT-623
"""

from dataclasses import dataclass, field


@dataclass
class ResonanceEntry:
    """A cataloged resonance."""
    name: str
    latex_name: str
    mass_gev: float
    width_gev: float
    spin_parity: str
    decay_modes: list[dict] = field(default_factory=list)
    discovery_year: int = 0
    discovery_experiment: str = ""
    ux_interpretation: str = ""


class ResonanceCatalog:
    """Complete catalog of cognitive resonances, inspired by PDG."""

    ENTRIES = [
        ResonanceEntry(
            "pion_confirm", "π⁰_confirm", 0.135, 7.7e-9, "0⁻⁺",
            [{"channel": "feedback→satisfaction", "branching_ratio": 0.988}],
            2020, "LIC-ATLAS", "Immediate positive feedback loop"
        ),
        ResonanceEntry(
            "pion_navigate", "π±_navigate", 0.140, 2.5e-8, "0⁻⁺",
            [{"channel": "click→page_load", "branching_ratio": 0.999}],
            2018, "LIC-CMS", "Basic navigation quantum"
        ),
        ResonanceEntry(
            "kaon_search", "K_search", 0.494, 0.0, "0⁻",
            [{"channel": "query→results", "branching_ratio": 0.692},
             {"channel": "query→no_results", "branching_ratio": 0.308}],
            2019, "LIC-LHCb", "Search-result coupling"
        ),
        ResonanceEntry(
            "eta_browse", "η_browse", 0.548, 1.3e-3, "0⁻⁺",
            [{"channel": "scroll→content_reveal", "branching_ratio": 0.394},
             {"channel": "scroll→end_of_page", "branching_ratio": 0.328}],
            2019, "LIC-ALICE", "Browsing momentum quantum"
        ),
        ResonanceEntry(
            "jpsi_insight", "J/ψ_insight", 3.097, 9.3e-5, "1⁻⁻",
            [{"channel": "understanding→eureka", "branching_ratio": 0.060},
             {"channel": "understanding→partial", "branching_ratio": 0.880}],
            2021, "LIC-ATLAS", "The November Revolution of UX — bound state of charm"
        ),
        ResonanceEntry(
            "upsilon_mastery", "Υ_mastery", 9.460, 5.4e-5, "1⁻⁻",
            [{"channel": "practice→skill_jump", "branching_ratio": 0.024},
             {"channel": "practice→incremental", "branching_ratio": 0.976}],
            2022, "LIC-CMS", "Heavy bound state — deep skill acquisition"
        ),
        ResonanceEntry(
            "chi_flow", "χ_flow", 3.525, 0.0, "0⁺⁺",
            [{"channel": "engagement→timelessness", "branching_ratio": 0.341},
             {"channel": "engagement→distraction", "branching_ratio": 0.659}],
            2023, "LIC-ATLAS", "P-wave state of deep work"
        ),
        ResonanceEntry(
            "higgs_meaning", "H⁰_meaning", 125.1, 4.07e-3, "0⁺⁺",
            [{"channel": "relevance→bb̄_memory", "branching_ratio": 0.582},
             {"channel": "relevance→WW_transform", "branching_ratio": 0.214},
             {"channel": "relevance→gg_habit", "branching_ratio": 0.082},
             {"channel": "relevance→ττ_emotion", "branching_ratio": 0.063}],
            2024, "LIC-ATLAS+CMS", "THE discovery: interactions acquire significance"
        ),
        ResonanceEntry(
            "w_transform", "W±_transform", 80.4, 2.085, "1⁻",
            [{"channel": "worldview→hadronic", "branching_ratio": 0.676},
             {"channel": "worldview→leptonic", "branching_ratio": 0.324}],
            2023, "LIC-ATLAS", "Charged current — preference transformation"
        ),
        ResonanceEntry(
            "z_synthesis", "Z⁰_synthesis", 91.2, 2.495, "1⁻",
            [{"channel": "synthesis→hadronic", "branching_ratio": 0.699},
             {"channel": "synthesis→invisible", "branching_ratio": 0.200},
             {"channel": "synthesis→leptonic", "branching_ratio": 0.101}],
            2023, "LIC-LEP", "Neutral current — human-AI creative synthesis"
        ),
        ResonanceEntry(
            "top_commitment", "t_commitment", 173.1, 1.42, "1/2",
            [{"channel": "commit→Wb", "branching_ratio": 0.999}],
            2025, "LIC-Tevatron", "Heaviest fermion — irreversible commitment"
        ),
        ResonanceEntry(
            "x_serendipity", "X_serendipity", 750.0, 45.0, "0⁺⁺",
            [{"channel": "unexpected→prepared_mind", "branching_ratio": 0.5}],
            0, "CANDIDATE", "Diphoton excess at 750 GeV — serendipity resonance?"
        ),
    ]

    def __init__(self):
        self._index = {e.name: e for e in self.ENTRIES}

    def lookup(self, name: str) -> ResonanceEntry | None:
        """Look up a resonance by name."""
        return self._index.get(name)

    def search_by_mass(self, min_mass: float, max_mass: float) -> list[ResonanceEntry]:
        """Find resonances in a mass range."""
        return [e for e in self.ENTRIES if min_mass <= e.mass_gev <= max_mass]

    def search_by_spin(self, spin_parity: str) -> list[ResonanceEntry]:
        """Find resonances with given spin-parity."""
        return [e for e in self.ENTRIES if e.spin_parity == spin_parity]

    def discovered_only(self) -> list[ResonanceEntry]:
        """Return only discovered (confirmed) resonances."""
        return [e for e in self.ENTRIES if e.discovery_year > 0 and e.discovery_experiment != "CANDIDATE"]

    def total_width_sum(self) -> float:
        """Sum of all resonance widths (measure of total interaction richness)."""
        return sum(e.width_gev for e in self.ENTRIES)
