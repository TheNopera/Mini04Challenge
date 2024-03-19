//
//  GaleriaEstado.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 15/03/24.
//

import Foundation
import SwiftUI

struct GaleriaView:View {
    
    
    var titulo:String
    var fotos:[Image] = []
    
    init(titulo: String) {
        self.titulo = titulo
        self.fotos = []
    }
    
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
    GaleriaView(titulo: "Distrito Federal")
}
