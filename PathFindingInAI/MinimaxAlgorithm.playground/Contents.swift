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
    
    var stringRepresentation: String {
        switch self {
        case .o:
            return "o "
        case .x:
            return "x "
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
    
    func canBeOfType(_ type: PlayerMark) -> Bool {
        if self.first(where: { $0 == type.opposite }) == nil {
            return true
        }
        
        return false
    }
    
    func isOfType(_ type: PlayerMark) -> Bool {
        if self.first(where: { $0 == type.opposite || $0 == nil }) == nil {
            return true
        }
        
        return false
    }
    
    var stringRepresentation: String {
        var text = ""
        for element in self {
            if element == nil {
                text.append("- ")
            } else {
                text.append(element!.stringRepresentation)
            }
        }
        return text
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
            if column.isOfType(playersMark) {
                return 100
            }
            
            if column.isOfType(playersMark.opposite) {
                return -100
            }
            
            if column.isNil || column.canBeOfType(playersMark) {
                score += 1
            } else if column.canBeOfType(playersMark.opposite) {
                score -= 1
            }
        }
        
        // Check rows.
        for row in gameState.board.rows {
            if row.isOfType(playersMark) {
                return 100
            }
            
            if row.isOfType(playersMark.opposite) {
                return -100
            }
            
            if row.isNil || row.canBeOfType(playersMark) {
                score += 1
            } else if row.canBeOfType(playersMark.opposite) {
                score -= 1
            }
        }
        
        // Check diagonals.
        for diagonal in gameState.board.diagonals {
            if diagonal.isOfType(playersMark) {
                return 100
            }
            
            if diagonal.isOfType(playersMark.opposite) {
                return -100
            }
            
            if diagonal.isNil || diagonal.canBeOfType(playersMark) {
                score += 1
            } else if diagonal.canBeOfType(playersMark.opposite) {
                score -= 1
            }
        }
        
//        print("board score \(score)\n","\(gameState.board.rows[0].stringRepresentation)\n\(gameState.board.rows[1].stringRepresentation)\n\(gameState.board.rows[2].stringRepresentation)\n ")
        
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
        return .mini
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
        
        print("plyDepth:", plyDepth, ", mark:", player.playersMark, "valid moves count:", moves.count)
        
        // If no allowed moves or a leaf node, return games state score.
        if plyDepth == 0 || moves.isEmpty {
            print("\nreturns score\n")
            return MoveEvaluator(with: player.evaluateScore(for: gameState))
        }
        
        // Try to improve on this lower bound (based on selector).
        var best: MoveEvaluator?
        
        // Generate game state that result from all valid moves for this player.
        moves.forEach { move in
            player.execute(move: move, in: gameState)
            
            print("\(gameState.board.rows[0].stringRepresentation)\n\(gameState.board.rows[1].stringRepresentation)\n\(gameState.board.rows[2].stringRepresentation)\n")
            
            // Recursively evaluate position. Compute Minimax and swap player and opponent, synchronously eith MIN and MAX.
            let newMove = search(plyDepth: plyDepth - 1, comparator: comparator.opposite, player: opponent, opponent: player)
            
            if best == nil {
                best = MoveEvaluator(move: move, with: newMove.score)
                print(best?.score, best?.move?.toIndex, best?.move?.playerMark, player.playersMark)
            }
            
            player.undo(move: move, in: gameState)
            
            // Select maximum (minimum) of children if we are MAX (MIN).
            if comparator.compare(i: best!.score, j: newMove.score) < 0 {
                best = MoveEvaluator(move: move, with: newMove.score)
            }
        }
        
        return best ?? MoveEvaluator(with: 999999)
    }
}

let algorithm = MinimaxAlgorithm(plyDepth: 2)
let emptyBoard: [PlayerMark?] = [
    nil,   nil,   .o,
    nil,    .x,   nil,
    nil,    nil,   .x
]
let gameState = GameState(board: emptyBoard)
let player = Player(with: .o)
let opponent = Player(with: .x)
let bestMove = algorithm.bestMove(gameState: gameState, player: player, opponent: opponent)

print("\n\n", bestMove.score, bestMove.move?.toIndex)
