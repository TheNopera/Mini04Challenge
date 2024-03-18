//
//  ContentView.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 13/03/24.
//

import SwiftUI
import Photos

struct ContentView: View {
    
    @StateObject var api = APIManager()
    
    
    
    var body: some View {
        
        
        VStack{
            NavigationStack{
                NavigationLink {GaleriaEstado(titulo: "Distrito Federal")} label: {
                    Text("Estado")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
