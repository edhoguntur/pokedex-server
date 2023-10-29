//
//  TypesController.swift
//
//
//  Created by Edho Guntur Adhitama on 29/10/23.
//

import Vapor
import Fluent


struct TypesController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let types = routes.grouped("types")
        types.get(use: index)
        
        types.group(":pokemon_id") { type in
            type.get(use: showByPokemonId)
        }
        
        func index(req: Request) -> String {
            return "Pokemon types api is work!"
        }
        
        func showByPokemonId(req: Request) async throws -> [Types] {
            
            guard let pokemonIdString = req.parameters.get("pokemon_id"),
                  let pokemonId = UUID(pokemonIdString) else {
                throw Abort(.badRequest, reason: "Invalid Pokemon ID")
            }
            
            let types = try await Types.query(on: req.db)
                .filter(\.$pokemon.$id == pokemonId)
                .all()
            
            if types.isEmpty {
                throw Abort(.notFound)
            }
            
            return types
        }
        
    }
    
    
    
    
}
