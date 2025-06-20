import CH3

public func degsToRads(degrees: Double) -> Double {
    return CH3.degsToRads(degrees)
}

public func radsToDegs(radians: Double) -> Double {
    return CH3.radsToDegs(radians)
}

public func getHexagonAreaAvgKm2(res: Int32) -> Double {
    var area: Double = 0
    let err = CH3.getHexagonAreaAvgKm2(res, &area)
    precondition(err == 0, "getHexagonAreaAvgKm2 failed with error \(err)")
    
    return area
}

public func getHexagonAreaAvgM2(res: Int32) -> Double {
    var area: Double = 0
    let err = CH3.getHexagonAreaAvgM2(res, &area)
    precondition(err == 0, "getHexagonAreaAvgM2 failed with error \(err)")

    return area
}

public func cellAreaRads2(cell: UInt64) -> Double {
    var area: Double = 0
    let err = CH3.cellAreaRads2(cell, &area)
    precondition(err == 0, "cellAreaRads2 failed with error \(err)")

    return area
}

public func cellAreaKm2(cell: UInt64) -> Double {
    var area: Double = 0
    let err = CH3.cellAreaKm2(cell, &area)
    precondition(err == 0, "cellAreaKm2 failed with error \(err)")

    return area
}

public func cellAreaM2(cell: UInt64) -> Double {
    var area: Double = 0
    let err = CH3.cellAreaM2(cell, &area)
    precondition(err == 0, "cellAreaM2 failed with error \(err)")

    return area
}

public func getHexagonEdgeLengthAvgKm(res: Int32) -> Double {
    var length: Double = 0
    let err = CH3.getHexagonEdgeLengthAvgKm(res, &length)
    precondition(err == 0, "getHexagonEdgeLengthAvgKm failed with error \(err)")
    
    return length
}

public func getHexagonEdgeLengthAvgM(res: Int32) -> Double {
    var length: Double = 0
    let err = CH3.getHexagonEdgeLengthAvgM(res, &length)
    precondition(err == 0, "getHexagonEdgeLengthAvgM failed with error \(err)")

    return length
}

public func edgeLengthKm(edge: UInt64) -> Double {
    var length: Double = 0
    let err = CH3.edgeLengthKm(edge, &length)
    precondition(err == 0, "edgeLengthKm failed with error \(err)")
    
    return length
}

public func edgeLengthM(edge: UInt64) -> Double {
    var length: Double = 0
    let err = CH3.edgeLengthM(edge, &length)
    precondition(err == 0, "edgeLengthM failed with error \(err)")
    
    return length
}

public func edgeLengthRads(edge: UInt64) -> Double {
    var length: Double = 0
    let err = CH3.edgeLengthRads(edge, &length)
    precondition(err == 0, "edgeLengthRads failed with error \(err)")

    return length
}

public func getNumCells(res: Int32) -> Int64 {
    var count: Int64 = 0
    let err = CH3.getNumCells(res, &count)
    precondition(err == 0, "getNumCells failed with error \(err)")

    return count
}

public func getRes0Cells() -> [UInt64] {
    let count = getRes0CellCount()
    var output = [UInt64](repeating: 0, count: count)
    let err = output.withUnsafeMutableBufferPointer {
        CH3.getRes0Cells($0.baseAddress)
    }
    precondition(err == 0, "getRes0Cells failed with error \(err)")

    return output
}

public func getRes0CellCount() -> Int {
    return Int(CH3.res0CellCount())
}

public func getPentagons(res: Int32) -> [UInt64] {
    var output = [UInt64](repeating: 0, count: pentagonCount())
    let err = output.withUnsafeMutableBufferPointer {
        CH3.getPentagons(res, $0.baseAddress)
    }
    precondition(err == 0, "getPentagons failed with error \(err)")

    return output
}

public func pentagonCount() -> Int {
    return Int(CH3.pentagonCount())
}

public func greatCircleDistanceKm(a: LatLng, b: LatLng) -> Double {
    withUnsafePointer(to: a) { pa in
        withUnsafePointer(to: b) { pb in
            CH3.greatCircleDistanceKm(pa, pb)
        }
    }
}

public func greatCircleDistanceM(a: LatLng, b: LatLng) -> Double {
    withUnsafePointer(to: a) { pa in
        withUnsafePointer(to: b) { pb in
            CH3.greatCircleDistanceM(pa, pb)
        }
    }
}

public func greatCircleDistanceRads(a: LatLng, b: LatLng) -> Double {
    withUnsafePointer(to: a) { pa in
        withUnsafePointer(to: b) { pb in
            CH3.greatCircleDistanceRads(pa, pb)
        }
    }
}

public func describeH3Error(err: Int32) -> String {
    let error: H3Error = UInt32(err)

    guard let cStr = CH3.describeH3Error(error) else {
        return "Unknown error"
    }

    return String(cString: cStr)
}