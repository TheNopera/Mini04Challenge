//
//  MapView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 20/03/24.
//
import SwiftUI

extension String: Identifiable {
    public var id: String { self }
}

struct MapView: View {
    // Array de siglas das UFs do Brasil
    @StateObject var mapViewModel = MapViewModel()

    @State private var selectedUF: String?

    var body: some View {
        NavigationStack{
            VStack {
                // Criando uma LazyVGrid para organizar os botões em uma grade vertical
                LazyVGrid(columns: [
                                GridItem(.flexible(minimum: 50)),
                                GridItem(.flexible(minimum: 50)),
                                GridItem(.flexible(minimum: 50))
                ], spacing: 10) {
                    ForEach(mapViewModel.ufs, id: \.self) { uf in
                        NavigationLink(destination: GalleryView()) {
                        
                            // Label do botão contendo a sigla da UF
                            Text(uf)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }.onTapGesture {
                            GalleryViewModel().title = uf
                        }
                        
                    }
                }
                .padding()
            }
        }
    }
}


#Preview {
    MapView()
}
