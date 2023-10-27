//
//  CreateTypes.swift
//
//
//  Created by Edho Guntur Adhitama on 27/10/23.
//

import Fluent

struct CreateTypes: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("types")
            .id()
            .field("slot", .int, .required)
            .field("type", .string, .required)
            .field("pokemon_id", .uuid, .references("pokemons", "id"))
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema("types").delete()
    }
}
