//
//  ContentView.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 13/03/24.
//

import SwiftUI
import Photos

struct ContentView: View {
    

    
    
    
    var body: some View {
        
        
        
        NavigationStack{
            NavigationLink {GaleriaEstado(fotos: [])} label: {
                Text("Estado")
                
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
