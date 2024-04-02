//
//  FavoriteViewModel.swift
//  GameCatalogue
//
//  Created by Febrian on 31/03/24.
//

import Foundation

class FavoriteViewModel : ObservableObject{
    
    private lazy var gameProvider: GameProvider = { return GameProvider() }()
    
    func getAllGames(completion: @escaping(_ games: [FavoriteGame]) -> Void) {
        gameProvider.getAllGame { game in
            DispatchQueue.main.async {
                completion(game)
            }
        }
    }
    
    func createGame(game: FavoriteGame, completion: @escaping(_ message: String) -> Void) {
        gameProvider.createGame(game: game) { success in
            DispatchQueue.main.async {
                if success{
                    completion("Success Add Favorite Game")
                }else{
                    completion("Failed Add Favorite Game")
                }
            }
        }
    }
    
    func deleteGame(withId id: Int, completion: @escaping(_ message: String)-> Void) {
        gameProvider.deleteGame(withId: id) { success in
            DispatchQueue.main.async {
                if success{
                    completion("Success Delete Favorite Game")
                }else{
                    completion("Failed Delete Favorite Game")
                }
            }
        }
    }
    
    // Check if a game with the given ID exists in CoreData
    func isGameExist(withId id: Int, completion: @escaping(_ exists: Bool)-> Void) {
        gameProvider.isDataExist(withId: id) { exist in
            DispatchQueue.main.async {
                completion(exist)
                if exist {
                    print("Game with ID \(id) exists in the database.")
                } else {
                    print("No game with ID \(id) exists in the database.")
                }
            }
        }
    }
}
