import CH3

public func areNeighborCells(a: UInt64, b: UInt64) -> Bool {
    var isNeighbor: Int32 = 0
    let err = CH3.areNeighborCells(a, b, &isNeighbor)
    precondition(err == 0, "areNeighborCells failed with error \(err)")
    
    return isNeighbor != 0
}

public func cellsToDirectedEdge(origin: UInt64, destination: UInt64) -> UInt64 {
    var edge: UInt64 = 0
    let err = CH3.cellsToDirectedEdge(origin, destination, &edge)
    precondition(err == 0, "cellsToDirectedEdge failed with error \(err)")

    return edge
}

public func isValidDirectedEdge(edge: UInt64) -> Bool {
    return CH3.isValidDirectedEdge(edge) != 0
}

public func getDirectedEdgeOrigin(edge: UInt64) -> UInt64 {
    var origin: UInt64 = 0
    let err = CH3.getDirectedEdgeOrigin(edge, &origin)
    precondition(err == 0, "getDirectedEdgeOrigin failed with error \(err)")

    return origin
}

public func getDirectedEdgeDestination(edge: UInt64) -> UInt64 {
    var destination: UInt64 = 0
    let err = CH3.getDirectedEdgeDestination(edge, &destination)
    precondition(err == 0, "getDirectedEdgeDestination failed with error \(err)")
    
    return destination
}

public func directedEdgeToCells(edge: UInt64) -> (origin: UInt64, destination: UInt64) {
    var buffer = [UInt64](repeating: 0, count: 2)
    let err = buffer.withUnsafeMutableBufferPointer {
        CH3.directedEdgeToCells(edge, $0.baseAddress)
    }
    precondition(err == 0, "directedEdgeToCells failed with error \(err)")
    
    return (origin: buffer[0], destination: buffer[1])
}

public func originToDirectedEdges(origin: UInt64) -> [UInt64] {
    var edges = [UInt64](repeating: 0, count: 6)
    let err = edges.withUnsafeMutableBufferPointer {
        CH3.originToDirectedEdges(origin, $0.baseAddress)
    }
    precondition(err == 0, "originToDirectedEdges failed with error \(err)")

    return edges.filter { $0 != 0 }
}

public func directedEdgeBoundary(edge: UInt64) -> [LatLng] {
    var boundary = CellBoundary()
    let err = CH3.directedEdgeToBoundary(edge, &boundary)
    precondition(err == 0, "directedEdgeToBoundary failed with error \(err)")

    let coords = withUnsafeBytes(of: &boundary.verts) { raw -> [LatLng] in
        let buffer = raw.bindMemory(to: LatLng.self)
        return Array(buffer.prefix(Int(boundary.numVerts)))
    }

    return coords
}




