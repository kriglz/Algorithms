/*
 
 Gametree type algorithm AlphaBeta.
 
 */

import UIKit

enum PlayerMark: Int {
    
    case x
    case o
    
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
                score += 100
            }
            
            if column.isOfType(playersMark.opposite) {
                return -100
            }
            
            if column.canBeOfType(playersMark), !column.isNil {
                score += 1
            } else if column.canBeOfType(playersMark.opposite), !column.isNil {
                score -= 1
            }
        }
        
        // Check rows.
        for row in gameState.board.rows {
            if row.isOfType(playersMark) {
                score += 100
            }
            
            if row.isOfType(playersMark.opposite) {
                return -100
            }
            
            if row.canBeOfType(playersMark), !row.isNil {
                score += 1
            } else if row.canBeOfType(playersMark.opposite), !row.isNil {
                score -= 1
            }
        }
        
        // Check diagonals.
        for diagonal in gameState.board.diagonals {
            if diagonal.isOfType(playersMark) {
                score += 100
            }
            
            if diagonal.isOfType(playersMark.opposite) {
                return -100
            }
            
            if diagonal.canBeOfType(playersMark), !diagonal.isNil {
                score += 1
            } else if diagonal.canBeOfType(playersMark.opposite), !diagonal.isNil {
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
    
    static var minimum = -100
    static var maximum = 100
    
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

class AlphaBetaAlgorithm {
    
    /// The depth of game tree. How far to continue the search.
    private var plyDepth: Int
    /// Game state to be modified during the search.
    private(set) var gameState = GameState()
    
    init(plyDepth: Int) {
        self.plyDepth = plyDepth
    }
    
    func bestMove(gameState: GameState, player: Player, opponent: Player) -> MoveEvaluator {
        self.gameState = gameState.copy()

        let move = search(plyDepth: plyDepth, player: player, opponent: opponent, alpha: alpha, beta: beta)
        return move
    }
    
    var alpha = MoveEvaluator.minimum
    var beta = MoveEvaluator.maximum
    
    /// - Parameters:
    ///     - alpha: Represents the lower bound of the game states found for the player so far; or -100 if none found. Higher values of alpha mean that the player is doing well. When alpha == 100, the player has found the winning move and the seach can be terminated.
    ///     - beta: Represent the upper bound of the game states; or 100 if none have been found. It declears the maximum board the player can achive. When beta drops lower and lower, that means that the opponent is doing better at restricting the player's options
    func search(plyDepth: Int, player: Player, opponent: Player, alpha: Int, beta: Int) -> MoveEvaluator {
        let moves = player.validMoves(for: gameState)
        
        // If no allowed moves or a leaf node, return games state score.
        if plyDepth == 0 || moves.isEmpty {
            return MoveEvaluator(with: player.evaluateScore(for: gameState))
        }
        
        // Select "maximum of negative value of children" that improves alpha.
        var best = MoveEvaluator(with: alpha)
        
        // Generate game state that result from all valid moves for this player.
        // Select maximum of the negative scores of children.
        for move in moves {
            print("move was executed", move.toIndex, move.playerMark)
            player.execute(move: move, in: gameState)
            
            // Recursively evaluate position.
            let newMove = search(plyDepth: plyDepth - 1, player: opponent, opponent: player, alpha: -beta, beta: -alpha)
            
            print("\n", alpha, beta, plyDepth)
            print(best.score)
            print("new", newMove.score)
            print(gameState.board.rows[0].stringRepresentation)
            print(gameState.board.rows[1].stringRepresentation)
            print(gameState.board.rows[2].stringRepresentation)

            player.undo(move: move, in: gameState)
            
            if -newMove.score > best.score {
                best = MoveEvaluator(move: move, with: -newMove.score)
                print("new score \(best.score)\n")
            }
            
            // Search no longer productive.
            if best.score >= beta {
                print("PRUNES")
                
                return best
            }
        }
        
        return best
    }
}

let algorithm = AlphaBetaAlgorithm(plyDepth: 3)
//let initialBoard: [PlayerMark?] = [
//    .o,    nil,  nil,
//    nil,   .x,   nil,
//    .x,    nil,  nil
//]

let initialBoard: [PlayerMark?] = [
    nil,   nil,  .o,
    nil,   .x,   .x,
    nil,    nil,  nil
]

//let initialBoard: [PlayerMark?] = [
//    nil,   nil,  .o,
//    nil,   .x,   nil,
//    nil,   nil,  .x
//]

let gameState = GameState(board: initialBoard)
let player = Player(with: .o)
let opponent = Player(with: .x)
let bestMove = algorithm.bestMove(gameState: gameState, player: player, opponent: opponent)

print("\n\n", bestMove.score, bestMove.move?.toIndex)

