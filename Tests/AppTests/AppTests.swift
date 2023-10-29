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
        
        try app.test(.GET, "pokemons/sync/1", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Pokedex is synced successfully!")
        })
    }
    
    func testTypesIndex() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)
        
        try app.test(.GET, "types", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "Pokemon types api is work!")
        })
        
    }
    
    func testTypesShowByPokemonID() async throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        try await configure(app)
        
        // Create Mock Data
        let types = Types()
        types.slot = 1
        types.type = "water"
        
        let pokemon = Pokemon()
        pokemon.name = "Squirtle"
        pokemon.externalID = 1
        pokemon.hp = 1
        pokemon.attack = 1
        pokemon.defense = 1
        pokemon.speed = 1
        
        
        try await app.autoMigrate()
        try await pokemon.create(on: app.db)
        
        types.$pokemon.id = pokemon.id!
        try await types.create(on: app.db)
        
        
        try app.test(.GET, "types/\(types.$pokemon.id)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
        })
        
    }
}
