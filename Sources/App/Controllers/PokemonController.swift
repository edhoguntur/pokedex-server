//
//  PokemonController.swift
//
//
//  Created by Edho Guntur Adhitama on 27/10/23.
//

import Vapor
import Fluent
import Foundation

struct PokemonController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let pokemons = routes.grouped("pokemons")
        pokemons.get(use: index)
        pokemons.get("all", use: showAll)
        pokemons.get("sync",":limit", use: sync)
        
        pokemons.group(":id") { pokemon in
            pokemon.get(use: showById)
            pokemon.put(use: update)
            pokemon.delete(use: delete)
        }
    }
    
    func index(req: Request) async throws -> String {
        return "It's Pokedex"
    }
    
    func sync(req: Request) async throws -> String {
        // Before sync lets delete all database
        try await Types.query(on: req.db)
            .delete()
        try await Pokemon.query(on: req.db)
            .delete()
        
        // get limit value
        let limit = req.parameters.get("limit")
        
        let headRes = try await req.client.get("https://pokeapi.co/api/v2/pokemon?limit=\(String(describing: limit))")
        let decodedHeadRes = try headRes.content.decode(PokedexApiHeaderSource.self)
        
        
        for result in decodedHeadRes.results {
            let pokeURL = result.url
            
            let detailRes = try await req.client.get("\(pokeURL)")
            let decodedDetailRes = try detailRes.content.decode(PokedexApiDetailSource.self)
            
            var hp: Int = 0, attack: Int = 0, defense: Int = 0, speed: Int = 0
            
            for stat in decodedDetailRes.stats {
                switch stat.stat.name {
                case "hp":
                    hp = stat.baseStat
                case "attack":
                    attack = stat.baseStat
                case "defense":
                    defense = stat.baseStat
                case "speed":
                    speed = stat.baseStat
                default:
                    continue
                }
            }
            
            // save to table pokemon and types on database
            let pokemon = Pokemon(externalID: decodedDetailRes.id, name: decodedDetailRes.name, hp: hp, attack: attack, defense: defense, speed: speed, imageUrl: decodedDetailRes.sprites.other.officialArtwork.frontDefault)
            
            // Save the Pokemon object to the database
            try await pokemon.create(on: req.db)
            
            // Create Types objects and associate them with the Pokemon
            for (_, type) in decodedDetailRes.types.enumerated() {
                let typeObject = Types(slot: type.slot, type: type.type.name, pokemonID: pokemon.id!)
                try await typeObject.create(on: req.db)
            }
        }
        
        return "Pokedex is synced successfully!"
        
    }
    
    func showAll(req: Request) async throws -> [Pokemon] {
        try await Pokemon.query(on: req.db).all()
    }
    
    func showById(req: Request) async throws -> Pokemon {
        guard let pokemon = try await Pokemon.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        return pokemon
    }
    
    func update(req: Request) async throws -> Pokemon {
        guard let pokemon = try await Pokemon.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let updatedPokemon = try req.content.decode(Pokemon.self)
        pokemon.hp = updatedPokemon.hp
        pokemon.attack = updatedPokemon.attack
        pokemon.defense = updatedPokemon.defense
        pokemon.speed = updatedPokemon.speed
        try await pokemon.save(on: req.db)
        return pokemon
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let pokemon = try await Pokemon.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await pokemon.delete(on: req.db)
        return .ok
    }
}
