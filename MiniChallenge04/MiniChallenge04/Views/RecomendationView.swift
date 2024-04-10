//
//  RecomendationView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 19/03/24.
//

import SwiftUI
let categorias = ["Acampamento", "Praia", "Montanhas", "Floresta"]
struct RecomendationView: View {
    @ObservedObject var api = PlacesViewModel()
    @ObservedObject var viewModel: RecomendationViewModel
    @State var recommendations : [String]?
    @State private var searchText = ""
    @State var isCurrentlyRefreshing = false

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    if isCurrentlyRefreshing {
                        ProgressView()
                            .padding()
                    }
                    VStack(spacing: 0) {
                        Image("Brazil")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 256)
                            .clipped()
                        SearchBar(text: $searchText)
                            .padding(.horizontal)
                            .offset(y: -25)
                            .shadow(color: .gray, radius: 10)

                        
                        VStack(spacing: 10) {
                            SectionComponent(sectionName: "Para Você!")
                                .padding(.bottom)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 25) {
                                    ForEach(recommendations ?? [], id: \.self) { recomendacao in
                                     
                                        PlaceCard(cityName: recomendacao, vm: self.api)
                                        
                                        
                                    }
                                }.padding(.horizontal)
                            }
                            SectionComponent(sectionName: "Categorias")
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 25) {
                                    ForEach(categorias, id: \.self) { categoria in
                                     RoundCard(category: categoria)
                                        
                                    }
                                }.padding()
                            }
                        }
                    }
                }
            }
            .task {
                let states = viewModel.getStates(quant: 4)
                self.recommendations = states
                
            }
            .refreshable {
                isCurrentlyRefreshing = true
                api.apiIsCallable = true
                isCurrentlyRefreshing = false
            }
            
            .ignoresSafeArea(edges:.top)
        }
    }
}





struct SectionHeader: View {
    var title: String
    

    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .bold()
            Spacer()
        }
        .padding()
    }
}

#Preview {
  

    let viewModel = RecomendationViewModel()

    
    return RecomendationView(viewModel: viewModel, recommendations: [])
        
}
