import UIKit

enum VertexStateColor {
    
    /// Vertex has not been visited yet.
    case white
    
    /// Vertex has been visited, but it may have adjacent vertex that has been not.
    case gray
    
    /// Vertex has been visited and so all its adjacent vertices.
    case black
}

class Vertex {
    
    var predecessor: Int = -1
    var index: Int
    var color = VertexStateColor.white
    
    init(index: Int) {
        self.index = index
    }
}

enum Direction: Int {
    
    case up = 1
    case down = 2
    case left = 3
    case right = 4
    
    /// Returns a random direction of vertex.
    static var random: Direction {
        let randomInt = (Int(arc4random_uniform(3)) + 1);
        return Direction.init(rawValue: randomInt) ?? .up
    }
}

class Maze {
    
    var vertexList = [Vertex]()
    
    var columns: Int
    var rows: Int
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        setupRawVertexList(columns: columns, rows: rows)
        fillUpVertexList()
    }
    
    /// Initialized empty matrix of size: columns x rows.
    private func setupRawVertexList(columns: Int, rows: Int) {
        let maxIndex = columns * rows
        
        for index in 0..<maxIndex {
            let vertex = Vertex(index: index)
            vertexList.append(vertex)
        }
    }
    
    private func fillUpVertexList() {
        for index in 0..<vertexList.count {
            updateVertex(for: index)
        }
    }
    
    private func updateVertex(for index: Int) {
        guard vertexList[index].color != .black else { return }
        
        if vertexList[index].color == .white {
            vertexList[index].color == .gray
        }

        var randomDirections = [Direction]()

        func randomDirectionVertex() -> Vertex? {
            let direction = Direction.random
            
            if randomDirections.contains(direction) {
                return randomDirectionVertex()
            }
            
            randomDirections.append(direction)
            
            let newVertex = nextVertex(for: index, towards: direction)
            if newVertex == nil, randomDirections.count < 4 {
                return randomDirectionVertex()
            } else if newVertex != nil, newVertex!.color != .white {
                return randomDirectionVertex()
            } else if newVertex == nil, randomDirections.count >= 4 {
                return nil
            }
            
            return newVertex
        }
        
        if let newVertex = randomDirectionVertex() {
            newVertex.predecessor = index
            updateVertex(for: newVertex.index)
        } else {
            vertexList[index].color == .black
        }
    }    
    
    private func nextVertex(for currentVertexIndex: Int, towards direction: Direction) -> Vertex? {
        let index = currentVertexIndex + constant(for: direction)
        guard index < vertexList.count, index >= 0 else { return nil }
        return vertexList[index]
    }
    
    private func constant(for direction: Direction) -> Int {
        switch direction {
        case .left:
            return -1
        case .right:
            return 1
        case .up:
            return rows
        case .down:
            return -rows
        }
    }
}

let maze = Maze(columns: 2, rows: 2)

for i in maze.vertexList {
    print(i.color)
}
//print(maze.matrix)
