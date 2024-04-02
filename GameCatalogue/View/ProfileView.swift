//
//  ProfileView.swift
//  GameCatalogue
//
//  Created by Febrian on 29/03/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing:12){
            Image("febrian")
                .resizable()
                .frame(width: 150.0, height: 150.0)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            
            
            Text("M Dwi Febrian")
                .font(.title3)
                .bold()
            
            Text("Mobile Developer")
                .font(.subheadline)
            
            
            Divider()
            
            Text("Hello, my name is Febrian. I am a Mobile Developer. I possess skills in Mobile Development, including expertise in Kotlin/Java, Jetpack Compose, Flutter/Dart, and SwiftUI")
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(.all, 16)
            
            Spacer()
        }
    }
}
