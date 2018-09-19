import UIKit

class Move {
    
    var next: Move?
    
    private(set) var fromIndex: Int
    private(set) var toIndex: Int
    
    init(fromIndex: Int, toIndex: Int) {
        self.fromIndex = fromIndex
        self.toIndex = toIndex
    }
}

class DepthTransition {
    
    var move: Move
    var node: Node
    var depth: Int
    
    init(move: Move, node: Node, depth: Int) {
        self.move = move
        self.node = node
        self.depth = depth
    }
}

class Node: Equatable {
    
    /// Board state, describing game.
    private var board: [Int?]
    /// Associates an integer score with the board state, representing the result of the evaluation funtion.
    private(set) var score = 0
    /// Object used to compare two nodes.
    private(set) var key = 0
    /// Returns stored transition depth data.
    private(set) var storedData: DepthTransition?
    
    init(board: [Int?]) {
        self.board = board
        evaluateKey()
    }
    
    /// Comparison operator
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.key == rhs.key
    }
    
    /// Evaluates the score for current board state.
    func evaluateScore() {
        // TODO: - evaluate score
        let score = 0
        self.score = score
    }
    
    /// Returns a list of available moves for a board, which is 3 x 3 dimesion.
    func validMoves() -> [Move] {
        var moves = [Move]()
        
        if let emptyPositionIndex = board.index(where: { $0 == nil }) {
            // 3 x 3 board makes an index range from 0 to 8.
            let range = 0...8
            
            // From left invalid, move from right.
            if (emptyPositionIndex == 0 || emptyPositionIndex % 3 == 0) && range.contains(emptyPositionIndex + 1) {
                let fromRight = Move(fromIndex: emptyPositionIndex + 1, toIndex: emptyPositionIndex)
                moves.append(fromRight)
            } else if range.contains(emptyPositionIndex - 1) {
                let fromLeft = Move(fromIndex: emptyPositionIndex - 1, toIndex: emptyPositionIndex)
                moves.append(fromLeft)
            }
            
            // From right invalid, move from left.
            if emptyPositionIndex + 1 >= 3, (emptyPositionIndex + 1) % 3 == 0, range.contains(emptyPositionIndex - 1) {
                let fromLeft = Move(fromIndex: emptyPositionIndex - 1, toIndex: emptyPositionIndex)
                moves.append(fromLeft)
            } else if range.contains(emptyPositionIndex + 1) {
                let fromRight = Move(fromIndex: emptyPositionIndex + 1, toIndex: emptyPositionIndex)
                moves.append(fromRight)
            }
            
            // Move down.
            let upIndex = emptyPositionIndex + 3
            if range.contains(upIndex) {
                let fromUp = Move(fromIndex: upIndex, toIndex: emptyPositionIndex)
                moves.append(fromUp)
            }
            
            // Move up.
            let downIndex = emptyPositionIndex - 3
            if range.contains(downIndex) {
                let fromDown = Move(fromIndex: downIndex, toIndex: emptyPositionIndex)
                moves.append(fromDown)
            }
        }
        
        return moves
    }
    
    /// Returns the identical copy of the board.
    func clone() -> Node {
        let copyNode = Node(board: self.board)
        if let depthTransition = self.storedData {
            copyNode.storeData(data: depthTransition)
        }
        return copyNode
    }
 
    /// Associates the given object with the board state to be used by search algorithm.
    func storeData(data: DepthTransition) {
        self.storedData = data
    }
    
    /// Performs the move in the board.
    func execute(move: Move) {
        board.swapAt(move.fromIndex, move.toIndex)
        evaluateKey()
    }
    
    /// Calculates the board key based on board state.
    private func evaluateKey() {
        var keyValue = 0
        
        for (index, boardValue) in board.enumerated() {
            if let value = boardValue {
                keyValue += index * value
            }
        }
        
        self.key = keyValue
    }
}

/// A queue - array type object to store queues.
public struct Queue<T> {
    
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
    var smallest: Node? {
        if let nodeArray = array as? [Node] {
            return nodeArray.min { (a, b) in
                a.score < b.score
            }
        }
        return first as? Node
    }
    
    /// Initializes empty queue list.
    init() {
        array = []
    }
    
    /// Adds an element to the end of the queue.
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    /// Removes specified queue object in the list.
    mutating func pop(node: Node) {
        if !isEmpty, let nodeArray = array as? [Node], let index = nodeArray.index(where: { $0 == node }) {
            array.remove(at: index)
        }
    }
    
    /// Checks and returns the node if its in the queue.
    func contains(node: Node) -> Node? {
        if let nodeArray = array as? [Node], let equivalentNode = nodeArray.first(where: { $0.key == node.key }) {
            return equivalentNode
        }
        
        return nil
    }
}

struct ASearch {

    func search(initialNode: Node, goalNode: Node) -> (initial: Node, solution: Node?) {
        var openNodeSet = Queue<Node>()
        var closedNodeSet = Queue<Node>()

        let initialNodeCopy = initialNode.clone()
        initialNodeCopy.evaluateScore()
        
        openNodeSet.push(initialNodeCopy)
        
        while !openNodeSet.isEmpty {
            // Removes node with smallest evaluation function and marks it as closed.
            guard let smallestScoreOpenNode = openNodeSet.smallest else {
                fatalError("No elements in the set")
            }
            
            // Remove node with smallest score and mark it as closed.
            openNodeSet.pop(node: smallestScoreOpenNode)
            closedNodeSet.push(smallestScoreOpenNode)
            
            // Return if the goal state reached.
            if smallestScoreOpenNode == goalNode {
                return (initialNode, smallestScoreOpenNode)
            }
            
            // Compute successor moves and update open/closed lists.
            var depth = 1
            if let transition = smallestScoreOpenNode.storedData {
                depth = transition.depth + 1
            }
            
            let moves = smallestScoreOpenNode.validMoves()
            moves.forEach { move in
                guard let nextMove = move.next else {
                    NSLog("No next move")
                    return
                }
                    
                // Make the move and score the board state.
                let successorNode = smallestScoreOpenNode.clone()
                successorNode.execute(move: nextMove)
                
                // Record previous move for solution trace.
                // Compute evaluation function to see if we have improved upon a state already closed.
                let transitionDepth = DepthTransition(move: nextMove, node: smallestScoreOpenNode, depth: depth)
                successorNode.storeData(data: transitionDepth)
                successorNode.evaluateScore()
                
                // If already visited, see if we are revisiting with lower cost.
                // If not, just continue. Otherwise, pull out of closed and process.
                if let pastNode = closedNodeSet.contains(node: successorNode) {
                    if successorNode.score >= pastNode.score {
                        return
                    }
                    
                    // Revisit with lower score
                    closedNodeSet.pop(node: pastNode)
                }
                
                openNodeSet.push(successorNode)
            }
        }
        
        return (initialNode, nil)
    }
}
