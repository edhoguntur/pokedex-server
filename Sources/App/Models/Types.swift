//
//  Types.swift
//  
//
//  Created by Edho Guntur Adhitama on 27/10/23.
//

import Fluent
import Vapor

final class Types: Model {
    static let schema = "types"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "slot")
    var slot: Int
    
    @Field(key: "type")
    var type: String
    
    @Parent(key: "pokemon_id")
    var pokemon: Pokemon

    init() { }
    
    init(id: UUID? = nil, slot: Int, type: String, pokemonID: UUID) {
        self.id = id
        self.slot = slot
        self.type = type
        self.$pokemon.id = pokemonID
    }
}

