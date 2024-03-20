//
//  GaleriaEstado.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 15/03/24.
//

import Foundation
import SwiftUI

struct GalleryView:View {
    
    var titulo:String
    var fotos:[Image] = []
    
    @StateObject var GalleryViewModel:GalleryViewModel
    
    
    var body: some View {
        VStack {
            if fotos.isEmpty {
                Text("Nenhuma Memória")
                    .bold()
            }
        }
        .navigationTitle(titulo)
        .navigationBarTitleDisplayMode(.large)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    GalleryView(titulo: "Distrito Federal", GalleryViewModel: GalleryViewModel())
}
