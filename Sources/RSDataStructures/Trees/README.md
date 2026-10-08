# Trees

A protocol hierarchy for binary trees. Each protocol adds one invariant, and
ships the default implementations that the invariant makes possible. A concrete
tree picks the protocols whose invariants it can keep and gets those defaults
for free.

Nodes are trees: every type here is a recursive class whose children are of its
own type. Items are `KeyValuePair`s, ordered by key.

## The protocols

All four live in `BinaryTree.swift`.

```
BinaryTree
├── BinarySearchTree        smaller keys on the left, larger on the right
├── CompleteBinaryTree      every level full; the last one filled left to right
└── TraversableBinaryTree   children are plain left/right links, nothing else
```

| Protocol | What the invariant buys |
|---|---|
| `BinaryTree` | Structure only: `maximumHeight` in O(N), `isBalanced`, `isBinarySearchTree`, `pathsFromRootToLeaves`, `==`. |
| `BinarySearchTree` | `search`, `minimum` and `maximum` by following one branch. |
| `CompleteBinaryTree` | `maximumHeight` in O(log N), by following the left edge. |
| `TraversableBinaryTree` | `Sequence` conformance through an in-order iterator, which can be swapped for any other traversal by setting `iterator`. Also `bottommostRightmostNode`. |
| `CompleteBinaryTree` and `TraversableBinaryTree` together | `nextIncompleteNode`: where the next insertion has to go to keep the tree complete. |

## Traversals

`TreeTraversals.swift` has in-order, post-order, right-to-left post-order and
breadth-first traversals as free functions over any `TraversableBinaryTree`.
They are iterative, with an explicit stack or queue, and return a lazy
`AnyIterator`. Two of them also yield the height of each node, which is what
`bottommostRightmostNode` and `nextIncompleteNode` are built on.

## Concrete trees

| Type | Conforms to | Notes |
|---|---|---|
| `BasicBinarySearchTree` | `BinarySearchTree`, `TraversableBinaryTree` | Unbalanced search tree. Only writes `insert` and `delete`. |
| `BasicBinaryHeap` | `CompleteBinaryTree`, `TraversableBinaryTree`, `PriorityQueue` | Min or max heap built from linked nodes rather than an array. Priorities can be updated by value. `search` and `delete(elementWithKey:)` are not implemented. |
| `SinglyThreadedBinarySearchTree` | `BinarySearchTree`, `Collection` | Each node links to its in-order successor, so iteration needs no stack. |

`SinglyThreadedBinarySearchTree` is deliberately not a `TraversableBinaryTree`.
Its nodes carry more than left and right links, so the generic traversals would
not be correct on it, and it provides its own iterator instead. That is the
reason `TraversableBinaryTree` exists as a separate protocol.

## Reading order

1. `BinaryTree.swift`: the protocols and their defaults.
2. `TreeTraversals.swift`: the iterators the defaults rely on.
3. `BasicBinarySearchTree.swift`: the smallest conformer.
4. `BinaryHeap.swift`: a conformer that leans on the defaults of two protocols.
5. `SinglyThreadedBinarySearchTree.swift`: the one that opts out of traversal.

Tests are in `Tests/RSDataStructuresTests/Trees`.
