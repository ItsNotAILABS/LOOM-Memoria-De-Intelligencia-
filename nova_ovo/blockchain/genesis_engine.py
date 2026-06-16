"""Genesis block engine. PROT-161-G."""
import hashlib
import time
PHI = 1.6180339887498948482

class GenesisBlockEngine:
    def __init__(self, organism_key: str = "PRIMA CAUSA"):
        self.organism_key = organism_key
        self.genesis_hash = self._create_genesis()
    
    def _create_genesis(self):
        data = f"GENESIS:{self.organism_key}:{PHI}:{time.time()}"
        return hashlib.sha256(data.encode()).hexdigest()
