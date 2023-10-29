//
//  Species.swift
//
//
//  Created by Edho Guntur Adhitama on 28/10/23.
//

import Fluent
import Vapor

final class Species: Model, Content {
    static let schema = "species"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "habitat")
    var habitat: String
    
    @Field(key: "color")
    var color: String
    
    @Parent(key: "pokemon_id")
    var pokemon: Pokemon

    init() { }
    
    init(id: UUID? = nil, habitat: String, color: String, pokemonID: UUID) {
        self.id = id
        self.habitat = habitat
        self.color = color
        self.$pokemon.id = pokemonID
    }
}

