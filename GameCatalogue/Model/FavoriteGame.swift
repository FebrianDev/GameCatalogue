//
//  FavoriteGame.swift
//  GameCatalogue
//
//  Created by Febrian on 31/03/24.
//

import Foundation

struct FavoriteGame: Codable, Hashable {
    let id: Int
    let name: String
    let backgroundImage: String
    let released: String
    let ratingTop: Int
    
    init(id: Int?, name: String?, backgroundImage: String?, released: String?, ratingTop: Int?) {
        self.id = id ?? 0
        self.name = name ?? ""
        self.backgroundImage = backgroundImage ?? ""
        self.released = released ?? ""
        self.ratingTop = ratingTop ?? 0
    }
}
