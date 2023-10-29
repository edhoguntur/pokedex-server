//
//  TypesController.swift
//
//
//  Created by Edho Guntur Adhitama on 29/10/23.
//

import Vapor


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
            guard let types = try await Types.find(req.parameters.get("pokemon_id"), on: req.db) else {
                throw Abort(.notFound)
            }
            return [types]
            
        }
        
    }
    
    
    
    
}
