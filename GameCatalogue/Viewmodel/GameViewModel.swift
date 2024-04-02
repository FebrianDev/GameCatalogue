//
//  GameViewModel.swift
//  GameCatalogue
//
//  Created by Febrian on 28/03/24.
//

import Foundation

class GameViewModel : ObservableObject{
    
    let gameRepository = GameRepository()
    
    func getGames(completion: @escaping ([Game]?, Error?) -> Void){
        
        Task {
            do {
                let games = try await gameRepository.getGames()
                completion(games, nil)
            }catch{
                completion(nil, error)
            }
            
        }
    }
    
    func getDetailGame(gameId: Int,completion: @escaping (GameDetail?, Error?) -> Void){
        Task {
            do {
                let games = try await gameRepository.getDetailGame(id:gameId)
                completion(games, nil)
            }catch{
                completion(nil, error)
            }
            
        }
    }
}
