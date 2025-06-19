import CH3

public func cellToParent(cell: UInt64, resolution: Int) -> UInt64 {
    var parent: UInt64 = 0
    let err = CH3.cellToParent(cell, Int32(resolution), &parent)
    precondition(err == 0, "cellToParent failed with error \(err)")
    
    return parent
}

public func cellToChildren(cell: UInt64, childResolution: Int) -> [UInt64] {
    let count = cellToChildrenSize(cell: cell, childResolution: childResolution)
    var output = [UInt64](repeating: 0, count: Int(count))

    let err = output.withUnsafeMutableBufferPointer {
        CH3.cellToChildren(cell, Int32(childResolution), $0.baseAddress)
    }
    precondition(err == 0, "cellToChildren failed with error \(err)")
    
    return output
}

public func cellToChildrenSize(cell: UInt64, childResolution: Int) -> Int64 {
    var size: Int64 = 0
    let err = CH3.cellToChildrenSize(cell, Int32(childResolution), &size)
    precondition(err == 0, "cellToChildrenSize failed with error \(err)")

    return size
}

public func cellToCenterChild(cell: UInt64, childResolution: Int) -> UInt64 {
    var result: UInt64 = 0
    let err = CH3.cellToCenterChild(cell, Int32(childResolution), &result)
    precondition(err == 0, "cellToCenterChild failed with error \(err)")

    return result
}

public func cellToChildPos(child: UInt64, parentResolution: Int) -> Int64 {
    var pos: Int64 = 0
    let err = CH3.cellToChildPos(child, Int32(parentResolution), &pos)
    precondition(err == 0, "cellToChildPos failed with error \(err)")

    return pos
}

public func childPosToCell(position: Int64, parent: UInt64, childResolution: Int) -> UInt64 {
    var result: UInt64 = 0
    let err = CH3.childPosToCell(position, parent, Int32(childResolution), &result)
    precondition(err == 0, "childPosToCell failed with error \(err)")

    return result
}

public func compact(cells: [UInt64]) -> [UInt64] {
    var compacted = [UInt64](repeating: 0, count: cells.count)

    let err = cells.withUnsafeBufferPointer { inputBuf in
        compacted.withUnsafeMutableBufferPointer { outputBuf in
            CH3.compactCells(inputBuf.baseAddress, outputBuf.baseAddress, Int64(cells.count))
        }
    }
    precondition(err == 0, "compactCells failed with error \(err)")

    return compacted.filter { $0 != 0 }
}

public func uncompact(compacted: [UInt64], resolution: Int) -> [UInt64] {
    let maxSize = uncompactCellsSize(compacted: compacted, resolution: resolution)
    var result = [UInt64](repeating: 0, count: maxSize)

    let err = compacted.withUnsafeBufferPointer { inputBuf in
        result.withUnsafeMutableBufferPointer { outputBuf in
            CH3.uncompactCells(
                inputBuf.baseAddress,
                Int64(compacted.count),
                outputBuf.baseAddress,
                Int64(maxSize),
                Int32(resolution)
            )
        }
    }
    precondition(err == 0, "uncompactCells failed with error \(err)")
    
    return result.filter { $0 != 0 }
}

public func uncompactCellsSize(compacted: [UInt64], resolution: Int) -> Int {
    var size: Int64 = 0

    let err = compacted.withUnsafeBufferPointer {
        CH3.uncompactCellsSize($0.baseAddress, Int64(compacted.count), Int32(resolution), &size)
    }
    precondition(err == 0 && size >= 0, "uncompactCellsSize failed with error \(err)")
    
    return Int(size)
}