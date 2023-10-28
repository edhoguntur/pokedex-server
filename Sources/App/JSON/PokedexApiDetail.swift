//
//  PokedexApiDetail.swift
//
//
//  Created by Edho Guntur Adhitama on 28/10/23.
//

import Vapor
import Foundation

struct PokedexApiDetailSource: Content {
    let height: Int
    let id: Int
    let name: String
    let sprites: Sprites
    let species: SpeciesDetail
    let stats: [Stat]
    let types: [Type]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        height = try container.decode(Int.self, forKey: .height)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
        species = try container.decode(SpeciesDetail.self, forKey: .species)
        stats = try container.decode([Stat].self, forKey: .stats)
        types = try container.decode([Type].self, forKey: .types)
    }
}

struct Sprites: Content {
    let other: OtherSprites
}

struct OtherSprites: Content {
    let officialArtwork: OfficialArtworkSprites
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            officialArtwork = try container.decode(OfficialArtworkSprites.self, forKey: .officialArtwork)
        }
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtworkSprites: Content {
    let frontDefault: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        frontDefault = (try? container.decode(String.self, forKey: .frontDefault)) ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Stat: Content {
    let baseStat: Int
    let stat: StatDetail
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseStat = try container.decode(Int.self, forKey: .baseStat)
        stat = try container.decode(StatDetail.self, forKey: .stat)
    }
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat = "stat"
    }
}

struct StatDetail: Content {
    let name: String
}

struct Type: Content {
    let slot: Int
    let type: TypeDetail
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        slot = try container.decode(Int.self, forKey: .slot)
        type = try container.decode(TypeDetail.self, forKey: .type)
    }
}

struct TypeDetail: Content {
    let name: String
}

struct SpeciesDetail: Content {
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}
