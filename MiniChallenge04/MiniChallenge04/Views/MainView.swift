//
//  MainView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 19/03/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = PlacesViewModel() // Use StateObject para inicializar o ViewModel
    @StateObject var viewModelRecommendation = RecomendationViewModel()
    @StateObject var omboardingViewModel = OmboardingViewModel()
    @State var animation:Bool =  false
    @State var formReponseIndetifier:Bool =  false
    var body: some View {
        VStack{
            if animation == true{
                if formReponseIndetifier == true{
                    TabView {
                        // View do Mapa
                        MapView(isPresented: false)
                            .tabItem {
                                VStack {
                                    Image(systemName: "map.fill")
                                    Text("Mapa")
                                }
                            }
                        // View das recomendações
                        RecomendationView(viewModel: viewModelRecommendation)
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
        }
        .task {
            if let formResultSaved = UserDefaults.standard.dictionary(forKey: "formResult") {
                if let temperaturaResult = formResultSaved["Temperatura"] as? Int {
                    if temperaturaResult != 0{
                        self.formReponseIndetifier = true
                    }
                }
            }
        }
    }
}


#Preview {
    return MainView()
}

