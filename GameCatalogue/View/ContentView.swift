//
//  ContentView.swift
//  GameCatalogue
//
//  Created by Febrian on 27/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = GameViewModel()
        @State private var games: [Game] = []
    
    var body: some View {
        NavigationView {
        VStack(alignment:.leading){
            
            HStack{
                Text("Game Catalogue").font(.title)
                Spacer()
                    NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.fill")
                                .foregroundColor(.black)
                                .font(.system(size: 24))
                    }
            }
            
            if(games.isEmpty){
                    ProgressView()
                .frame(maxWidth: UIScreen.main.bounds.width - 32, maxHeight: 100)
                
            }
          
            ScrollView(showsIndicators: false) {
                
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                        
                        ForEach(games, id: \.self) { item in
                            NavigationLink(destination: DetailGameView(id:item.id)){
                                CardView(game:item)
                            }
                        }
                        
                    }.onAppear{
                        if games.isEmpty {
                            viewModel.getGames{ fetchedGames, error in
                                if let fetchedGames = fetchedGames {
                                    self.games = fetchedGames
                                    print("Games \(games)")
                                } else if let error = error {
                                    print("Error fetching games: \(error)")
                                }
                            }
                        }
                    }
                    
                }
            }

        }.padding()
    }
}

struct CardView: View {
    
    let game:Game
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .frame(minHeight: 196)
            .overlay(
                VStack(alignment:.leading) {
                    
                    AsyncImage(url: URL(string: game.background_image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth:UIScreen.main.bounds.width - 32, maxHeight:100)
                            .clipped()
                            .cornerRadius(10)
                        
                    } placeholder: {
                        ProgressView()
                           .frame(maxWidth: UIScreen.main.bounds.width - 32, maxHeight: 100)
                    }
                    
                    Text(game.name)
                        .font(.system(size: 14, weight: .semibold)).padding(.top, 2).padding(.horizontal, 8)
                        .frame(maxWidth: .infinity, alignment: .leading) // Set maximum width to infinity
                        .fixedSize(horizontal: false, vertical: true).foregroundColor(.black)
                    
                    Text(game.released).font(.system(size:12)).foregroundColor(.black).padding(.horizontal, 8)
                    Text(String(game.rating_top)).font(.system(size:16, weight: .bold)).foregroundColor(.black).padding(.horizontal, 8).padding(.top, 2)
                    
                    Spacer()
                   
                }
            )
            .shadow(radius: 2)
            .padding(.bottom, 4)
    }
}

//API KEY
//161deabe57214ce389e3af3573aad03d

//https://api.rawg.io/api/games?key=161deabe57214ce389e3af3573aad03d


#Preview {
    ContentView()
}
