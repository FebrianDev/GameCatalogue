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
    var description_raw:String = ""
    var released: String = ""
    var background_image: String = ""
    var rating: Double = 0.0
    var rating_top:Int = 0
}
