//
//  PokedexApi.swift
//
//
//  Created by Edho Guntur Adhitama on 27/10/23.
//

import Foundation

struct PokedexApiHeaderSource: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let name: String
    let url: String
}

struct PokedexApiDetailSource: Decodable {
    let height: Int
    let id: Int
    let name: String
    let sprites: Sprites
    let stats: [Stat]
    let types: [Type]
}

struct Sprites: Decodable {
    let other: OtherSprites
}

struct OtherSprites: Decodable {
    let officialArtwork: OfficialArtworkSprites
}

struct OfficialArtworkSprites: Decodable {
    let frontDefault: String
}

struct Stat: Decodable {
    let baseStat: Int
    let stat: StatDetail
}

struct StatDetail: Decodable {
    let name: String
}

struct Type: Decodable {
    let slot: Int
    let type: TypeDetail
}

struct TypeDetail: Decodable {
    let name: String
}
