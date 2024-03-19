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
    @State var isShowingAdditionalContent = false
    
    
    var body: some View {
        
        
        NavigationStack{
            NavigationLink("Galeria", destination: GaleriaView(titulo: "Estado"))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
