"""
Memory Temple Tests — Torus Navigation Validation
===================================================
Tests for MemoryTemple, MemoryNode, and coordinate systems.
"""

import math
import unittest
from nova_ovo.memory.temple import (
    MemoryTemple,
    MemoryNode,
    MemoryType,
    SalienceLevel,
)
from nova_ovo.core.recital import PHI, TORUS_R


class TestMemoryNode(unittest.TestCase):
    """Test MemoryNode functionality."""
    
    def test_create_node(self):
        """Test creating a memory node."""
        node = MemoryNode(content="Test memory")
        
        self.assertEqual(node.content, "Test memory")
        self.assertIsNotNone(node.node_id)
        self.assertEqual(node.memory_type, MemoryType.EPISODIC)
        self.assertEqual(node.salience, SalienceLevel.MEDIUM)
    
    def test_torus_coordinates(self):
        """Test torus coordinate system."""
        node = MemoryNode(
            theta=math.pi / 4,
            phi=math.pi / 2,
            depth=1.0,
        )
        
        x, y, z = node.torus_xyz()
        
        # Verify torus embedding formulas
        expected_x = (TORUS_R + 1.0 * math.cos(math.pi/4)) * math.cos(math.pi/2)
        expected_y = (TORUS_R + 1.0 * math.cos(math.pi/4)) * math.sin(math.pi/2)
        expected_z = 1.0 * math.sin(math.pi/4)
        
        self.assertAlmostEqual(x, expected_x, places=5)
        self.assertAlmostEqual(y, expected_y, places=5)
        self.assertAlmostEqual(z, expected_z, places=5)
    
    def test_distance_calculation(self):
        """Test Euclidean distance calculation."""
        node1 = MemoryNode(theta=0.0, phi=0.0, depth=1.0)
        node2 = MemoryNode(theta=math.pi, phi=math.pi, depth=1.0)
        
        distance = node1.distance_to(node2)
        
        # Distance should be positive
        self.assertGreater(distance, 0)
    
    def test_angular_distance(self):
        """Test angular distance on torus."""
        node1 = MemoryNode(theta=0.0, phi=0.0)
        node2 = MemoryNode(theta=math.pi/2, phi=math.pi/2)
        
        angular_dist = node1.angular_distance(node2)
        
        expected = math.sqrt((math.pi/2)**2 + (math.pi/2)**2)
        self.assertAlmostEqual(angular_dist, expected, places=5)
    
    def test_angular_distance_wrapping(self):
        """Test angular distance handles wrap-around."""
        node1 = MemoryNode(theta=0.1, phi=0.1)
        node2 = MemoryNode(theta=2*math.pi - 0.1, phi=2*math.pi - 0.1)
        
        angular_dist = node1.angular_distance(node2)
        
        # Should be close, not far
        expected = math.sqrt(0.2**2 + 0.2**2)
        self.assertAlmostEqual(angular_dist, expected, places=5)
    
    def test_lineage_tracking(self):
        """Test parent/child tracking."""
        parent = MemoryNode(content="Parent")
        child = MemoryNode(content="Child", parent_id=parent.node_id)
        
        parent.children_ids.append(child.node_id)
        
        self.assertEqual(child.parent_id, parent.node_id)
        self.assertIn(child.node_id, parent.children_ids)
    
    def test_to_dict(self):
        """Test serialization."""
        node = MemoryNode(
            content="Test",
            memory_type=MemoryType.SEMANTIC,
            salience=SalienceLevel.HIGH,
            tags=["test", "important"],
        )
        
        d = node.to_dict()
        
        self.assertEqual(d["content"], "Test")
        self.assertEqual(d["memory_type"], "semantic")
        self.assertEqual(d["salience"], "high")
        self.assertIn("test", d["tags"])
        self.assertIn("coordinates", d)
        self.assertIn("xyz", d["coordinates"])


class TestMemoryTemple(unittest.TestCase):
    """Test MemoryTemple functionality."""
    
    def setUp(self):
        self.temple = MemoryTemple()
    
    def test_initial_state(self):
        """Test initial temple state."""
        self.assertEqual(self.temple.node_count, 0)
        self.assertEqual(self.temple.current_beat, 0)
    
    def test_store_memory(self):
        """Test storing a memory."""
        node = self.temple.store("Test memory content")
        
        self.assertIsNotNone(node)
        self.assertEqual(node.content, "Test memory content")
        self.assertEqual(self.temple.node_count, 1)
    
    def test_store_increments_beat(self):
        """Test store increments beat."""
        self.temple.store("Memory 1")
        self.temple.store("Memory 2")
        
        self.assertEqual(self.temple.current_beat, 2)
    
    def test_store_advances_coordinates(self):
        """Test store advances torus coordinates."""
        node1 = self.temple.store("First")
        node2 = self.temple.store("Second")
        
        # Coordinates should differ
        self.assertNotEqual(node1.theta, node2.theta)
        self.assertNotEqual(node1.phi, node2.phi)
    
    def test_store_with_type(self):
        """Test storing with specific type."""
        node = self.temple.store(
            "Procedural memory",
            memory_type=MemoryType.PROCEDURAL,
        )
        
        self.assertEqual(node.memory_type, MemoryType.PROCEDURAL)
    
    def test_store_with_salience(self):
        """Test storing with specific salience."""
        node = self.temple.store(
            "Critical memory",
            salience=SalienceLevel.CRITICAL,
        )
        
        self.assertEqual(node.salience, SalienceLevel.CRITICAL)
    
    def test_store_with_parent(self):
        """Test storing with parent linkage."""
        parent = self.temple.store("Parent memory")
        child = self.temple.store("Child memory", parent_id=parent.node_id)
        
        self.assertEqual(child.parent_id, parent.node_id)
        self.assertIn(child.node_id, parent.children_ids)
    
    def test_get_by_id(self):
        """Test retrieving by ID."""
        stored = self.temple.store("Retrievable")
        
        retrieved = self.temple.get(stored.node_id)
        
        self.assertEqual(retrieved.content, "Retrievable")
    
    def test_get_updates_access(self):
        """Test get updates access metadata."""
        node = self.temple.store("Memory")
        initial_count = node.access_count
        
        self.temple.get(node.node_id)
        
        self.assertEqual(node.access_count, initial_count + 1)
    
    def test_get_nonexistent(self):
        """Test getting nonexistent returns None."""
        result = self.temple.get("nonexistent_id")
        self.assertIsNone(result)
    
    def test_find_by_content(self):
        """Test finding by content substring."""
        self.temple.store("Apple pie recipe")
        self.temple.store("Banana bread recipe")
        self.temple.store("Cherry tart")
        
        results = self.temple.find("recipe")
        
        self.assertEqual(len(results), 2)
    
    def test_find_by_type(self):
        """Test finding by memory type."""
        self.temple.store("Episodic", memory_type=MemoryType.EPISODIC)
        self.temple.store("Semantic", memory_type=MemoryType.SEMANTIC)
        self.temple.store("Episodic2", memory_type=MemoryType.EPISODIC)
        
        results = self.temple.find("", memory_type=MemoryType.EPISODIC)
        
        self.assertEqual(len(results), 2)
    
    def test_find_by_salience(self):
        """Test finding by salience level."""
        self.temple.store("High", salience=SalienceLevel.HIGH)
        self.temple.store("Low", salience=SalienceLevel.LOW)
        self.temple.store("High2", salience=SalienceLevel.HIGH)
        
        results = self.temple.find("", salience=SalienceLevel.HIGH)
        
        self.assertEqual(len(results), 2)
    
    def test_find_by_tags(self):
        """Test finding by tags."""
        self.temple.store("Tagged", tags=["important", "urgent"])
        self.temple.store("Other", tags=["misc"])
        
        results = self.temple.find("", tags=["important"])
        
        self.assertEqual(len(results), 1)
        self.assertEqual(results[0].content, "Tagged")
    
    def test_find_limit(self):
        """Test find respects limit."""
        for i in range(20):
            self.temple.store(f"Memory {i}")
        
        results = self.temple.find("Memory", limit=5)
        
        self.assertEqual(len(results), 5)
    
    def test_find_sorted_by_salience(self):
        """Test results sorted by salience."""
        self.temple.store("Low", salience=SalienceLevel.LOW)
        self.temple.store("Critical", salience=SalienceLevel.CRITICAL)
        self.temple.store("Medium", salience=SalienceLevel.MEDIUM)
        
        results = self.temple.find("")
        
        self.assertEqual(results[0].salience, SalienceLevel.CRITICAL)
    
    def test_traverse_by_coordinates(self):
        """Test navigation by coordinates."""
        # Store a node and capture its coordinates
        node = self.temple.store("Target")
        
        # Traverse to those coordinates
        found = self.temple.traverse({
            "theta": node.theta,
            "phi": node.phi,
        })
        
        self.assertEqual(found.node_id, node.node_id)
    
    def test_traverse_by_ring(self):
        """Test traversal filtering by ring."""
        # Create nodes in different rings (this requires many stores)
        nodes = []
        for i in range(100):
            nodes.append(self.temple.store(f"Node {i}"))
        
        # Find a node and its ring
        target = nodes[-1]
        
        found = self.temple.traverse({
            "theta": target.theta,
            "phi": target.phi,
            "ring": target.ring,
        })
        
        self.assertEqual(found.node_id, target.node_id)
    
    def test_lineage_chain(self):
        """Test lineage traces ancestry."""
        root = self.temple.store("Root")
        child1 = self.temple.store("Child1", parent_id=root.node_id)
        child2 = self.temple.store("Child2", parent_id=child1.node_id)
        
        lineage = self.temple.lineage(child2.node_id)
        
        self.assertEqual(len(lineage), 3)
        self.assertEqual(lineage[0].node_id, root.node_id)
        self.assertEqual(lineage[2].node_id, child2.node_id)
    
    def test_descendants(self):
        """Test getting all descendants."""
        root = self.temple.store("Root")
        child1 = self.temple.store("Child1", parent_id=root.node_id)
        child2 = self.temple.store("Child2", parent_id=root.node_id)
        grandchild = self.temple.store("Grandchild", parent_id=child1.node_id)
        
        descendants = self.temple.descendants(root.node_id)
        
        self.assertEqual(len(descendants), 3)
    
    def test_descendants_max_depth(self):
        """Test descendants respects max depth."""
        root = self.temple.store("Root")
        level1 = self.temple.store("L1", parent_id=root.node_id)
        level2 = self.temple.store("L2", parent_id=level1.node_id)
        level3 = self.temple.store("L3", parent_id=level2.node_id)
        
        descendants = self.temple.descendants(root.node_id, max_depth=2)
        
        # Should include L1 and L2 but not L3
        self.assertEqual(len(descendants), 2)
    
    def test_topology(self):
        """Test topology summary."""
        self.temple.store("E1", memory_type=MemoryType.EPISODIC, salience=SalienceLevel.HIGH)
        self.temple.store("S1", memory_type=MemoryType.SEMANTIC, salience=SalienceLevel.LOW)
        self.temple.store("E2", memory_type=MemoryType.EPISODIC, salience=SalienceLevel.HIGH)
        
        topology = self.temple.get_topology()
        
        self.assertEqual(topology["total_nodes"], 3)
        self.assertEqual(topology["by_type"]["episodic"], 2)
        self.assertEqual(topology["by_type"]["semantic"], 1)
        self.assertEqual(topology["by_salience"]["high"], 2)
    
    def test_traversal_path(self):
        """Test shared traversal path."""
        n1 = self.temple.store("Node1")
        n2 = self.temple.store("Node2")
        
        # Access n1
        self.temple.get(n1.node_id)
        
        path = self.temple.get_traversal_path()
        
        # Path includes stores and accesses
        self.assertGreater(len(path), 0)
    
    def test_doctrine_alignment(self):
        """Test doctrine alignment storage."""
        node = self.temple.store(
            "Aligned memory",
            doctrine_alignment=0.95,
        )
        
        self.assertEqual(node.doctrine_alignment, 0.95)


class TestMemoryTypes(unittest.TestCase):
    """Test memory type enumeration."""
    
    def test_all_types_exist(self):
        """Test all memory types exist."""
        types = [
            MemoryType.EPISODIC,
            MemoryType.SEMANTIC,
            MemoryType.PROCEDURAL,
            MemoryType.WORKING,
            MemoryType.DOCTRINE,
        ]
        
        self.assertEqual(len(types), 5)
    
    def test_type_values(self):
        """Test type string values."""
        self.assertEqual(MemoryType.EPISODIC.value, "episodic")
        self.assertEqual(MemoryType.SEMANTIC.value, "semantic")


class TestSalienceLevels(unittest.TestCase):
    """Test salience level enumeration."""
    
    def test_all_levels_exist(self):
        """Test all salience levels exist."""
        levels = [
            SalienceLevel.CRITICAL,
            SalienceLevel.HIGH,
            SalienceLevel.MEDIUM,
            SalienceLevel.LOW,
            SalienceLevel.DORMANT,
        ]
        
        self.assertEqual(len(levels), 5)
    
    def test_level_values(self):
        """Test level string values."""
        self.assertEqual(SalienceLevel.CRITICAL.value, "critical")
        self.assertEqual(SalienceLevel.DORMANT.value, "dormant")


class TestTorusGeometry(unittest.TestCase):
    """Test torus geometry calculations."""
    
    def test_torus_major_radius(self):
        """Test torus major radius is PHI scaled."""
        self.assertAlmostEqual(TORUS_R, PHI * 10.0, places=5)
    
    def test_coordinates_stay_bounded(self):
        """Test coordinates stay in valid ranges."""
        temple = MemoryTemple()
        
        for i in range(1000):
            node = temple.store(f"Node {i}")
            
            self.assertGreaterEqual(node.theta, 0)
            self.assertLess(node.theta, 2 * math.pi)
            self.assertGreaterEqual(node.phi, 0)
            self.assertLess(node.phi, 2 * math.pi)
    
    def test_ring_advances(self):
        """Test ring advances with phi cycle."""
        temple = MemoryTemple()
        
        # Store many nodes to advance ring
        nodes = []
        for i in range(500):
            nodes.append(temple.store(f"Node {i}"))
        
        # Should have advanced at least one ring
        rings = set(n.ring for n in nodes)
        self.assertGreater(len(rings), 1)


if __name__ == "__main__":
    unittest.main()
