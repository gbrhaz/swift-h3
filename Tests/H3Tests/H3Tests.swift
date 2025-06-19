import XCTest
@testable import H3

final class H3Tests: XCTestCase {
    func testLatLngToCellAndBack() {
        // Example coordinates and resolution
        let latitude: Double = 37.7750
        let longitude: Double = -122.4183
        let res = 9
        // Convert to H3 index and back to coordinates
        let index = H3.latLngToCell(latitude: latitude, longitude: longitude, resolution: res)
        let (lat2, lng2) = H3.cellToLatLng(cell: index)
        // Converting the returned center back to an index should yield the same index
        let index2 = H3.latLngToCell(latitude: lat2, longitude: lng2, resolution: res)
        XCTAssertEqual(index, index2, "Converting to H3 and back should return the same index")
    }

    func testKRingNeighbors() {
        // Use an index at resolution 1 (e.g., for lat=0, lng=0)
        let origin = H3.latLngToCell(latitude: 0.0, longitude: 0.0, resolution: 1)
        // k = 0 should return just the origin
        let neighbors0 = H3.kRing(origin: origin, k: 0)
        XCTAssertEqual(neighbors0.count, 1)
        XCTAssertEqual(neighbors0[0], origin)
        // k = 1 should return 7 indexes (origin + its 6 neighbors)
        let neighbors1 = H3.kRing(origin: origin, k: 1)
        XCTAssertEqual(neighbors1.count, 7, "k=1 should return 7 cells (origin + 6 neighbors)")
        XCTAssertTrue(neighbors1.contains(origin))
        // k = 2 should return 19 indexes (origin + neighbors at distance 1 and 2)
        let neighbors2 = H3.kRing(origin: origin, k: 2)
        XCTAssertEqual(neighbors2.count, 19, "k=2 should return 19 cells")
    }
}
