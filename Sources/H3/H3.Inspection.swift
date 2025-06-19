import CH3

public func getResolution(cell: UInt64) -> Int32 {
    return CH3.getResolution(cell)
}

public func getBaseCellNumber(cell: UInt64) -> Int32 {
    return CH3.getBaseCellNumber(cell)
}

public func stringToH3(cellAsString: String) -> UInt64 {
    var index: H3Index = 0
    let error = cellAsString.utf8CString.withUnsafeBufferPointer { buf -> H3Error in
        CH3.stringToH3(buf.baseAddress, &index)
    }
    precondition(error == 0, "stringToH3 failed with error code \(error)")

    return index
}

private var bufferSize = 17

public func h3ToString(cell: UInt64) -> String {
    var cString = [CChar](repeating: 0, count: bufferSize)
    let error = CH3.h3ToString(cell, &cString, bufferSize)
    precondition(error == 0, "h3ToString failed with error code \(error)")

    return String(cString: cString)
}

public func isValidCell(cell: UInt64) -> Bool {
    return CH3.isValidCell(cell) != 0
}

public func isResClassIII(cell: UInt64) -> Bool {
    return CH3.isResClassIII(cell) != 0
}

public func isPentagon(cell: UInt64) -> Bool {
    return CH3.isPentagon(cell) != 0
}

public func getIcosahedronFaces(cell: UInt64) -> [Int] {
    var count: Int32 = 0
    let maxFaceCountErr = CH3.maxFaceCount(cell, &count)
    precondition(maxFaceCountErr == 0 && count > 0, "maxFaceCount failed")

    var output = [Int32](repeating: -1, count: Int(count))
    let err = CH3.getIcosahedronFaces(cell, &output)
    precondition(err == 0, "getIcosahedronFaces failed")

    return output.filter { $0 != -1 }.map(Int.init)
}

public func maxFaceCount(cell: UInt64) -> Int {
    var faceCount: Int32 = 0
    let err = CH3.maxFaceCount(cell, &faceCount)
    precondition(err == 0, "maxFaceCount failed")
    return Int(faceCount)
}