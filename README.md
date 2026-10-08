# RSDataStructures

A Swift package of data structures written from scratch, built around Swift's own tools: protocols with default implementations in extensions, value types with copy-on-write, type erasure and standard-library conformances such as `Sequence` and `Collection`.

## Contents

- **Lists**: `SinglyLinkedList`, a struct with value semantics through copy-on-write, usable as a `Collection`, a queue and an array literal.
- **Stacks**: a `Stack` protocol, a linked-list stack and `MinMaxStack`, which returns the minimum or maximum in O(1).
- **Priority queues**: `Queue` and `PriorityQueue` protocols, an array-based heap, a bounded-height priority queue, and `AnyQueue`, a type-erased wrapper.
- **Trees**: a protocol hierarchy where each protocol adds an invariant and the defaults it allows, with a binary search tree, a threaded search tree and a binary heap, plus lazy traversal iterators. See the [Trees README](Sources/RSDataStructures/Trees/README.md).
- **Graphs**: a `Graph` protocol with topological sort and shortest path as extension defaults, and an adjacency-list implementation.

## Tests

    swift test
