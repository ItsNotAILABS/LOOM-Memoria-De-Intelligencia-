"""Fibonacci-indexed Merkle tree. PROT-161-H."""
import hashlib
PHI = 1.6180339887498948482

class MemoryMerkleTree:
    def __init__(self):
        self.nodes = {}
        self.root = None
    
    def add_leaf(self, data: str):
        leaf_hash = hashlib.sha256(data.encode()).hexdigest()
        self.nodes[leaf_hash] = data
        return leaf_hash
    
    def compute_root(self):
        if not self.nodes:
            return None
        hashes = list(self.nodes.keys())
        while len(hashes) > 1:
            new_level = []
            for i in range(0, len(hashes), 2):
                if i + 1 < len(hashes):
                    combined = hashes[i] + hashes[i+1]
                else:
                    combined = hashes[i] + hashes[i]
                new_level.append(hashlib.sha256(combined.encode()).hexdigest())
            hashes = new_level
        self.root = hashes[0] if hashes else None
        return self.root
