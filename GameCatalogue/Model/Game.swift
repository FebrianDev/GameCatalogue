//
//  Game.swift
//  GameCatalogue
//
//  Created by Febrian on 27/03/24.
//

import Foundation

struct Game: Codable, Hashable {
    let id: Int
    let name: String
    let backgroundImage: String
    let released: String
    let ratingTop: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backgroundImage = "background_image"
        case released
        case ratingTop = "rating_top"
    }
}
