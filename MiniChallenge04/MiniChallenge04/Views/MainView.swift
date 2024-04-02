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
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map.fill")
                        Text("Mapa")
                    }
                }.background(.black)

            // View das recomendações
            RecomendationView(viewModel: viewModel)
                .tabItem {
                    VStack {
                        Image(systemName: "hand.thumbsup.fill")
                        Text("Recomendação")
                    }
                }.background(.black)
        }.background(.black)
    }
}


#Preview {
    let viewModel = PlacesViewModel()
    viewModel.recomendationModel.recomendacoes = ["DF", "SP", "RJ", "CE"]
    return MainView(viewModel: viewModel)
}

