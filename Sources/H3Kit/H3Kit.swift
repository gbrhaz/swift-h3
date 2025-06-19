import Foundation
import CoreLocation
import CH3

extension CLLocationCoordinate2D {
    // Find the H3 cell index for a given set of 2D coordinates
    public func h3CellIndex( resolution: Int32 ) -> UInt64 {
        let lat = degsToRads(latitude)
        let lon = degsToRads(longitude)
        var location = GeoCoord(lat: lat, lon: lon)
        let index = geoToH3(&location, resolution)
        return index
    }
    // Find the neighbor cells for a given set of 2D coordinates and ring size
    public func h3Neighbors( resolution: Int32, ringLevel: Int32 ) -> [H3Index]
    {
        let index = h3CellIndex(resolution: resolution)
        let count = Int(maxKringSize(ringLevel))
        var neighbors = Array(repeating: H3Index(), count: count)
        kRing(index, ringLevel, &neighbors);
        return neighbors
    }
}