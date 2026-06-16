"""
CONSUMER PLATFORMS — 15 Outward-Facing Products
================================================
Protocols: PROT-187 to PROT-201

FREE + PREMIUM tier products for mass user acquisition.

Copyright (c) 2026 Alfredo "Freddy" Medina Hernandez
MEDINA TECH — Dallas, TX
"""

from dataclasses import dataclass
from typing import Dict, List, Optional
from enum import Enum

PHI = 1.6180339887498948482


class ProductTier(Enum):
    FREE = "FREE"
    PREMIUM = "PREMIUM"
    ENTERPRISE = "ENTERPRISE"


@dataclass
class Platform:
    """A consumer platform definition."""
    platform_id: str
    name: str
    latin_name: str
    protocol: str
    category: str
    tiers: List[ProductTier]
    features_free: List[str]
    features_premium: List[str]
    monthly_price_int_tok: float = 0.0


# 15 Consumer Platforms
PLATFORMS = [
    Platform(
        "VIGILIA_SHIELD", "VIGILIA SHIELD", "SCUTUM VIGILIAE", "PROT-187",
        "cybersecurity", [ProductTier.FREE, ProductTier.PREMIUM],
        ["Basic threat detection", "Phishing protection", "3 devices"],
        ["Advanced AI detection", "Dark web monitoring", "Unlimited devices", "VPN"],
        PHI * 10
    ),
    Platform(
        "MEMORIA_PERSONAL", "MEMORIA PERSONAL", "MEMORIA PERSONALIS", "PROT-188",
        "personal-ai", [ProductTier.FREE, ProductTier.PREMIUM],
        ["1GB memory vault", "Basic recall", "3 notes/day"],
        ["Unlimited memory", "AI synthesis", "Cross-device sync", "Voice input"],
        PHI * 8
    ),
    Platform(
        "CYBER_GUARDIAN", "CYBER GUARDIAN", "CUSTOS CYBERNETICUS", "PROT-189",
        "family-security", [ProductTier.FREE, ProductTier.PREMIUM],
        ["5 family devices", "Basic parental controls", "Safe browsing"],
        ["Unlimited devices", "Advanced controls", "Location tracking", "Screen time"],
        PHI * 12
    ),
    Platform(
        "RESEARCH_ASSISTANT", "RESEARCH ASSISTANT", "ASSISTENS INVESTIGATIONIS", "PROT-190",
        "productivity", [ProductTier.FREE, ProductTier.PREMIUM],
        ["50 queries/month", "Basic citations", "Summary generation"],
        ["Unlimited queries", "Full citation management", "Knowledge graphs", "API access"],
        PHI * 15
    ),
    Platform(
        "CODE_COMPANION", "CODE COMPANION", "SOCIUS CODICIS", "PROT-191",
        "developer", [ProductTier.FREE, ProductTier.PREMIUM],
        ["100 completions/day", "Basic bug detection", "5 languages"],
        ["Unlimited completions", "Security scanning", "All languages", "Code review"],
        PHI * 20
    ),
    Platform(
        "HEALTH_MONITOR", "HEALTH MONITOR", "MONITOR SANITATIS", "PROT-192",
        "health", [ProductTier.FREE, ProductTier.PREMIUM],
        ["Basic tracking", "Medication reminders", "Symptom checker"],
        ["AI health insights", "Doctor integration", "Lab analysis", "Family plans"],
        PHI * 10
    ),
    Platform(
        "FINANCE_GUARDIAN", "FINANCE GUARDIAN", "CUSTOS PECUNIAE", "PROT-193",
        "finance", [ProductTier.FREE, ProductTier.PREMIUM],
        ["Basic budgeting", "Bill reminders", "Fraud alerts"],
        ["Investment insights", "Tax optimization", "Portfolio tracking", "AI advisor"],
        PHI * 12
    ),
    Platform(
        "PRIVACY_VAULT", "PRIVACY VAULT", "ARCA SECRETI", "PROT-194",
        "privacy", [ProductTier.FREE, ProductTier.PREMIUM],
        ["500MB encrypted storage", "Basic sharing", "Password manager"],
        ["Unlimited storage", "Secure sharing", "Zero-knowledge", "Data export"],
        PHI * 8
    ),
    Platform(
        "CREATIVE_STUDIO", "CREATIVE STUDIO", "OFFICINA CREATIVA", "PROT-195",
        "creative", [ProductTier.FREE, ProductTier.PREMIUM],
        ["20 generations/month", "Basic image editing", "Templates"],
        ["Unlimited generations", "Video editing", "Music creation", "Brand kit"],
        PHI * 18
    ),
    Platform(
        "LEARNING_HUB", "LEARNING HUB", "CENTRUM DISCENDI", "PROT-196",
        "education", [ProductTier.FREE, ProductTier.PREMIUM],
        ["5 courses", "Basic AI tutor", "Progress tracking"],
        ["Unlimited courses", "Advanced tutoring", "Certifications", "Live sessions"],
        PHI * 15
    ),
    Platform(
        "BUSINESS_PILOT", "BUSINESS PILOT", "GUBERNATOR NEGOTII", "PROT-197",
        "business", [ProductTier.FREE, ProductTier.PREMIUM],
        ["100 contacts", "Basic CRM", "5 invoices/month"],
        ["Unlimited contacts", "Full CRM", "Unlimited invoices", "Analytics"],
        PHI * 25
    ),
    Platform(
        "HOME_GUARDIAN", "HOME GUARDIAN", "CUSTOS DOMUS", "PROT-198",
        "smart-home", [ProductTier.FREE, ProductTier.PREMIUM],
        ["5 devices", "Basic automation", "Voice control"],
        ["Unlimited devices", "Advanced automation", "Security monitoring", "Energy management"],
        PHI * 10
    ),
    Platform(
        "TRAVEL_COMPANION", "TRAVEL COMPANION", "SOCIUS ITINERIS", "PROT-199",
        "travel", [ProductTier.FREE, ProductTier.PREMIUM],
        ["Trip planning", "Basic bookings", "Translation"],
        ["AI concierge", "Premium bookings", "Real-time support", "Local recommendations"],
        PHI * 12
    ),
    Platform(
        "SOCIAL_SHIELD", "SOCIAL SHIELD", "SCUTUM SOCIALE", "PROT-200",
        "social-media", [ProductTier.FREE, ProductTier.PREMIUM],
        ["Content moderation", "Basic privacy controls", "3 accounts"],
        ["Advanced moderation", "Reputation monitoring", "Unlimited accounts", "AI filtering"],
        PHI * 8
    ),
    Platform(
        "CAREER_NAVIGATOR", "CAREER NAVIGATOR", "NAVIGATOR CARRERAE", "PROT-201",
        "career", [ProductTier.FREE, ProductTier.PREMIUM],
        ["Job matching", "Resume builder", "3 applications/month"],
        ["AI resume optimization", "Interview prep", "Salary insights", "Unlimited apps"],
        PHI * 15
    ),
]


class PlatformRegistry:
    """Registry for consumer platforms."""
    
    def __init__(self):
        self.platforms: Dict[str, Platform] = {p.platform_id: p for p in PLATFORMS}
    
    def get(self, platform_id: str) -> Optional[Platform]:
        return self.platforms.get(platform_id)
    
    def get_by_category(self, category: str) -> List[Platform]:
        return [p for p in self.platforms.values() if p.category == category]
    
    def get_free_tier(self) -> List[Platform]:
        return [p for p in self.platforms.values() if ProductTier.FREE in p.tiers]
    
    def list_all(self) -> List[Platform]:
        return list(self.platforms.values())
    
    def get_state(self) -> Dict:
        return {
            "total_platforms": len(self.platforms),
            "categories": list(set(p.category for p in self.platforms.values())),
            "protocol_range": "PROT-187 to PROT-201"
        }


# Enterprise Cybersecurity Products (PROT-202 to PROT-209)
ENTERPRISE_PRODUCTS = [
    {"id": "VIGILIA_ENTERPRISE", "name": "VIGILIA ENTERPRISE", "protocol": "PROT-202", "type": "soc"},
    {"id": "THREAT_INTELLIGENCE_HUB", "name": "THREAT INTELLIGENCE HUB", "protocol": "PROT-203", "type": "threat_intel"},
    {"id": "INCIDENT_RESPONSE_AI", "name": "INCIDENT RESPONSE AI", "protocol": "PROT-204", "type": "ir"},
    {"id": "PENETRATION_TESTER", "name": "PENETRATION TESTER AI", "protocol": "PROT-205", "type": "pentest"},
    {"id": "COMPLIANCE_AUDITOR", "name": "COMPLIANCE AUDITOR", "protocol": "PROT-206", "type": "compliance"},
    {"id": "ZERO_TRUST_GATEWAY", "name": "ZERO TRUST GATEWAY", "protocol": "PROT-207", "type": "ztna"},
    {"id": "RANSOMWARE_SHIELD", "name": "RANSOMWARE SHIELD", "protocol": "PROT-208", "type": "ransomware"},
    {"id": "IDENTITY_FORTRESS", "name": "IDENTITY FORTRESS", "protocol": "PROT-209", "type": "iam"},
]


# Free Tier Products (PROT-210 to PROT-219)
FREE_PRODUCTS = [
    {"id": "MEMORIA_LITE", "name": "MEMORIA LITE", "protocol": "PROT-210", "limit": "1GB"},
    {"id": "VIGILIA_BASIC", "name": "VIGILIA BASIC", "protocol": "PROT-211", "limit": "3 devices"},
    {"id": "RESEARCH_STARTER", "name": "RESEARCH STARTER", "protocol": "PROT-212", "limit": "50 queries/month"},
    {"id": "CODE_HELPER", "name": "CODE HELPER", "protocol": "PROT-213", "limit": "100 completions/day"},
    {"id": "CREATIVE_LITE", "name": "CREATIVE LITE", "protocol": "PROT-214", "limit": "20 generations/month"},
    {"id": "LEARNING_BASIC", "name": "LEARNING BASIC", "protocol": "PROT-215", "limit": "5 courses"},
    {"id": "BUSINESS_STARTER", "name": "BUSINESS STARTER", "protocol": "PROT-216", "limit": "100 contacts"},
    {"id": "PRIVACY_BASIC", "name": "PRIVACY BASIC", "protocol": "PROT-217", "limit": "500MB"},
    {"id": "HEALTH_TRACKER", "name": "HEALTH TRACKER", "protocol": "PROT-218", "limit": "Basic features"},
    {"id": "FINANCE_BASICS", "name": "FINANCE BASICS", "protocol": "PROT-219", "limit": "Essential features"},
]
