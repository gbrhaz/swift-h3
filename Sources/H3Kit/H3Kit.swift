import Foundation
import CoreLocation
import CH3

extension CLLocationCoordinate2D {
    // Find the H3 cell index for a given set of 2D coordinates
    public func h3CellIndex( resolution: Int32 ) -> H3Index? {
        var latLng = LatLng(lat: lat, lon: lng)
        var h3index: H3Index = 0

        let error = latLngToCell(&latLng, resolution, &h3index)

        return error == 0 ? h3index : nil
    }
}