"""Block explorer with torus visualization. PROT-161-J."""
PHI = 1.6180339887498948482

class BlockExplorer:
    def __init__(self, chain=None):
        self.chain = chain
    
    def get_block(self, index: int):
        if self.chain and index < len(self.chain.chain):
            return self.chain.chain[index]
        return None
    
    def search_transaction(self, tx_id: str):
        if not self.chain:
            return None
        for block in self.chain.chain:
            for tx in block.transactions:
                if tx.get('tx_id') == tx_id:
                    return tx
        return None
