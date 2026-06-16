"""
FORMA Leaderboard — Designer Rankings and Achievements
=======================================================
Gamified leaderboard for designer engagement with:
- Ranking metrics (projects, CEUs, contributions)
- Achievement badges
- Team and individual rankings
- Historical performance tracking
"""

from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, List, Optional


class RankingMetric(str, Enum):
    """Metrics used for ranking."""
    PROJECTS_COMPLETED = "projects_completed"
    CEU_CREDITS = "ceu_credits"
    CLIENT_SATISFACTION = "client_satisfaction"
    PEER_RECOGNITION = "peer_recognition"
    INNOVATION_SCORE = "innovation_score"
    COLLABORATION_SCORE = "collaboration_score"
    SUSTAINABILITY_IMPACT = "sustainability_impact"
    OVERALL = "overall"


class AchievementTier(str, Enum):
    """Achievement tier levels."""
    BRONZE = "bronze"
    SILVER = "silver"
    GOLD = "gold"
    PLATINUM = "platinum"
    DIAMOND = "diamond"


@dataclass
class Achievement:
    """An achievement badge."""
    
    achievement_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    name: str = ""
    description: str = ""
    tier: AchievementTier = AchievementTier.BRONZE
    
    # Requirements
    metric: RankingMetric = RankingMetric.OVERALL
    threshold: float = 0.0
    
    # Display
    icon: str = "🏆"
    color: str = "#CD7F32"  # Bronze default
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "achievement_id": self.achievement_id,
            "name": self.name,
            "description": self.description,
            "tier": self.tier.value,
            "metric": self.metric.value,
            "threshold": self.threshold,
            "icon": self.icon,
        }


@dataclass
class LeaderboardEntry:
    """An entry in the leaderboard."""
    
    entry_id: str = field(default_factory=lambda: str(uuid.uuid4()))
    user_id: str = ""
    user_name: str = ""
    
    # Scores by metric
    scores: Dict[str, float] = field(default_factory=dict)
    
    # Overall rank
    rank: int = 0
    previous_rank: int = 0
    rank_change: int = 0
    
    # Achievements
    achievements: List[str] = field(default_factory=list)
    
    # Streaks
    active_streak: int = 0
    longest_streak: int = 0
    
    # Time tracking
    joined_at: float = field(default_factory=time.time)
    last_activity: float = field(default_factory=time.time)
    
    @property
    def overall_score(self) -> float:
        """Calculate overall score from metrics."""
        if not self.scores:
            return 0.0
        return sum(self.scores.values()) / len(self.scores)
    
    def add_score(self, metric: RankingMetric, value: float) -> None:
        """Add or update a metric score."""
        self.scores[metric.value] = value
        self.last_activity = time.time()
    
    def update_rank(self, new_rank: int) -> None:
        """Update rank and track change."""
        self.previous_rank = self.rank
        self.rank = new_rank
        self.rank_change = self.previous_rank - new_rank if self.previous_rank > 0 else 0
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "entry_id": self.entry_id,
            "user_id": self.user_id,
            "user_name": self.user_name,
            "rank": self.rank,
            "rank_change": self.rank_change,
            "overall_score": round(self.overall_score, 2),
            "scores": self.scores,
            "achievements_count": len(self.achievements),
            "streaks": {
                "active": self.active_streak,
                "longest": self.longest_streak,
            },
            "last_activity": self.last_activity,
        }


class FORMALeaderboard:
    """
    FORMA Leaderboard — Designer ranking system.
    
    Features:
    - Multi-metric ranking
    - Achievement system
    - Streak tracking
    - Team and individual views
    """
    
    def __init__(self) -> None:
        self.enabled = True
        self.name = "FORMA Leaderboard"
        
        # Entries
        self._entries: Dict[str, LeaderboardEntry] = {}
        self._by_user: Dict[str, str] = {}  # user_id -> entry_id
        
        # Achievements
        self._achievements: Dict[str, Achievement] = {}
        self._user_achievements: Dict[str, List[str]] = {}  # user_id -> [achievement_ids]
        
        # Rankings cache
        self._rankings: Dict[RankingMetric, List[str]] = {}  # metric -> [entry_ids in order]
        
        # Initialize default achievements
        self._init_default_achievements()
    
    def _init_default_achievements(self) -> None:
        """Initialize default achievement set."""
        defaults = [
            Achievement(name="First Project", description="Complete your first project", 
                       metric=RankingMetric.PROJECTS_COMPLETED, threshold=1, tier=AchievementTier.BRONZE, icon="🎯"),
            Achievement(name="Project Pro", description="Complete 10 projects",
                       metric=RankingMetric.PROJECTS_COMPLETED, threshold=10, tier=AchievementTier.SILVER, icon="⭐"),
            Achievement(name="Project Master", description="Complete 50 projects",
                       metric=RankingMetric.PROJECTS_COMPLETED, threshold=50, tier=AchievementTier.GOLD, icon="🌟"),
            Achievement(name="Learning Started", description="Earn your first CEU credits",
                       metric=RankingMetric.CEU_CREDITS, threshold=1, tier=AchievementTier.BRONZE, icon="📚"),
            Achievement(name="Continuous Learner", description="Earn 50 CEU credits",
                       metric=RankingMetric.CEU_CREDITS, threshold=50, tier=AchievementTier.SILVER, icon="🎓"),
            Achievement(name="Team Player", description="High collaboration score",
                       metric=RankingMetric.COLLABORATION_SCORE, threshold=80, tier=AchievementTier.GOLD, icon="🤝"),
            Achievement(name="Innovator", description="High innovation score",
                       metric=RankingMetric.INNOVATION_SCORE, threshold=90, tier=AchievementTier.PLATINUM, icon="💡"),
            Achievement(name="Sustainability Champion", description="Top sustainability impact",
                       metric=RankingMetric.SUSTAINABILITY_IMPACT, threshold=95, tier=AchievementTier.DIAMOND, icon="🌱"),
        ]
        
        for ach in defaults:
            self._achievements[ach.achievement_id] = ach
    
    def add_entry(self, entry: LeaderboardEntry) -> None:
        """Add a leaderboard entry."""
        self._entries[entry.entry_id] = entry
        self._by_user[entry.user_id] = entry.entry_id
    
    def get_entry(self, user_id: str) -> Optional[LeaderboardEntry]:
        """Get entry by user ID."""
        entry_id = self._by_user.get(user_id)
        if entry_id:
            return self._entries.get(entry_id)
        return None
    
    def update_score(
        self,
        user_id: str,
        metric: RankingMetric,
        value: float,
    ) -> Optional[LeaderboardEntry]:
        """Update a user's score for a metric."""
        entry = self.get_entry(user_id)
        if not entry:
            return None
        
        entry.add_score(metric, value)
        
        # Check for new achievements
        self._check_achievements(user_id, metric, value)
        
        # Update rankings
        self._update_rankings(metric)
        
        return entry
    
    def _check_achievements(
        self,
        user_id: str,
        metric: RankingMetric,
        value: float,
    ) -> List[Achievement]:
        """Check and award achievements."""
        earned = []
        
        user_ach = self._user_achievements.get(user_id, [])
        entry = self.get_entry(user_id)
        
        for ach in self._achievements.values():
            if ach.achievement_id in user_ach:
                continue  # Already earned
            
            if ach.metric == metric and value >= ach.threshold:
                user_ach.append(ach.achievement_id)
                if entry:
                    entry.achievements.append(ach.achievement_id)
                earned.append(ach)
        
        self._user_achievements[user_id] = user_ach
        return earned
    
    def _update_rankings(self, metric: RankingMetric) -> None:
        """Update rankings for a metric."""
        entries = list(self._entries.values())
        
        # Sort by metric score (descending)
        entries.sort(
            key=lambda e: e.scores.get(metric.value, 0),
            reverse=True,
        )
        
        # Update ranks
        for i, entry in enumerate(entries):
            if metric == RankingMetric.OVERALL:
                entry.update_rank(i + 1)
        
        # Cache ranking order
        self._rankings[metric] = [e.entry_id for e in entries]
    
    def update_all_rankings(self) -> None:
        """Update rankings for all metrics."""
        for metric in RankingMetric:
            self._update_rankings(metric)
    
    def get_top(
        self,
        metric: RankingMetric = RankingMetric.OVERALL,
        limit: int = 10,
    ) -> List[LeaderboardEntry]:
        """Get top entries for a metric."""
        # Sort entries by metric
        entries = list(self._entries.values())
        
        if metric == RankingMetric.OVERALL:
            entries.sort(key=lambda e: e.overall_score, reverse=True)
        else:
            entries.sort(key=lambda e: e.scores.get(metric.value, 0), reverse=True)
        
        return entries[:limit]
    
    def get_user_rank(
        self,
        user_id: str,
        metric: RankingMetric = RankingMetric.OVERALL,
    ) -> Optional[int]:
        """Get a user's rank for a metric."""
        top = self.get_top(metric, limit=len(self._entries))
        
        for i, entry in enumerate(top):
            if entry.user_id == user_id:
                return i + 1
        
        return None
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get leaderboard statistics."""
        entries = list(self._entries.values())
        
        return {
            "name": self.name,
            "enabled": self.enabled,
            "total_entries": len(entries),
            "total_achievements_defined": len(self._achievements),
            "total_achievements_earned": sum(
                len(self._user_achievements.get(e.user_id, []))
                for e in entries
            ),
            "active_streaks": sum(1 for e in entries if e.active_streak > 0),
        }
    
    def to_dict(self) -> Dict[str, Any]:
        return {
            "name": self.name,
            "enabled": self.enabled,
            "statistics": self.get_statistics(),
            "top_10": [e.to_dict() for e in self.get_top(limit=10)],
        }
