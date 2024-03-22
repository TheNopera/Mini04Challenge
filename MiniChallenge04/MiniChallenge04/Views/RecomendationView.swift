//
//  RecomendationView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 19/03/24.
//

import SwiftUI
let categorias = ["Acampamento", "Praia", "Montanhas", "Floresta"]
struct RecomendationView: View {
    @ObservedObject var viewModel: RecomendationViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(spacing: 0) {
                        Image("Brazil")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 256)
                            .clipped()
                        SearchBar(text: $searchText)
                            .padding(.horizontal)
                            .offset(y: -25)
                            .shadow(radius: 10)
                        
                        VStack(spacing: 10) {
                            SectionComponent(sectionName: "Para Você!", linkText: "Mostrar mais")
                                .padding(.bottom)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 25) {
                                    ForEach(viewModel.recomendationModel.recomendacoes, id: \.self) { recomendacao in
                                        PlaceCard(cityName: recomendacao)
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
                        SectionComponent(sectionName: "Mais Procurados")
                    }
                }
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
    viewModel.recomendationModel.recomendacoes = ["Distrito Federal", "São Paulo", "Rio de Janeiro", "Ceara"]
    
    return RecomendationView(viewModel: viewModel)
        
}
