//
//  MapView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 20/03/24.
//

import SwiftUI
import Photos

struct MapView: View {
    
    var body: some View {
        
        
        NavigationStack{
            NavigationLink("Galeria", destination: GalleryView(titulo: "Estado", GalleryViewModel: GalleryViewModel()))
            
        }
        .padding()
    }
}

#Preview {
    MapView()
}
