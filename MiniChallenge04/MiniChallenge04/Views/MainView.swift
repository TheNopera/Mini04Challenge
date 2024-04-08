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
            Group {
                // View do Mapa
                MapView(isPresented: false)
                    .tabItem {
                        VStack {
                            Spacer()
                            Image(systemName: "map.fill")
                            Text("Teste")
                        }
                    }
                
                // View das recomendações
                RecomendationView(viewModel: RecomendationViewModel())
                    .tabItem {
                        VStack {
                            Image(systemName: "hand.thumbsup.fill")
                            Text("Recomendação")
                        }
                    }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.88)
            .offset(y: -30)
            
        }
    }
}


#Preview {
    return MainView()
}

