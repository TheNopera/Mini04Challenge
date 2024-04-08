//
//  MainView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 19/03/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            // View do Mapa
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map.fill")
                        Text("Teste")
                    }
                }.background(.black)

            // View das recomendações
            RecomendationView(viewModel: RecomendationViewModel())
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
    return MainView()
}

