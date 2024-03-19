//
//  MainView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 19/03/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView
        {
            
            // View do Mapa
            ContentView()
                .tabItem { 
                    VStack {
                    Image(systemName: "map.fill")
                    Text("Mapa")}
                }
            
            // View das recomendações
            RecomendationView()
                .tabItem {
                    VStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text("Recomendação")
                }
            }
                
        }
        
    }
}

#Preview {
    MainView()
}
