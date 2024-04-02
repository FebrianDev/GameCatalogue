//
//  GameMapper.swift
//  GameCatalogue
//
//  Created by Febrian on 28/03/24.
//

import Foundation

func gameMapper(
    input gameResponse: GamesResponse
) -> [Game] {
    return gameResponse.results.map { result in
        Game(
            id:result.id, name: result.name, backgroundImage: result.backgroundImage, released: result.released, ratingTop: result.ratingTop
        )
    }
}

func favoriteToGame(
    input result:FavoriteGame
) -> Game {
    return Game(id:result.id, name: result.name, backgroundImage: result.backgroundImage, released: result.released, ratingTop: result.ratingTop
    )
}
