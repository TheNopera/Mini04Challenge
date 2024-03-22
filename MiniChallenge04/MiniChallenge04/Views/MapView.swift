//
//  MapView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 20/03/24.
//

import SwiftUI
import Photos

struct MapView: View {
    
    let ufs = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"]
    
    var body: some View {
        
        
        NavigationStack{
            NavigationLink("Galeria", destination: GalleryView(titulo: "Estado"))
            
        }
        .padding()
    }
}

#Preview {
    MapView()
}
