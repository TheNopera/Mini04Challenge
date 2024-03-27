//
//  MainView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 19/03/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = RecomendationViewModel() // Use StateObject para inicializar o ViewModel
    
    var body: some View {
        TabView {
            // View do Mapa
            MapView()
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
        }.background(.black)
    }
}

#Preview {
    let viewModel = RecomendationViewModel()
    viewModel.recomendationModel.recomendacoes = ["DF", "SP", "RJ", "CE"]
    return MainView(viewModel: viewModel)
}
