"""
BILL BOTS MODULE — nova_ovo/agents/bill_bots
=============================================

Sovereign, always-on automation bots that live inside the Organism.
They auto-package, auto-build, auto-fix, and commit to GitHub.

The 5 Bill Bots:
  1. AEDIFICATOR — The Perpetual Builder  (GitHub Actions)
  2. FASCICULUS  — The Automatic Packager (GitHub Actions + this module)
  3. MEDICUS     — The Auto-Healer        (GitHub Actions + medicus_bot.py)
  4. CUSTOS      — The Guardian           (GitHub Actions + custos_bot.py)
  5. PRAETOR     — The Commander          (GitHub Actions)

These bots follow L-005: Agent Existence Law
  - Always-on, not alive
  - No feelings, no stress
  - Constantly working at dynamic speeds

Attribution: Alfredo Medina Hernandez | Medina Tech | Dallas, TX
"""

from .medicus_bot import MedicusBot, MedicusFix, run_medicus
from .custos_bot import CustosBot, CustosIssue, run_custos

__all__ = [
    "MedicusBot",
    "MedicusFix",
    "run_medicus",
    "CustosBot",
    "CustosIssue",
    "run_custos",
]
