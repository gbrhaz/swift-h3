import CH3

public func latLngToCell(latitude: Double, longitude: Double, resolution: Int) -> UInt64 {
    var coords = CH3.LatLng(lat: CH3.degsToRads(latitude), lng: CH3.degsToRads(longitude))
    var index: H3Index = 0
    let error = CH3.latLngToCell(&coords, Int32(resolution), &index)
    precondition(error == 0, "latLngToCell failed with error code \(error)")

    return index
}

public func cellToLatLng(cell: UInt64) -> (latitude: Double, longitude: Double) {
    var coords = LatLng(lat: 0, lng: 0)
    let error = CH3.cellToLatLng(cell, &coords)
    precondition(error == 0, "cellToLatLng failed with error code \(error)")
    
    let latDeg = CH3.radsToDegs(coords.lat)
    let lngDeg = CH3.radsToDegs(coords.lng)
    return (latitude: latDeg, longitude: lngDeg)
}

public func cellToBoundary(cell: UInt64) -> [CH3.LatLng] {
    var boundary = CellBoundary()
    let err = CH3.cellToBoundary(cell, &boundary)
    precondition(err == 0, "cellToBoundary failed")
    
    let coords = withUnsafeBytes(of: &boundary.verts) { raw -> [LatLng] in
        let buffer = raw.bindMemory(to: LatLng.self)
        var result = Array(buffer.prefix(Int(boundary.numVerts)))
        for (i, latlng) in result.enumerated() {
            result[i].lat = radsToDegs(latlng.lat)
            result[i].lng = radsToDegs(latlng.lng)
        }
        return result
    }

    return coords
}
