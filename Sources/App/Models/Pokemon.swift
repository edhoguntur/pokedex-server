//
//  Pokemon.swift
//
//
//  Created by Edho Guntur Adhitama on 27/10/23.
//

import Fluent
import Vapor

final class Pokemon: Model {
    
    static let schema = "pokemons"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "external_id")
    var externalID: Int
    
    @Field(key: "name")
    var name: String
    
    @Children(for: \.$pokemon)
    var types: [Types]
    
    @OptionalChild(for: \.$pokemon)
    var species: Species?
    
    @Field(key: "hp")
    var hp: Int
    
    @Field(key: "attack")
    var attack: Int
    
    @Field(key: "defense")
    var defense: Int
    
    @Field(key: "speed")
    var speed: Int
    
    @Field(key: "image_url")
    var imageUrl: String
    
    
    init() { }
    
    init(id: UUID? = nil, externalID: Int, name: String, hp: Int, attack: Int, defense: Int, speed: Int, imageUrl: String) {
        self.id = id
        self.externalID = externalID
        self.name = name
        self.hp = hp
        self.attack = attack
        self.defense = defense
        self.speed = speed
        self.imageUrl = imageUrl
    }

}


