//
//  BasicBinaryHeapTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 06/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest
import RSDataStructures

class BasicBinaryMinHeapTests: XCTestCase {
    
    func testInsertionWithValueType() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(3))
        heap.insert(item: p(4))
        heap.insert(item: p(6))
        heap.insert(item: p(8))
        heap.insert(item: p(1))
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 1)
        XCTAssertTrue(heap.top()?.item?.key == 3)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 3)
        XCTAssertTrue(heap.top()?.item?.key == 4)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 4)
        XCTAssertTrue(heap.top()?.item?.key == 5)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 5)
        XCTAssertTrue(heap.top()?.item?.key == 6)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 6)
        XCTAssertTrue(heap.top()?.item?.key == 8)

        XCTAssertTrue(heap.extractTop()?.item?.key == 8)
        XCTAssertTrue(heap.top() == nil)
        XCTAssertTrue(heap.item == nil)
        XCTAssertTrue(heap.leftChild == nil)
        XCTAssertTrue(heap.rightChild == nil)

        heap.insert(item: p(1))
        XCTAssertTrue(heap.top()?.item?.key == 1)

    }
    
    func testInsertionWithReferenceType() {
        let heap = BasicBinaryHeap<DataContainer>(value: DataContainer(key:5.0, value:"adf"), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: DataContainer(key:3.0, value:"adf"))
        heap.insert(item: DataContainer(key:4.0, value:"adf"))
        heap.insert(item: DataContainer(key:6.0, value:"adf"))
        heap.insert(item: DataContainer(key:8.0, value:"adf"))
        heap.insert(item: DataContainer(key:1.0, value:"adf"))
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 1.0)
        XCTAssertTrue(heap.top()?.item?.key == 3.0)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 3.0)
        XCTAssertTrue(heap.top()?.item?.key == 4.0)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 4.0)
        XCTAssertTrue(heap.top()?.item?.key == 5.0)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 5.0)
        XCTAssertTrue(heap.top()?.item?.key == 6.0)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 6.0)
        XCTAssertTrue(heap.top()?.item?.key == 8.0)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 8.0)
        XCTAssertTrue(heap.top() == nil)
        XCTAssertTrue(heap.item == nil)
        XCTAssertTrue(heap.leftChild == nil)
        XCTAssertTrue(heap.rightChild == nil)

        heap.insert(item: DataContainer(key: 1.1, value: ""))
        XCTAssertTrue(heap.top()?.item?.key == 1.1)
    }
    
    func testNextFreeNode() {
        // Test cases for nextIncompleteNode() method in min heap
        // Each case: (insertions, expectedKey, treeVisualization, explanation)
        let testCases: [(insertions: [Int], expectedKey: Int)] = [
            // Case 1: Perfect complete tree (3 nodes)
			//	Original tree (before bubble-up):
			//		  20
			//		 /  \
			//	   15    25
			//
			//	Final tree (after min heap bubble-up):
			//		  15
			//		 /  \
			//	   20    25
            ([15, 25], 20),
            
            // Case 2: Only left child inserted
			//	Original tree (before bubble-up):
			//		  20
			//		 /
			//	   15
			//
			//	Final tree (after min heap bubble-up):
			//		  15
			//		 /
			//	   20
            ([15], 15),
            
            // Case 3: Only right child inserted
			//	Original tree (before bubble-up):
			//		  20
			//		   \
			//		   25
			//
			//	Final tree (after min heap bubble-up):
			//		  20
			//		   \
			//		   25
            ([25], 20),
            
            // Case 4: Only root node
            ([], 20),

			// Case 5: Full tree with two levels of children. More levels //
			// Final tree (after min heap bubble-up):
			//         14
			//       /    \
			//     15      16
			//    /  \    /  \
			//  20   25 23   26
			([15, 25, 14, 16, 23, 26], 20)
        ]
        
        for (index, testCase) in testCases.enumerated() {
            // Given: A min heap with root node 20
            let heap = BasicBinaryHeap<IntegerPair>(
                value: p(20),
                parent: nil, 
                leftChild: nil, 
                rightChild: nil, 
                type: .min
            )
            
            // When: Inserting the specified elements (min heap bubble-up occurs)
            for value in testCase.insertions {
                heap.insert(item: p(value))
            }
            
            // Then: nextIncompleteNode should return the expected node
            let nextNode = heap.nextIncompleteNode()
            XCTAssertEqual(nextNode.item?.key, testCase.expectedKey, "Test case \(index + 1): expected \(testCase.expectedKey), got \(nextNode.item?.key ?? -1)")
        }
    }
    
    func testBalancedTreeWhenInsertionOrderIsConvenient() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(3))
        heap.insert(item: p(7))
        heap.insert(item: p(1))
        heap.insert(item: p(6))
        
        XCTAssertTrue(heap.isBalanced())
    }
    
    func testBalancedTreeWhenInsertionOrderIsUnconvenient() {
        var heap = BasicBinaryHeap<IntegerPair>(value: p(1), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(2))
        heap.insert(item: p(3))
        heap.insert(item: p(4))
        heap.insert(item: p(5))
        heap.insert(item: p(6))
        XCTAssertTrue(heap.isBalanced())
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(7), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(6))
        heap.insert(item: p(5))
        heap.insert(item: p(4))
        heap.insert(item: p(3))
        heap.insert(item: p(2))
        heap.insert(item: p(1))
        XCTAssertTrue(heap.isBalanced())
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(3))
        heap.insert(item: p(17))
        heap.insert(item: p(1))
        heap.insert(item: p(6))
        heap.insert(item: p(19))
        heap.insert(item: p(20))
        
        XCTAssertTrue(heap.isBalanced())
    }
    
    func testIsBinarySearchTreeFalse() {
        var heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        XCTAssertTrue(heap.isBinarySearchTree())
        heap.insert(item: p(70))
        XCTAssertFalse(heap.isBinarySearchTree())
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        XCTAssertTrue(heap.isBinarySearchTree())
        heap.insert(item: p(4))
        XCTAssertFalse(heap.isBinarySearchTree())
        heap.insert(item: p(70))
        XCTAssertFalse(heap.isBinarySearchTree())
    }
}


class BasicBinaryMaxHeapTests: XCTestCase {
    
    func testInsertionAndExtraction() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type:.max)        
        heap.insert(item: p(3))
        heap.insert(item: p(4))
        heap.insert(item: p(6))
        heap.insert(item: p(8))
        heap.insert(item: p(1))
        
        XCTAssertEqual(heap.dequeue()!.key, 8)
        XCTAssertEqual(heap.maximum()?.item?.key, 6)
        XCTAssertEqual(heap.extractTop()?.item?.key, 6)
        XCTAssertEqual(heap.maximum()?.item?.key, 5)
        XCTAssertEqual(heap.extractTop()?.item?.key, 5)
        XCTAssertEqual(heap.maximum()?.item?.key, 4)
        XCTAssertEqual(heap.extractTop()?.item?.key, 4)
        XCTAssertEqual(heap.maximum()?.item?.key, 3)
        XCTAssertEqual(heap.extractTop()?.item?.key, 3)
        XCTAssertEqual(heap.maximum()?.item?.key, 1)
        XCTAssertEqual(heap.extractTop()?.item?.key, 1)
        XCTAssertNil(heap.maximum())
        XCTAssertNil(heap.item)
        XCTAssertNil(heap.leftChild)
        XCTAssertNil(heap.rightChild)
        
        heap.insert(item: p(1))
        XCTAssertTrue(heap.maximum()?.item?.key == 1)
    }
    
    func testInsertionAndExtractionWithElementsWithTheSamePriority() {
        // All elements have the same priority (key = 1001)
        let items = [
            StringValue(key: 1001, value: "A"),
            StringValue(key: 1001, value: "B"),
            StringValue(key: 1001, value: "C"),
            StringValue(key: 1001, value: "D")
        ]
        let heap = BasicBinaryHeap<StringValue>(value: items[0], parent: nil, leftChild: nil, rightChild: nil, type: .max)
        for item in items.dropFirst() {
            try? heap.enqueue(item: item)
        }

        // Remove all, mutate "C" to have lowest priority, re-insert all
        var extracted = [StringValue]()
        while var top = heap.dequeue() {
            if top.value == "C" { top.key = 0 }
            extracted.append(top)
        }
        for item in extracted {
            try? heap.enqueue(item: item)
        }

        // Expect "A", "B", "D" (all key 1001) first, then "C" (key 0) last
        let expectedOrder = [("A", 1001), ("B", 1001), ("D", 1001), ("C", 0)]
        for (expectedValue, expectedKey) in expectedOrder {
            let top = heap.dequeue()
            XCTAssertEqual(top?.value, expectedValue)
            XCTAssertEqual(top?.key, expectedKey)
        }
    }
}

class BasicBinaryHeapUpdateTests: XCTestCase {
    
    func testUpdateThatDoesNotCauseBubbling() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5, 1), parent: nil, leftChild: nil, rightChild: nil, type:.max)
        heap.insert(item: p(3, 2))
        heap.insert(item: p(4, 3))
        heap.insert(item: p(6, 4))
        heap.insert(item: p(8, 5))
        heap.insert(item: p(1, 6))
        
        // Node with key 1 has key 4 as parent. We set the new value to
        // continue to keep the heap property < 4.
        heap.updatePriority(ofValue: 2, to: 2)
        
        // Node with key 5 has key 6 as parent. We set the new value to
        // continue to keep the heap property < 6.
        heap.updatePriority(ofValue: 6, to: 3)
        
        // Node with key 6 has key 8 as parent. We set the new value to
        // continue to keep the heap property < 8.
        heap.updatePriority(ofValue: 4, to: 7)
        
        // Node with key 8 is the root. We set the new value to
        // continue to keep the heap property >= 8.        
        heap.updatePriority(ofValue: 5, to: 9)
        
        var keys = [Int]()
        while let top = heap.extractTop() {
            keys.append(top.item!.key)
        }
        let expectation = [9,7,5,4,3,2]
        
        XCTAssertTrue(expectation == keys)
    }
    
    func testUpdateThatCausesBubbling() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5, 1), parent: nil, leftChild: nil, rightChild: nil, type:.max)
        heap.insert(item: p(3, 2))
        heap.insert(item: p(4, 3))
        heap.insert(item: p(6, 4))
        heap.insert(item: p(8, 5))
        heap.insert(item: p(1, 6))
        
        // Node with key 1 has key 4 as parent. We set the new value to
        // continue to keep the heap property < 4.
        heap.updatePriority(ofValue: 2, to: 10)
        
        // Node with key 5 has key 6 as parent. We set the new value to
        // continue to keep the heap property < 6.
        heap.updatePriority(ofValue: 6, to: 9)
        
        // Node with key 6 has key 8 as parent. We set the new value to
        // continue to keep the heap property < 8.
        heap.updatePriority(ofValue: 4, to: 7)
        
        // Node with key 8 is the root. We set the new value to
        // continue to keep the heap property >= 8.
        heap.updatePriority(ofValue: 2, to: 11)
        
        var keys = [Int]()
        while let top = heap.extractTop() {
            keys.append(top.item!.key)
        }
        let expectation = [11,9,8,7,5,4]
        
        XCTAssertTrue(expectation == keys)
    }
}

class BasicBinaryHeapRelevantChildrenTests: XCTestCase {
    
    func testRelevantChildrenToSwapSingleChildScenarios() {
        // Test extraction from a heap that will create single child scenarios during bubbleDown
        let heap = BasicBinaryHeap<IntegerPair>(value: p(1), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(2))  // This becomes left child of root
        heap.insert(item: p(3))  // This becomes right child of root
        heap.insert(item: p(10)) // This will trigger bubbleDown scenarios
        
        // Extract the minimum (1), causing 10 to replace it and need to bubble down
        let top = heap.extractTop()
        XCTAssertEqual(top?.item?.key, 1)
        
        // The heap should maintain its min heap property
        XCTAssertLessThanOrEqual(heap.item?.key ?? Int.max, heap.leftChild?.item?.key ?? Int.max)
        XCTAssertLessThanOrEqual(heap.item?.key ?? Int.max, heap.rightChild?.item?.key ?? Int.max)
    }
    
    func testRelevantChildrenToSwapTwoChildrenMinHeapSelection() {
        // Create a scenario that will exercise two-children selection in min heap
        let heap = BasicBinaryHeap<IntegerPair>(value: p(1), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(3))   // Left child
        heap.insert(item: p(2))   // Right child (smaller)
        heap.insert(item: p(4))   // Left-left
        heap.insert(item: p(5))   // Left-right  
        heap.insert(item: p(6))   // Right-left
        heap.insert(item: p(7))   // Right-right
        heap.insert(item: p(20))  // This will go to bottom and cause bubbleDown on extraction
        
        // Extract root, forcing bubbleDown to choose between children
        let extracted = heap.extractTop()
        XCTAssertEqual(extracted?.item?.key, 1)
        
        // Verify heap property is maintained by checking root is minimal  
        XCTAssertEqual(heap.item?.key, 2)  // Should be new minimum after extraction
        
        // Extract remaining elements and verify they come in sorted order
        var remainingKeys = [Int]()
        while let top = heap.extractTop() {
            remainingKeys.append(top.item!.key)
        }
        XCTAssertEqual(remainingKeys, [2, 3, 4, 5, 6, 7, 20])
    }
    
    func testRelevantChildrenToSwapTwoChildrenMaxHeapSelection() {
        // Create a scenario that will exercise two-children selection in max heap
        let heap = BasicBinaryHeap<IntegerPair>(value: p(20), parent: nil, leftChild: nil, rightChild: nil, type: .max)
        heap.insert(item: p(15))  // Left child
        heap.insert(item: p(18))  // Right child (larger)
        heap.insert(item: p(10))  // Left-left
        heap.insert(item: p(12))  // Left-right
        heap.insert(item: p(16))  // Right-left  
        heap.insert(item: p(17))  // Right-right
        heap.insert(item: p(1))   // This will go to bottom and cause bubbleDown on extraction
        
        // Extract root, forcing bubbleDown to choose between children
        let extracted = heap.extractTop()
        XCTAssertEqual(extracted?.item?.key, 20)
        
        // Verify heap property is maintained - root should be the maximum remaining
        XCTAssertEqual(heap.item?.key, 18)
        
        // Extract remaining elements and verify max heap property
        var allKeys = [Int]()
        while let top = heap.extractTop() {
            allKeys.append(top.item!.key)
        }
        XCTAssertEqual(allKeys, [18, 17, 16, 15, 12, 10, 1])
    }
    
    func testRelevantChildrenToSwapHeapPropertySatisfied() {
        // Test scenarios where relevantChildrenToSwap should return nil (no swap needed)
        let heap = BasicBinaryHeap<IntegerPair>(value: p(1), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(5))
        heap.insert(item: p(8))
        heap.insert(item: p(10))
        heap.insert(item: p(12))
        
        // Extract all and verify they come out in order (heap property maintained)
        var extracted = [Int]()
        while let top = heap.extractTop() {
            extracted.append(top.item!.key)
        }
        
        // Should be in ascending order for min heap
        XCTAssertEqual(extracted, [1, 5, 8, 10, 12])
    }
    
    func testRelevantChildrenToSwapUpdatePriorityTriggersCorrectBubbleDown() {
        // Test that updatePriority properly exercises relevantChildrenToSwap when bubbling down
        let heap = BasicBinaryHeap<IntegerPair>(value: p(1, 1), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(3, 2))  // Left child
        heap.insert(item: p(5, 3))  // Right child  
        heap.insert(item: p(7, 4))  // Left-left
        heap.insert(item: p(9, 5))  // Left-right
        heap.insert(item: p(11, 6)) // Right-left
        heap.insert(item: p(13, 7)) // Right-right
        
        // Update root priority to a large value, forcing bubble down
        heap.updatePriority(ofValue: 1, to: 20)
        
        // Root should now be the minimum of the remaining elements
        XCTAssertEqual(heap.item?.key, 3)
        
        // Verify heap property is still maintained
        var keys = [Int]()
        while let top = heap.extractTop() {
            keys.append(top.item!.key)
        }
        
        // Should extract in ascending order
        for i in 1..<keys.count {
            XCTAssertLessThanOrEqual(keys[i-1], keys[i])
        }
    }
    
    func testRelevantChildrenToSwapComplexBubbleDownScenario() {
        // Test a more complex scenario that exercises multiple levels of bubbleDown
        let heap = BasicBinaryHeap<IntegerPair>(value: p(1), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(3))
        heap.insert(item: p(5))
        heap.insert(item: p(7))
        heap.insert(item: p(9))
        heap.insert(item: p(11))
        heap.insert(item: p(13))
        
        // Now insert a large value that will go to the bottom, then extract the root
        // This should cause multiple bubble down operations
        heap.insert(item: p(20))
        
        let extracted = heap.extractTop()
        XCTAssertEqual(extracted?.item?.key, 1)
        
        // The heap should still maintain min heap property
        var keys = [Int]()
        while let top = heap.extractTop() {
            keys.append(top.item!.key)
        }
        
        // Verify extracted keys are in ascending order (min heap property)
        for i in 1..<keys.count {
            XCTAssertLessThanOrEqual(keys[i-1], keys[i])
        }
    }
}

final class DataContainer : KeyValuePair {
    
    typealias K = Float
    typealias V = String
    
    
    var key: K
    var value: V
    
    required init(key: Float, value: String) {
        self.key = key
        self.value = value
    }

    func copy() -> DataContainer {
        return DataContainer(key: self.key, value: self.value)
    }
}
