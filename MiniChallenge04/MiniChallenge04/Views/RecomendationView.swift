//
//  RecomendationView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 19/03/24.
//

import SwiftUI

struct RecomendationView: View {
    @ObservedObject var viewModel: RecomendationViewModel
    
    var body: some View {
        
        NavigationStack
        {
            
            HStack{
                Text("Para você!")
                    .font(.title)
                    .bold()
                Spacer()
                
                NavigationLink {} label: {
                    HStack {
                        Text("Mostrar Mais")
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 4, height: 9)
                    }
                    .font(.caption)
                    .bold()
                    .tint(.gray)
                }
            }
        
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(viewModel.recomendationModel.recomendacoes, id: \.self) { recomendacao in
                        PlaceCard(nome: recomendacao)
                            .padding(5)
                    }
                }
            }
        }.padding()
    }
}


#Preview {
    
    let viewModel = RecomendationViewModel()
    viewModel.recomendationModel.recomendacoes = ["Distrito Federal", "São Paulo", "Rio de Janeiro", "Ceara"]
    
    return RecomendationView(viewModel: viewModel)
        
}
