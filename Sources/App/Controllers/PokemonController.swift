//
//  PokemonController.swift
//  
//
//  Created by Edho Guntur Adhitama on 27/10/23.
//

import Vapor
import Fluent

struct PokemonController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let pokemons = routes.grouped("pokemons")
        pokemons.get(use: index)
    }
    
    func index(req: Request) async throws -> String {
        return "It's Pokedex"
    }
}
