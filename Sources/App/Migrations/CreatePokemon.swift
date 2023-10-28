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
            .field("hp", .int)
            .field("attack", .int)
            .field("defense", .int)
            .field("speed", .int)
            .field("image_url", .string)
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema("pokemon").delete()
    }
}
