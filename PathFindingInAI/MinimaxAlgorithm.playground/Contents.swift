/*
 
 Gametree type algorithm Minimax.
 
 */

import UIKit

enum PlayerMark: Int {
    
    case x = 1
    case o = -1
    
    var opposite: PlayerMark {
        switch self {
        case .o:
            return .x
        case .x:
            return .o
        }
    }
}

extension Array where Element == PlayerMark? {
    
    var isNil: Bool {
        if self.first(where: { $0 != nil }) == nil {
            return true
        }
        
        return false
    }
    
    func isOfType(_ type: PlayerMark) -> Bool {
        if self.first(where: { $0 == type.opposite }) == nil {
            return true
        }
        
        return false
    }
    
    /// Returns matrix 3 by 3, made from receiver's array, which must consist of 9 elements.
    ///
    /// Original array
    ///
    /// 1 2 3 4 5 6 7 8
    ///
    /// ->
    ///
    /// Matrix
    ///
    /// 1 2 3
    ///
    /// 4 5 6
    ///
    /// 7 8 9
    var rows: [[PlayerMark?]] {
        guard self.count == 9 else { return []}
        
        var newArray = Array<[PlayerMark?]>(repeating: Array<PlayerMark?>(repeating: nil, count: 3), count: 3)
        for (index, element) in self.enumerated() {
            let row = index / 3
            let column = index - row * 3
            newArray[row][column] = element
        }
        
        return newArray
    }
    
    /// Returns matrix 3 by 3, made from receiver's array, which must consist of 9 elements.
    ///
    /// Original array
    ///
    /// 1 2 3 4 5 6 7 8
    ///
    /// ->
    ///
    /// Matrix
    ///
    /// 1 4 7
    ///
    /// 2 5 8
    ///
    /// 3 6 9
    var columns: [[PlayerMark?]] {
        guard self.count == 9 else { return []}

        var newArray = Array<[PlayerMark?]>(repeating: Array<PlayerMark?>(repeating: nil, count: 3), count: 3)
        for (index, element) in self.enumerated() {
            let row = index / 3
            let column = index - row * 3
            newArray[column][row] = element
        }
        
        return newArray
    }
    
    /// Returns 2 diagonal array of matrix constructed from receiver's array.
    var diagonals: [[PlayerMark?]] {
        guard self.count == 9 else { return []}

        var newArray = [[PlayerMark?]]()

        var diagonal = [PlayerMark?]()
        for index in 0...2 {
            diagonal.append(self[index * 4])
        }
        newArray.append(diagonal)
        
        diagonal = []
        for index in 0...2 {
            diagonal.append(self[index * 2 + 2])
        }
        newArray.append(diagonal)
        
        return newArray
    }
}

class Player {
    
    private(set) var playersMark: PlayerMark
    
    init(with mark: PlayerMark) {
        self.playersMark = mark
    }
    
    /// Returns the score of the board, which is a difference between players and opponents possible wins - sum of rows, columns, diagonals.
    func evaluateScore(for gameState: GameState) -> Int {
        var score = 0
        
        // Check columns.
        for column in gameState.board.columns {
            if column.isNil || column.isOfType(playersMark) {
                score += 1
            } else if column.isOfType(playersMark.opposite) {
                score -= 1
            }
        }
        
        // Check rows.
        for row in gameState.board.rows {
            if row.isNil || row.isOfType(playersMark) {
                score += 1
            } else if row.isOfType(playersMark.opposite) {
                score -= 1
            }
        }
        
        // Check diagonals.
        for diagonal in gameState.board.diagonals {
            if diagonal.isNil || diagonal.isOfType(playersMark) {
                score += 1
            } else if diagonal.isOfType(playersMark.opposite) {
                score -= 1
            }
        }
        
        return score
    }
    
    func validMoves(for gameState: GameState) -> [Move] {
        var validMoves = [Move]()
        
        for (index, state) in gameState.board.enumerated() {
            if state == nil {
                let move = Move(playerMark: playersMark, toIndex: index)
                validMoves.append(move)
            }
        }
        
        return validMoves
    }
    
    func execute(move: Move, in gameState: GameState) {
        gameState.update(stateAt: move.toIndex, to: playersMark)
    }
    
    func undo(move: Move, in gameState: GameState) {
        gameState.update(stateAt: move.toIndex, to: nil)
    }
}

class GameState {
    
    /// Board state, describing game.
    private(set) var board: [PlayerMark?]!
    
    init(board: [PlayerMark?] = []) {
        self.board = board
    }
    
    func copy() -> GameState {
        return GameState(board: self.board)
    }
    
    func update(stateAt index: Int, to mark: PlayerMark?) {
        board[index] = mark
    }
}

class MoveEvaluator {
    
    private(set) var score: Int
    private(set) var move: Move?

    init(with score: Int) {
        self.score = score
    }
    
    convenience init(move: Move, with score: Int) {
        self.init(with: score)
        self.move = move
    }
}

class Move {
    
    private(set) var toIndex: Int
    private(set) var playerMark: PlayerMark
    
    var debuggingDescription: String {
        return "To: \(toIndex), player mark: \(playerMark)"
    }
    
    init(playerMark: PlayerMark, toIndex: Int) {
        self.toIndex = toIndex
        self.playerMark = playerMark
    }
}

/// Defines MAX and MIN and consolidates how they select the best move from perspective.
enum Comparator {
    
    case maxi
    case mini
    
    var scoreRepresentitive: Int {
        switch self {
        case .mini:
            return -100 //Int.min
        case .maxi:
            return 100 // Int.max
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
    private var player: Player!
    /// Game state to be modified during the search.
    private(set) var gameState = GameState()
    
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
        
        for move in moves {
            print("valid moves", move.debuggingDescription)
        }
        
        print("plyDepth:", plyDepth, ", mark:", player.playersMark, "\n")
        
        // If no allowed moves or a leaf node, return games state score.
        if plyDepth == 0 || moves.isEmpty {
            print("NO moves available")
            return MoveEvaluator(with: player.evaluateScore(for: gameState))
        }
        
        // Try to improve on this lower bound (based on selector).
        var best = MoveEvaluator(with: comparator.initalValue.scoreRepresentitive)
        
        // Generate game state that result from all valid moves for this player.
        moves.forEach { move in
            player.execute(move: move, in: gameState)
            
            print("after first move\n", "\(gameState.board.rows[0])\n\(gameState.board.rows[1])\n\(gameState.board.rows[2])\n")
            
            // Recursively evaluate position. Compute Minimax and swap player and opponent, synchronously eith MIN and MAX.
            let newMove = search(plyDepth: plyDepth - 1, comparator: comparator.opposite, player: opponent, opponent: player)
            
            player.undo(move: move, in: gameState)
            
            print("\nundo move\n", "\(gameState.board.rows[0])\n\(gameState.board.rows[1])\n\(gameState.board.rows[2])")
            
            print(comparator, best.score, newMove.score)
            
            // Select maximum (minimum) of children if we are MAX (MIN).
            if comparator.compare(i: best.score, j: newMove.score) < 0 {
                best = MoveEvaluator(move: move, with: newMove.score)
                print("updates best move", best)
            }
        }
        
        return best
    }
}

let algorithm = MinimaxAlgorithm(plyDepth: 3)
let emptyBoard: [PlayerMark?] = [
    nil,   nil,   nil,
    .x,    nil,   nil,
    .o,    nil,    nil
]
let gameState = GameState(board: emptyBoard)
let player = Player(with: .x)
let opponent = Player(with: .o)
let bestMove = algorithm.bestMove(gameState: gameState, player: player, opponent: opponent)

print("\n\n", bestMove.score, bestMove.move)
print("\n\(algorithm.gameState.board.rows[0])\n\(algorithm.gameState.board.rows[1])\n\(algorithm.gameState.board.rows[2])")
