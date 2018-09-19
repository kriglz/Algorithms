import UIKit

var str = "Hello, playground"

class Node {
    
    /// Associates an integer score with the board state, representing the result of the evaluation funtion.
    private(set) var score = 0
    
    /// Object used to compare two nodes.
    private(set) var key = 0
    
    func evaluateScore() {
        let score = 0
        self.score = score
    }
    
    /// Returns a list of available moves for a board state.
    func validMoves() -> [Int] {
        return []
    }
    
    /// Returns the identical copy of the board state.
    func copy() -> Node {
        return self
    }
    
    /// Determines weather two board states are equal.
//    func equivalent(to node: Node) -> Bool {
//        // if key == key
//        return false
//    }
 
    /// Associates the given object with the board state to be used by search algorithm.
    func storedData(object: Node) {
        
    }
}

extension Node: Equatable {
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.key == rhs.key
    }
}

/// A queue - array type object to store queues.
public struct Queue<T> {
    
    // MARK: - Private properties
    
    /// An array to store queues.
    private var array: [T]
    
    // MARK: - Public properties
    
    /// Returns true if queus list is empty.
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    /// Returns first queue in the list.
    var first: T? {
        return array.first
    }
    
    /// Returns queue list as an array of `Vertex` type object.
    var nodeList: [Node]? {
        return array as? [Node]
    }
    
    /// Returns smallest score `Node`.
    var smallest: Node {
        if let nodeArray = array as? [Node] {
            return nodeArray.min { (a, b) in
                a.score < b.score
            }
        }
        return first as? Node
    }
    
    // MARK: - Initialization
    
    /// Initializes empty queue list.
    init() {
        array = []
    }
    
    // MARK: - Queue list update
    
    /// Adds an element to the end of the queue.
    ///
    /// - Parameters:
    ///     - element: An element to be added to the queue.
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    /// Removes first queue object in the queue list.
    @discardableResult mutating func pop() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    /// Removes specified queue object in the list.
    ///
    /// - Parameters:
    ///     - node: An object of a type `Node` to be removed from the queue list.
    mutating func pop(node: Node) {
        if !isEmpty, let nodeArray = array as? [Node], let index = nodeArray.index(where: { $0 == node }) {
            array.remove(at: index)
        }
    }
}


struct ASearch {
    
    func score(node: Node) -> Int {
        return 0
    }
    
    func search(initialNode: Node, goalNode: Node) -> (initial: Node, solution: Node?) {
        var openNodeSet = Queue<Node>()
        
        let initialNodeCopy = initialNode.copy()
        initialNodeCopy.evaluateScore()
        openNodeSet.push(initialNodeCopy)
        
        var closedNodeSet = Queue<Node>()
        
        while !openNodeSet.isEmpty {
            // Removes node with smallest evaluation function and marks it as closed.
            guard let smallestScoreOpenNode = openNodeSet.smallest else {
                fatalError("No elements in the set")
                return (initialNode, nil)
            }
            
            openNodeSet.pop(node: smallestScoreOpenNode)
            closedNodeSet.push(smallestScoreOpenNode)
            
            if smallestScoreOpenNode == goalNode {
                return (initialNode, smallestScoreOpenNode)
            }
            
        }
        
    }
    
}
