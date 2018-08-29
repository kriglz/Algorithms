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
    
    var predecessor = -1
    var index: Int
    var stateColor: VertexStateColor
    
    init(index: Int) {
        self.index = index
        stateColor = VertexStateColor.white
    }
    
    func updateColor(to color: VertexStateColor) {
        self.stateColor = color
    }
}

enum Direction: Int {
    
    case up = 1
    case down = 2
    case left = 3
    case right = 4
    
    /// Returns a random direction of vertex.
    static var random: Direction {
        let randomInt = (Int(arc4random_uniform(4)) + 1);
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
        guard vertexList[index].stateColor == .white else { return }
        vertexList[index].stateColor = .gray
        
        var randomDirections = [Direction]()
        func randomDirectionVertex() -> Vertex? {
            let direction = Direction.random

            if randomDirections.contains(direction) {
                return randomDirectionVertex()
            }

            randomDirections.append(direction)

            let newVertex = nextVertex(for: index, towards: direction)

            if newVertex == nil, randomDirections.count >= 4 {
                return nil
            }

            if newVertex == nil, randomDirections.count < 4 {
                return randomDirectionVertex()
            }

            if newVertex != nil, newVertex!.stateColor != .white, randomDirections.count < 4  {
                return randomDirectionVertex()
            }

            if newVertex != nil, newVertex!.stateColor == .white {
                return newVertex
            }

            return nil
        }
        
        if let newVertex = randomDirectionVertex() {
            newVertex.predecessor = index
            updateVertex(for: newVertex.index)
        } else {
            vertexList[index].stateColor = .black
        }
    }
    
    private func nextVertex(for currentVertexIndex: Int, towards direction: Direction) -> Vertex? {
        var index = currentVertexIndex

        switch direction {
        case .left:
            if currentVertexIndex == 0 || columns % currentVertexIndex == 0 {
                return nil
            }
            index -= 1
        case .right:
            if currentVertexIndex != 0, columns % (currentVertexIndex + 1) == 0 {
                return nil
            }
            index += 1
        case .up:
            index += columns
        case .down:
            index -= columns
        }
        
        guard index < vertexList.count, index >= 0 else { return nil }
        
        return vertexList[index]
    }
}

let maze = Maze(columns: 4, rows: 1)

for i in maze.vertexList {
    print(i.index, i.predecessor)
}
//print(maze.matrix)

//2 3
//0 1 2 3
