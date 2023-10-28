//
//  PokedexApiHeader.swift
//
//
//  Created by Edho Guntur Adhitama on 27/10/23.
//

import Vapor
import Foundation

struct PokedexApiHeaderSource: Content {
    let results: [Result]
}

struct Result: Content {
    let name: String
    let url: String
}
