@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    func testHelloWorld() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try app.test(.GET, "hello", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Hello, world!")
        })
    }
    
    func testIndex() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try app.test(.GET, "pokemons", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "It's Pokedex")
        })
    }
    
    func testSync() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)

        try app.test(.GET, "pokemons/sync", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Pokedex is synced successfully!")
        })
    }
}
