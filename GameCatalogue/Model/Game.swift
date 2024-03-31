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
    let background_image: String
    let released: String
    let rating_top:Int
}
