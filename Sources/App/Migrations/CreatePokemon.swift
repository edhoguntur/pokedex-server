//
//  CreatePokemon.swift
//
//
//  Created by Edho Guntur Adhitama on 27/10/23.
//

import Fluent

struct CreatePokemon: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("pokemons")
            .id()
            .field("external_id", .int, .required)
            .field("name", .string, .required)
            .field("types", .string, .required)
            .field("hp", .int, .required)
            .field("attack", .int, .required)
            .field("defense", .int, .required)
            .field("speed", .int, .required)
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema("pokemon").delete()
    }
}
