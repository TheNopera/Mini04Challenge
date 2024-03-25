//
//  ContentView.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 13/03/24.
//

import SwiftUI
import Photos

struct ContentView: View {
    

    @State var search : String = ""
    @StateObject var vm : PlacesViewModel = PlacesViewModel()
    @State var img : UIImage = UIImage()
    @State var imgIsLoaded = false
    var body: some View {
        VStack{
            if !imgIsLoaded{
                ProgressView()
                    .frame(width: 200,height: 200)
            } else{
                Image(uiImage: img)
            }
            TextField(text: $search) {
                Text("Pesquise uma cidade")
            }
            .textFieldStyle(.roundedBorder)
            Button {
                Task{
                    try await vm.getPlaces(in: search)
                    self.img = try await vm.getImageUrl(imgName: vm.places.places.first!.photos.first!.name)
                    
                    self.imgIsLoaded = true
                }
            } label: {
                Text("Pesquisar")
            }.buttonStyle(.bordered).tint(.accentColor)

                
        }
        .padding()

    }
}

#Preview {
    ContentView()
}