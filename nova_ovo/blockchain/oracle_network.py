"""Oracle network for phantom sensor data. PROT-161-L."""
import time
PHI = 1.6180339887498948482

class OracleNetwork:
    def __init__(self):
        self.oracles = {}
        self.data_feeds = {}
    
    def register_oracle(self, oid: str, data_type: str):
        self.oracles[oid] = {'data_type': data_type, 'active': True}
    
    def submit_data(self, oid: str, value: float):
        if oid in self.oracles:
            self.data_feeds[oid] = {'value': value, 'timestamp': time.time()}
            return True
        return False
    
    def get_aggregated_value(self, data_type: str):
        values = [
            self.data_feeds[oid]['value']
            for oid, oracle in self.oracles.items()
            if oracle['data_type'] == data_type and oid in self.data_feeds
        ]
        if not values:
            return None
        return sum(values) / len(values)
