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
    @State private var game: GameDetail = GameDetail()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment:.leading) {
                AsyncImage(url: URL(string: game.background_image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.size.width - 24, height: UIScreen.main.bounds.size.height / 4, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                } placeholder: {
                    ProgressView()
                }
                
                Text(game.name)
                    .font(.system(size: 16, weight: .bold)).padding(.horizontal, 8).padding(.top, 4)
                
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
                        Text(String(game.rating_top)).font(.system(size:13, weight:.regular))
                    }
                    
                }.padding(.top, 2).padding(.horizontal, 8)
                
                                Text("About")
                                    .font(.system(size: 14, weight: .semibold)).padding(.top, 4).padding(.horizontal, 8)
                
                Text(game.description_raw)
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
            
        }
    
    }
    
}
