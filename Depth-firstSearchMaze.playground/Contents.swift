import UIKit

enum VertexColor {
    /// Vertex has not been visited yet.
    case white
    
    /// Vertex has been visited, but it may have adjacent vertex that has been not.
    case gray
    
    /// Vertex has been visited and so all its adjacent vertices.
    case black
}

class Vertex {
    
    var predecessor: Int
    var id: Int
    
    var color = VertexColor.white
    
    init(id: Int, predecessor: Int) {
        self.id = id
        self.predecessor = predecessor
    }
}

class Maze {
    
    var matrix = [[Vertex?]]()
    
    init(columns: Int, rows: Int) {
        for rIndex in 0..<rows {
            for cIndex in 0..<columns {
                matrix[rIndex][cIndex] = nil
            }
        }
    }
}

let maze = Maze(columns: 5, rows: 2)
print(maze.matrix)
