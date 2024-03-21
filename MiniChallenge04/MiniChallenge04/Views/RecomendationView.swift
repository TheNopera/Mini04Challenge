//
//  RecomendationView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 19/03/24.
//

import SwiftUI

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
                            .frame(width: 390, height: 256)
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea()
                        
                        SearchBar(text: $searchText)
                            .padding(.horizontal)
                            .offset(y: -25)
                        
                        VStack(spacing: 10) {
                            SectionHeader(title: "Para você")
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 25) {
                                    ForEach(viewModel.recomendationModel.recomendacoes, id: \.self) { recomendacao in
                                        PlaceCard(nome: recomendacao)
                                    }
                                }.padding()
                            }
                            
                            SectionHeader(title: "Categorias")
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.recomendationModel.categorias, id: \.self) { categorias in
                                        CategoryCard(categoria: categorias)
                                    }
                                }.padding()
                            }
                            
                            SectionHeader(title: "Mais Procurados")
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 25) {
                                    ForEach(viewModel.recomendationModel.maisProcurados, id: \.self) { procurados in
                                        PlaceCard(nome: procurados)
                                    }
                                }.padding()
                            }
                        }
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

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Pesquisar", text: $text)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }
}

#Preview {
    
    let viewModel = RecomendationViewModel()
    viewModel.recomendationModel.recomendacoes = ["Distrito Federal", "São Paulo", "Rio de Janeiro", "Ceara"]
    
    return RecomendationView(viewModel: viewModel)
        
}
