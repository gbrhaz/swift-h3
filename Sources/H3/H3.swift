import CH3  // Import the Clang module for H3 C API

public struct H3 {
    /// Converts a latitude/longitude (in degrees) to an H3 cell index at the given resolution.
    public static func latLngToCell(latitude: Double, longitude: Double, resolution: Int) -> UInt64 {
        // Prepare coordinates in radians for the H3 C function
        var coords = LatLng(lat: deg2rad(latitude), lng: deg2rad(longitude))
        var index: H3Index = 0
        let error = latLngToCell(&coords, Int32(resolution), &index)
        precondition(error == 0, "latLngToCell failed with error code \(error)")
        return index  // Return the 64-bit H3 index
    }

    /// Converts an H3 cell index to the latitude/longitude (in degrees) of the cell center.
    public static func cellToLatLng(cell: UInt64) -> (latitude: Double, longitude: Double) {
        var coords = LatLng(lat: 0, lng: 0)
        let error = cellToLatLng(cell, &coords)
        precondition(error == 0, "cellToLatLng failed with error code \(error)")
        // Convert radians back to degrees for the result
        let latDeg = rad2deg(coords.lat)
        let lngDeg = rad2deg(coords.lng)
        return (latitude: latDeg, longitude: lngDeg)
    }

    /// Returns all H3 cell indices within k hexagonal steps (radius k) of the origin cell (inclusive).
    public static func kRing(origin: UInt64, k: Int) -> [UInt64] {
        // Determine the maximum number of cells in a k-ring (hexagonal disk of radius k)
        let count = 3 * k * (k + 1) + 1
        var output = [H3Index](repeating: 0, count: count)
        // Call the H3 gridDisk function to get neighbors (k-ring)
        let error: H3Error = output.withUnsafeMutableBufferPointer { buf in
            guard let basePtr = buf.baseAddress else { return 1 }
            return gridDisk(origin, Int32(k), basePtr)
        }
        precondition(error == 0, "kRing (gridDisk) failed with error code \(error)")
        return output
    }

    // MARK: - Private Helper Functions

    /// Converts degrees to radians.
    @inline(__always)
    private static func deg2rad(_ degrees: Double) -> Double {
        return degrees * .pi / 180.0
    }
    /// Converts radians to degrees.
    @inline(__always)
    private static func rad2deg(_ radians: Double) -> Double {
        return radians * 180.0 / .pi
    }
}
