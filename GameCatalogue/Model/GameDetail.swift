//
//  GameDetail.swift
//  GameCatalogue
//
//  Created by Febrian on 28/03/24.
//

import Foundation

struct GameDetail: Codable, Hashable {
    var id: Int = 0
    var name: String = ""
    var descriptionRaw: String = ""
    var released: String = ""
    var backgroundImage: String = ""
    var rating: Double = 0.0
    var ratingTop: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case descriptionRaw = "description_raw"
        case backgroundImage = "background_image"
        case released
        case ratingTop = "rating_top"
    }
}
