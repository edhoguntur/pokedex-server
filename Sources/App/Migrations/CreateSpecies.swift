//
//  CreateSpecies.swift
//
//
//  Created by Edho Guntur Adhitama on 28/10/23.
//

import Fluent

struct CreateSpecies: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("species")
            .id()
            .field("habitat", .string)
            .field("color", .string)
            .field("pokemon_id", .uuid, .references("pokemons", "id"))
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema("species").delete()
    }
}
