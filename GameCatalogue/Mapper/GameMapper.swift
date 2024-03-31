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
        id:result.id, name: result.name, background_image: result.background_image, released: result.released, rating_top: result.rating_top
      )
    }
  }
