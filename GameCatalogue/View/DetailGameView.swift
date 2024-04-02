//
//  DetailGameView.swift
//  GameCatalogue
//
//  Created by Febrian on 28/03/24.
//

import SwiftUI
import UIKit

struct DetailGameView: View {
    
    let id:Int
    
    @StateObject private var viewModel = GameViewModel()
    @StateObject private var favoriteViewModel = FavoriteViewModel()
    @State private var game: GameDetail = GameDetail()
    @State private var exist : Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment:.leading) {
                AsyncImage(url: URL(string: game.backgroundImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width - 24, height: UIScreen.main.bounds.size.height / 4, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                } placeholder: {
                    ProgressView()
                }
                
                HStack{
                    Text(game.name)
                        .font(.system(size: 16, weight: .bold)).padding(.horizontal, 8).padding(.top, 4)
                    Spacer()
                    Button(action: {
                        
                        if exist {
                            favoriteViewModel.deleteGame(withId:game.id){message in
                                
                            }
                            exist = false
                        }else{
                            favoriteViewModel.createGame(game: FavoriteGame(id:game.id, name:game.name, backgroundImage: game.backgroundImage, released:game.released, ratingTop:game.ratingTop )){ message in
                                
                            }
                            exist = true
                        }
                        
                    }) {
                        Image(systemName: exist ? "bookmark.fill" : "bookmark")
                            .foregroundColor(.black)
                    }.padding(.horizontal, 4)
                }
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), alignment: .center) {
                    VStack(alignment:.center){
                        Text("Released").font(.system(size:12, weight:.light))
                        Text(game.released).font(.system(size:13, weight:.regular))
                    }
                    
                    VStack(alignment:.center){
                        Text("Rating").font(.system(size:12, weight:.light))
                        Text(String(format: "%.2f", game.rating)).font(.system(size:13, weight:.regular))
                    }
                    
                    VStack(alignment:.center){
                        Text("Rating Top").font(.system(size:12, weight:.light))
                        Text(String(game.ratingTop)).font(.system(size:13, weight:.regular))
                    }
                    
                }.padding(.top, 2).padding(.horizontal, 8)
                
                Text("About")
                    .font(.system(size: 14, weight: .semibold)).padding(.top, 4).padding(.horizontal, 8)
                
                Text(game.descriptionRaw)
                    .font(.system(size: 12)).padding(.horizontal, 8)
            }
        }.padding().onAppear{
            
            viewModel.getDetailGame(gameId: id){ fetchedGames, error in
                if let fetchedGames = fetchedGames {
                    self.game = fetchedGames
                    print("Games \(game)")
                } else if let error = error {
                    print("Error fetching games: \(error)")
                }
            }
            
            favoriteViewModel.isGameExist(withId: id){ exists in
                exist = exists
                
                print("Exist Game\(exists) \(id)")
            }
            
        }
        
    }
    
}
