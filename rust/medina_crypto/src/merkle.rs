// ═══════════════════════════════════════════════════════════════════════════════
// MEDINA - PROPRIETARY AND CONFIDENTIAL
// Copyright © 2024-2026 Alfredo Medina, Medina Tech, Dallas, Texas, USA
// medinasiftech@outlook.com | ALL RIGHTS RESERVED
// ═══════════════════════════════════════════════════════════════════════════════
//
// merkle.rs — ANIMA MERKLE TREE FOR IP REGISTRATION
//
// Merkle tree construction for comprehensive IP hash registration.
// All code hashes are organized into a verifiable tree structure.
//
// ═══════════════════════════════════════════════════════════════════════════════

use crate::anima_hash::{anima_hash, combine_hashes, AnimaHash, ANIMA_HASH_SIZE};

/// Merkle tree node
#[derive(Clone, Debug)]
pub struct MerkleNode {
    pub hash: AnimaHash,
    pub left: Option<Box<MerkleNode>>,
    pub right: Option<Box<MerkleNode>>,
    pub is_leaf: bool,
    pub data_ref: Option<String>,  // Reference to original data (file path, etc.)
}

impl MerkleNode {
    /// Create a leaf node
    pub fn leaf(data: &[u8], data_ref: Option<String>) -> Self {
        Self {
            hash: anima_hash(data),
            left: None,
            right: None,
            is_leaf: true,
            data_ref,
        }
    }
    
    /// Create an internal node from two children
    pub fn internal(left: MerkleNode, right: MerkleNode) -> Self {
        let hash = combine_hashes(&left.hash, &right.hash);
        Self {
            hash,
            left: Some(Box::new(left)),
            right: Some(Box::new(right)),
            is_leaf: false,
            data_ref: None,
        }
    }
}

/// Merkle tree for IP registration
#[derive(Clone, Debug)]
pub struct MerkleTree {
    pub root: Option<MerkleNode>,
    pub leaf_count: usize,
}

impl MerkleTree {
    /// Build a Merkle tree from a list of data items
    pub fn build(items: &[(Vec<u8>, Option<String>)]) -> Self {
        if items.is_empty() {
            return Self {
                root: None,
                leaf_count: 0,
            };
        }
        
        // Create leaf nodes
        let mut nodes: Vec<MerkleNode> = items.iter()
            .map(|(data, data_ref)| MerkleNode::leaf(data, data_ref.clone()))
            .collect();
        
        let leaf_count = nodes.len();
        
        // Build tree bottom-up
        while nodes.len() > 1 {
            let mut next_level = Vec::new();
            
            for i in (0..nodes.len()).step_by(2) {
                if i + 1 < nodes.len() {
                    let left = nodes[i].clone();
                    let right = nodes[i + 1].clone();
                    next_level.push(MerkleNode::internal(left, right));
                } else {
                    // Odd node - duplicate it
                    let left = nodes[i].clone();
                    let right = nodes[i].clone();
                    next_level.push(MerkleNode::internal(left, right));
                }
            }
            
            nodes = next_level;
        }
        
        Self {
            root: nodes.into_iter().next(),
            leaf_count,
        }
    }
    
    /// Get the root hash
    pub fn root_hash(&self) -> Option<AnimaHash> {
        self.root.as_ref().map(|n| n.hash.clone())
    }
    
    /// Get proof of inclusion for a leaf
    pub fn get_proof(&self, leaf_index: usize) -> Option<MerkleProof> {
        if leaf_index >= self.leaf_count {
            return None;
        }
        
        let mut proof = Vec::new();
        let mut current_index = leaf_index;
        let mut level_size = self.leaf_count;
        
        // Traverse tree to collect sibling hashes
        fn collect_siblings(
            node: &MerkleNode,
            target_index: usize,
            level_size: usize,
            proof: &mut Vec<(AnimaHash, bool)>,
        ) -> Option<AnimaHash> {
            if node.is_leaf {
                return Some(node.hash.clone());
            }
            
            let left = node.left.as_ref()?;
            let right = node.right.as_ref()?;
            
            let half = (level_size + 1) / 2;
            
            if target_index < half {
                // Go left, add right sibling
                let result = collect_siblings(left, target_index, half, proof);
                proof.push((right.hash.clone(), true));  // true = sibling is on right
                result
            } else {
                // Go right, add left sibling
                let result = collect_siblings(right, target_index - half, level_size - half, proof);
                proof.push((left.hash.clone(), false));  // false = sibling is on left
                result
            }
        }
        
        if let Some(root) = &self.root {
            let mut proof_vec = Vec::new();
            if let Some(leaf_hash) = collect_siblings(root, leaf_index, self.leaf_count, &mut proof_vec) {
                proof_vec.reverse();
                return Some(MerkleProof {
                    leaf_hash,
                    siblings: proof_vec,
                    leaf_index,
                });
            }
        }
        
        None
    }
    
    /// Verify a proof
    pub fn verify_proof(&self, proof: &MerkleProof) -> bool {
        let root_hash = match &self.root {
            Some(node) => &node.hash,
            None => return false,
        };
        
        let mut current_hash = proof.leaf_hash.clone();
        
        for (sibling_hash, is_right) in &proof.siblings {
            current_hash = if *is_right {
                combine_hashes(&current_hash, sibling_hash)
            } else {
                combine_hashes(sibling_hash, &current_hash)
            };
        }
        
        &current_hash == root_hash
    }
}

/// Proof of inclusion in Merkle tree
#[derive(Clone, Debug)]
pub struct MerkleProof {
    pub leaf_hash: AnimaHash,
    pub siblings: Vec<(AnimaHash, bool)>,  // (hash, is_right_sibling)
    pub leaf_index: usize,
}

impl MerkleProof {
    /// Compute the root hash from this proof
    pub fn compute_root(&self) -> AnimaHash {
        let mut current = self.leaf_hash.clone();
        
        for (sibling, is_right) in &self.siblings {
            current = if *is_right {
                combine_hashes(&current, sibling)
            } else {
                combine_hashes(sibling, &current)
            };
        }
        
        current
    }
    
    /// Convert to bytes for transmission
    pub fn to_bytes(&self) -> Vec<u8> {
        let mut bytes = Vec::new();
        
        // Leaf hash
        bytes.extend_from_slice(&self.leaf_hash.bytes);
        
        // Number of siblings
        bytes.extend_from_slice(&(self.siblings.len() as u32).to_le_bytes());
        
        // Each sibling
        for (hash, is_right) in &self.siblings {
            bytes.extend_from_slice(&hash.bytes);
            bytes.push(if *is_right { 1 } else { 0 });
        }
        
        // Leaf index
        bytes.extend_from_slice(&(self.leaf_index as u64).to_le_bytes());
        
        bytes
    }
}

/// IP Registration entry
#[derive(Clone, Debug)]
pub struct IPRegistration {
    pub file_path: String,
    pub content_hash: AnimaHash,
    pub line_count: usize,
    pub created_at: u64,
    pub merkle_index: usize,
}

/// IP Registry with Merkle tree
pub struct IPRegistry {
    pub registrations: Vec<IPRegistration>,
    pub merkle_tree: Option<MerkleTree>,
}

impl IPRegistry {
    /// Create new empty registry
    pub fn new() -> Self {
        Self {
            registrations: Vec::new(),
            merkle_tree: None,
        }
    }
    
    /// Register a file
    pub fn register_file(&mut self, file_path: &str, content: &[u8], created_at: u64) -> usize {
        let content_hash = anima_hash(content);
        let line_count = content.iter().filter(|&&b| b == b'\n').count() + 1;
        let merkle_index = self.registrations.len();
        
        self.registrations.push(IPRegistration {
            file_path: file_path.to_string(),
            content_hash,
            line_count,
            created_at,
            merkle_index,
        });
        
        merkle_index
    }
    
    /// Build Merkle tree from all registrations
    pub fn build_merkle_tree(&mut self) {
        let items: Vec<(Vec<u8>, Option<String>)> = self.registrations.iter()
            .map(|reg| (reg.content_hash.bytes.to_vec(), Some(reg.file_path.clone())))
            .collect();
        
        self.merkle_tree = Some(MerkleTree::build(&items));
    }
    
    /// Get root hash of registry
    pub fn root_hash(&self) -> Option<AnimaHash> {
        self.merkle_tree.as_ref().and_then(|t| t.root_hash())
    }
    
    /// Get proof for a registration
    pub fn get_proof(&self, registration_index: usize) -> Option<MerkleProof> {
        self.merkle_tree.as_ref().and_then(|t| t.get_proof(registration_index))
    }
    
    /// Verify a registration's proof
    pub fn verify(&self, registration_index: usize) -> bool {
        if let Some(proof) = self.get_proof(registration_index) {
            if let Some(tree) = &self.merkle_tree {
                return tree.verify_proof(&proof);
            }
        }
        false
    }
}

impl Default for IPRegistry {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_merkle_leaf() {
        let leaf = MerkleNode::leaf(b"test data", Some("file.txt".to_string()));
        assert!(leaf.is_leaf);
        assert_eq!(leaf.data_ref, Some("file.txt".to_string()));
    }
    
    #[test]
    fn test_merkle_tree_build() {
        let items = vec![
            (b"data1".to_vec(), Some("file1.txt".to_string())),
            (b"data2".to_vec(), Some("file2.txt".to_string())),
            (b"data3".to_vec(), Some("file3.txt".to_string())),
            (b"data4".to_vec(), Some("file4.txt".to_string())),
        ];
        
        let tree = MerkleTree::build(&items);
        assert_eq!(tree.leaf_count, 4);
        assert!(tree.root.is_some());
    }
    
    #[test]
    fn test_merkle_proof() {
        let items = vec![
            (b"data1".to_vec(), None),
            (b"data2".to_vec(), None),
            (b"data3".to_vec(), None),
            (b"data4".to_vec(), None),
        ];
        
        let tree = MerkleTree::build(&items);
        
        // Get proof for each leaf
        for i in 0..4 {
            let proof = tree.get_proof(i).expect("Proof should exist");
            assert!(tree.verify_proof(&proof), "Proof {} should verify", i);
        }
    }
    
    #[test]
    fn test_ip_registry() {
        let mut registry = IPRegistry::new();
        
        registry.register_file("src/main.rs", b"fn main() {}", 1000);
        registry.register_file("src/lib.rs", b"pub mod test;", 1001);
        
        registry.build_merkle_tree();
        
        assert!(registry.root_hash().is_some());
        assert!(registry.verify(0));
        assert!(registry.verify(1));
    }
}
