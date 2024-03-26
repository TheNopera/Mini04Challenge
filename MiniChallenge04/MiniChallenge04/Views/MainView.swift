//
//  MainView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 19/03/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = PlacesViewModel() // Use StateObject para inicializar o ViewModel
    
    var body: some View {
        TabView {
            // View do Mapa
            ContentView()
                .tabItem {
                    VStack {
                        Image(systemName: "map.fill")
                        Text("Mapa")
                    }
                }

            // View das recomendações
            RecomendationView(viewModel: viewModel)
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
    let viewModel = PlacesViewModel()
    viewModel.recomendationModel.recomendacoes = ["DF", "SP", "RJ", "CE"]
    return MainView(viewModel: viewModel)
}
