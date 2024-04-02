//
//  FavoriteView.swift
//  GameCatalogue
//
//  Created by Febrian on 31/03/24.
//

import SwiftUI

struct FavoriteView: View {
    
    @StateObject private var viewModel = FavoriteViewModel()
    @State private var favoriteGames: [FavoriteGame] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                
                ForEach(favoriteGames, id: \.self) { item in
                    NavigationLink(destination: DetailGameView(id:item.id)){
                        let game = favoriteToGame(input: item)
                        CardView(game:game)
                    }
                }
                
            }.onAppear{
                
                viewModel.getAllGames(){ games in
                    
                    self.favoriteGames = games
                    print("Games \(games)")
                    
                }
                
            }
            
        }
    }
}

