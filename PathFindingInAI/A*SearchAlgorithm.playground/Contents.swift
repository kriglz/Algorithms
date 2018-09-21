/*
 
 Heuristic search tree type algorithm A*.
 Good evaluator used for scoring.
 
 */

import UIKit

class Move {
    
    private(set) var fromIndex: Int
    private(set) var toIndex: Int
    
    init(fromIndex: Int, toIndex: Int) {
        self.fromIndex = fromIndex
        self.toIndex = toIndex
    }
    
    func isReverse(to move: Move) -> Bool {
        return self.fromIndex == move.toIndex && self.toIndex == move.fromIndex
    }
    
    func isEqual(to move: Move) -> Bool {
        return self.fromIndex == move.fromIndex && self.toIndex == move.toIndex
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
    
    /// Board state, describing game. Using regulat matrix - array conversion.
    private(set) var board: [Int?]
    /// Associates an integer score with the board state, representing the result of the evaluation funtion.
    private(set) var score = 0
    /// Returns stored transition depth data.
    private(set) var storedData: DepthTransition?
    
    init(board: [Int?]) {
        self.board = board
    }
    
    /// Comparison operator
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.board == rhs.board
    }
    
    /// Evaluates the score for current board state.
    func evaluateScore() {
        
        /*
         
         GoodEvaluator
         
         h*(n) = P(n) + 3 * S(n), where P(n) is the sum of Manhattan distances that each tile is from "home", ignoring empty one. S(n) is a sequence score that checks the noncentral squares in turn, alllotting 2 for every tile not followed by its proper successor and 0 for every other tile, except that a piece in the center scores 1.
         
         Example:
         
         1 4 8
         7 3
         6 5 2
         
         h*(n) = 13 + 3 * 11 = 46
         
         */
        
        var sequenceScore = 0
        var manhattanDistanceScore = 0
        
        for (index, boardValue) in board.enumerated() {
            // Manhattan distance is not calculated for empty tile.
            if let value = boardValue {
                let homeIndex = covertToRegularIndex(from: value - 1) // Array indexes start from 0, while board values start from 1.
                manhattanDistanceScore += manhattanDistance(fromIndex: index, toIndex: homeIndex)
            }
            
            // Regular index = 4, swirled index is 8, that means the center value of the board, which is scored 1 in case it's not nil.
            if index == 4, boardValue != nil {
                sequenceScore += 1
            }
            
            if index != 4, index != 3, let value = boardValue {
                let swirledNextValueIndex = convertToSwirledIndex(from: index) + 1
                let regularNextValueIndex = covertToRegularIndex(from: swirledNextValueIndex)
                
                sequenceScore += sequence(value: value, nextValue: board[regularNextValueIndex] ?? 9)
            }
        }
        
        self.score = manhattanDistanceScore + 3 * sequenceScore
    }
    
    private func sequence(value: Int, nextValue: Int) -> Int {
        if value == nextValue - 1 {
            return 0
        }
        return 2
    }
    
    private func manhattanDistance(fromIndex: Int, toIndex: Int) -> Int {
        let fromIndexRow = fromIndex / 3
        let fromIndexColum = fromIndex - fromIndexRow * 3
        
        let toIndexRow = toIndex / 3
        let toIndexColumn = toIndex - toIndexRow * 3
        
        return abs(fromIndexRow - toIndexRow) + abs(fromIndexColum - toIndexColumn)
    }
    
    /// Returns a list of available moves for a board, which is 3 x 3 dimesion.
    func validMoves() -> [Move] {
        var moves = [Move]()
        
        func appendMove(from: Int, to: Int) {
            let move = Move(fromIndex: from, toIndex: to)
            
            if let previousMove = storedData?.move, move.isReverse(to: previousMove) {
                return
            }
            
            if moves.contains(where: { $0.isEqual(to: move) }) {
                return
            }
            
            moves.append(move)
        }
        
        if let emptyPositionIndex = board.index(where: { $0 == nil }) {
            // 3 x 3 board makes an index range from 0 to 8.
            let range = 0...8
            
            /*
             
             Using regulat matrix - array conversion.
             
             1 4 8
             7 3
             6 5 2
             
             1 4 8 7 3 nil 6 5 2
             
             */
            
            // From left invalid, move from right.
            if (emptyPositionIndex == 0 || emptyPositionIndex % 3 == 0) && range.contains(emptyPositionIndex + 1) {
                appendMove(from: emptyPositionIndex + 1, to: emptyPositionIndex)
            } else if range.contains(emptyPositionIndex - 1) {
                appendMove(from: emptyPositionIndex - 1, to: emptyPositionIndex)
            }
            
            // From right invalid, move from left.
            if emptyPositionIndex + 1 >= 3, (emptyPositionIndex + 1) % 3 == 0, range.contains(emptyPositionIndex - 1) {
                appendMove(from: emptyPositionIndex - 1, to: emptyPositionIndex)
            } else if range.contains(emptyPositionIndex + 1) {
                appendMove(from: emptyPositionIndex + 1, to: emptyPositionIndex)
            }
            
            // Move down.
            let upIndex = emptyPositionIndex + 3
            if range.contains(upIndex) {
                appendMove(from: upIndex, to: emptyPositionIndex)
            }
            
            // Move up.
            let downIndex = emptyPositionIndex - 3
            if range.contains(downIndex) {
                appendMove(from: downIndex, to: emptyPositionIndex)
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
    }
    
    /*
     
     Index conversion
     
     Regular array:
     
     1 2 3
     4 5 6
     7 8 9
     
     Swirled array:
     
     1 2 3
     8   4
     7 6 5
     
     */
    
    /// Does an index conversion from "swirled" array to regular one.
    ///
    /// Returns a home index in matrix based array. Start index = 0.
    private func covertToRegularIndex(from swirledIndex: Int) -> Int {
        switch swirledIndex {
        case 3:
            return 5
        case 4:
            return 8
        case 5:
            return 7
        case 7:
            return 3
        case 8:
            return 4
        default:
            return swirledIndex
        }
    }
    
    /// Does an index conversion from regular array to "swirled" one.
    private func convertToSwirledIndex(from regularIndex: Int) -> Int {
        switch regularIndex {
        case 3:
            return 7
        case 4:
            return 8
        case 5:
            return 3
        case 7:
            return 5
        case 8:
            return 4
        default:
            return regularIndex
        }
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
        if let nodeArray = array as? [Node], let equivalentNode = nodeArray.first(where: { $0.board == node.board }) {
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
                // Make the move and score the board state.
                let successorNode = smallestScoreOpenNode.clone()
                successorNode.execute(move: move)
                successorNode.evaluateScore()
                
                // Record previous move for solution trace.
                // Compute evaluation function to see if we have improved upon a state already closed.
                let transitionDepth = DepthTransition(move: move, node: smallestScoreOpenNode, depth: depth)
                successorNode.storeData(data: transitionDepth)
                
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

/*
 
 Initial
 
 8 1 3
 4 5
 2 7 6
 
 Goal
 
 1 2 3
 8   4
 7 6 5
 
 */

let initialNode = Node(board: [8, 1, 3, nil, 4, 5, 2, 7, 6])
let goalNode = Node(board: [1, 2, 3, 8, nil, 4, 7, 6, 5])

let aSearchAlgorithm = ASearch()
let result = aSearchAlgorithm.search(initialNode: initialNode, goalNode: goalNode)

print(result.solution?.board)

