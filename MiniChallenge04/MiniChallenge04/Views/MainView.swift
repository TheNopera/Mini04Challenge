//
//  MainView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 19/03/24.
//

import SwiftUI

struct MainView: View {
<<<<<<< Updated upstream
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
=======
    @StateObject var viewModel = PlacesViewModel() // Use StateObject para inicializar o ViewModel
    @StateObject var omboardingViewModel = OmboardingViewModel()
    @State var animation:Bool =  false
    @State var formReponseIndetifier:Bool =  false
    var body: some View {
        if animation == true{
            if formReponseIndetifier == true{
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
            }else{
                OmboardingView(formReponseIndetifier: $formReponseIndetifier)
                
            }
        }else{
            OmboardingSlider(animation: $animation)
        }
>>>>>>> Stashed changes
    }
}


#Preview {
    return MainView()
}

