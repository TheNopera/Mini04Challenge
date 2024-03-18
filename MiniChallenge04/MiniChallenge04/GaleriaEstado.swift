//
//  GaleriaEstado.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 15/03/24.
//

import Foundation
import SwiftUI

struct GaleriaEstado:View {
    
    
    var fotos:[Image] = []
    
    var body: some View {
        VStack {
            if fotos.isEmpty {
                Text("Nenhuma Memória")
                    .bold()
            }
        }
        .navigationTitle("Distrito Federal")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    GaleriaEstado()
}
