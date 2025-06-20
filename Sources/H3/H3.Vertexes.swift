import CH3

public func cellToVertex(cell: UInt64, vertexNum: Int) -> UInt64 {
    var vertex: UInt64 = 0
    let err = CH3.cellToVertex(cell, Int32(vertexNum), &vertex)
    precondition(err == 0, "cellToVertex failed with error \(err)")
    
    return vertex
}

public func cellToVertices(cell: UInt64) -> [UInt64] {
    var output = [UInt64](repeating: 0, count: 6)
    let err = output.withUnsafeMutableBufferPointer {
        CH3.cellToVertexes(cell, $0.baseAddress)
    }
    precondition(err == 0, "cellToVertexes failed with error \(err)")
    
    return output.filter { $0 != 0 }
}

public func vertexToLatLng(vertex: UInt64) -> LatLng {
    var coord = LatLng(lat: 0, lng: 0)
    let err = CH3.vertexToLatLng(vertex, &coord)
    precondition(err == 0, "vertexToLatLng failed with error \(err)")
    
    return coord
}

public func isValidVertex(vertex: UInt64) -> Bool {
    return CH3.isValidVertex(vertex) != 0
}
