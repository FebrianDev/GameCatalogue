//
//  GameRepository.swift
//  GameCatalogue
//
//  Created by Febrian on 27/03/24.
//

import Foundation

class GameRepository{
    
    let baseUrl = "https://api.rawg.io/api/games"
    
    // Replace this example API Key
    // Get at https://rawg.io/apidocs
    let apiKey = "161deabe57214ce389e3af3573aad03d"
    
    public func getGames() async throws -> [Game]{
        var components = URLComponents(string: baseUrl)!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching data. \(response.description)")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(GamesResponse.self, from: data)
        
        return gameMapper(input: result)
    }
    
    public func getDetailGame(id:Int) async throws -> GameDetail{
        var components = URLComponents(string: "\(baseUrl)/\(id)")!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching data. \(response.description)")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(GameDetail.self, from: data)
        
        return result
    }
    
}
