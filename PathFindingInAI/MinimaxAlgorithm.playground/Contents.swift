/*
 
 Gametree type algorithm Minimax.
 
 */

import UIKit

class Player {
    
    func evaluateScore(for state: GameState) -> Int {
        return 0
    }
    
    func validMoves(for state: GameState) -> [Move] {
        return []
    }
    
}

class GameState {
    
    private(set) var board: [Int?]
    
    init(board: [Int?] = []) {
        self.board = board
    }
    
    func copy() -> GameState {
        return GameState(board: self.board)
    }
    
    func execute(move: Move) {
        board.swapAt(move.fromIndex, move.toIndex)
    }
    
    func undo(move: Move) {
        board.swapAt(move.fromIndex, move.toIndex)
    }
}

class MoveEvaluator {
    
    private(set) var score: Int
    private var move: Move?

    init(with score: Int) {
        self.score = score
    }
    
    convenience init(move: Move, with score: Int) {
        self.init(with: score)
        self.move = move
    }
}

class Move {
    
    private(set) var fromIndex: Int
    private(set) var toIndex: Int
    
    init(fromIndex: Int, toIndex: Int) {
        self.fromIndex = fromIndex
        self.toIndex = toIndex
    }
}

/// Defines MAX and MIN and consolidates how they select the best move from perspective.
enum Comparator {
    
    case maxi
    case mini
    
    var scoreRepresentitive: Int {
        switch self {
        case .mini:
            return Int.min
        case .maxi:
            return Int.max
        }
    }
    
    /// The worst score for each of these comparators is returned by this value; the actual value is different for MAX and MIN.
    var initalValue: Comparator {
        return .maxi
    }
    
    /// Swithes between MIN and MAX.
    var opposite: Comparator {
        switch self {
        case .maxi:
            return .mini
        case .mini:
            return .maxi
        }
    }
    
    /// Compares scores based on receivers state.
    func compare(i: Int, j: Int) -> Int {
        switch self {
        case .maxi:
            return i - j
        case .mini:
            return j - i
        }
    }
}

class MinimaxAlgorithm {
    
    /// The depth of game tree. How far to continue the search.
    private var plyDepth: Int
    /// All game states are evaluates from this player perspective.
    private var player = Player()
    /// Game state to be modified during the search.
    private var gameState = GameState()
    
    init(plyDepth: Int) {
        self.plyDepth = plyDepth
    }
    
    func bestMove(gameState: GameState, player: Player, opponent: Player) -> MoveEvaluator {
        self.player = player
        self.gameState = gameState.copy()
        
        let move = search(plyDepth: plyDepth, comparator: Comparator.maxi, player: player, opponent: opponent)
        return move
    }
    
    func search(plyDepth: Int, comparator: Comparator, player: Player, opponent: Player) -> MoveEvaluator {
        let moves = player.validMoves(for: gameState)
        
        // If no allowed moves or a leaf node, return games state score.
        if plyDepth == 0 || moves.isEmpty {
            return MoveEvaluator(with: player.evaluateScore(for: gameState))
        }
        
        // Try to improve on this lower bound (based on selector).
        var best = MoveEvaluator(with: comparator.initalValue.scoreRepresentitive)
        
        // Generate game state that result from all valid moves for this player.
        moves.forEach { move in
            gameState.execute(move: move)
            
            // Recursively evaluate position. Compute Minimax and swap player and opponent, synchronously eith MIN and MAX.
            let newMove = search(plyDepth: plyDepth - 1, comparator: comparator.opposite, player: opponent, opponent: player)
            
            gameState.undo(move: move)
            
            // Select maximum (minimum) of children if we are MAX (MIN).
            if comparator.compare(i: best.score, j: newMove.score) < 0 {
                best = MoveEvaluator(move: move, with: newMove.score)
            }
        }
        
        return best
    }
}
