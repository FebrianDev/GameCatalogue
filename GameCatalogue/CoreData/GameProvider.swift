//
//  GameProvider.swift
//  GameCatalogue
//
//  Created by Febrian on 31/03/24.
//

import Foundation
import CoreData

class GameProvider{
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameData")
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    
    func getAllGame(completion: @escaping(_ games: [FavoriteGame]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameDatabase")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [FavoriteGame] = []
                for result in results {
                    let favorite = FavoriteGame(
                        id: result.value(forKeyPath: "id") as? Int,
                        name: result.value(forKeyPath: "name") as? String,
                        backgroundImage :result.value(forKeyPath: "backgroundImage") as? String,
                        released:result.value(forKeyPath: "released") as? String,
                        ratingTop:result.value(forKeyPath: "ratingTop") as? Int
                    )
                    
                    games.append(favorite)
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func createGame(game: FavoriteGame, completion: @escaping (Bool) -> Void) {
        let taskContext = newTaskContext()
        
        taskContext.perform {
            let entity = NSEntityDescription.entity(forEntityName: "GameDatabase", in: taskContext)!
            let newGame = NSManagedObject(entity: entity, insertInto: taskContext)
            
            newGame.setValue(game.id, forKeyPath: "id")
            newGame.setValue(game.name, forKeyPath: "name")
            newGame.setValue(game.backgroundImage, forKeyPath: "backgroundImage")
            newGame.setValue(game.released, forKeyPath: "released")
            newGame.setValue(game.ratingTop, forKeyPath: "ratingTop")
            
            do {
                try taskContext.save()
                completion(true) // Return true indicating successful creation
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                completion(false) // Return false indicating failure
            }
        }
    }
    
    func deleteGame(withId id: Int, completion: @escaping (Bool) -> Void) {
        let taskContext = newTaskContext()
        
        taskContext.perform {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "GameDatabase")
            fetchRequest.predicate = NSPredicate(format: "id == %d", id)
            
            do {
                let result = try taskContext.fetch(fetchRequest)
                if let gameToDelete = result.first as? NSManagedObject {
                    taskContext.delete(gameToDelete)
                    try taskContext.save()
                    completion(true) // Return true indicating successful deletion
                } else {
                    print("Game not found with ID \(id)")
                    completion(false) // Return false indicating failure (game not found)
                }
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
                completion(false) // Return false indicating failure
            }
        }
    }
    
    
    func isDataExist(withId id: Int, completion: @escaping (Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GameDatabase")
            fetchRequest.predicate = NSPredicate(format: "id == %d", id)
            fetchRequest.fetchLimit = 1
            
            do {
                let resultCount = try taskContext.count(for: fetchRequest)
                completion(resultCount > 0)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                completion(false) // Return false in case of error
            }
        }
    }
}
