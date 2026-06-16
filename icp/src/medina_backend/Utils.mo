/**
 * MEDINA Utils Module — Utility functions for ICP implementation.
 */

import Array "mo:base/Array";
import Float "mo:base/Float";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Blob "mo:base/Blob";

module {
    /// Generate a simple unique ID based on timestamp and counter
    public func generateId(prefix: Text, counter: Nat) : Text {
        let timestamp = Int.abs(Time.now());
        prefix # "-" # Nat.toText(timestamp) # "-" # Nat.toText(counter)
    };
    
    /// Calculate PI constant
    public let PI : Float = 3.141592653589793;
    
    /// Calculate 2*PI
    public let TWO_PI : Float = 6.283185307179586;
    
    /// Float modulo operation
    public func fmod(x: Float, y: Float) : Float {
        x - y * Float.floor(x / y)
    };
    
    /// Clamp a float value between min and max
    public func clamp(value: Float, min: Float, max: Float) : Float {
        if (value < min) { min }
        else if (value > max) { max }
        else { value }
    };
    
    /// Check if a text contains a substring (case-insensitive)
    public func containsIgnoreCase(haystack: Text, needle: Text) : Bool {
        let lowerHaystack = Text.toLowercase(haystack);
        let lowerNeedle = Text.toLowercase(needle);
        Text.contains(lowerHaystack, #text lowerNeedle)
    };
    
    /// Check if any element in array matches predicate
    public func anyMatch<T>(arr: [T], pred: T -> Bool) : Bool {
        for (item in arr.vals()) {
            if (pred(item)) { return true };
        };
        false
    };
    
    /// Filter array by predicate
    public func filter<T>(arr: [T], pred: T -> Bool) : [T] {
        Array.filter<T>(arr, pred)
    };
    
    /// Take first n elements from array
    public func take<T>(arr: [T], n: Nat) : [T] {
        if (n >= arr.size()) { return arr };
        Array.tabulate<T>(n, func(i: Nat) : T { arr[i] })
    };
    
    /// Calculate current timestamp in nanoseconds
    public func now() : Int {
        Time.now()
    };
    
    /// Convert nanoseconds to seconds
    public func nsToSeconds(ns: Int) : Int {
        ns / 1_000_000_000
    };
}
