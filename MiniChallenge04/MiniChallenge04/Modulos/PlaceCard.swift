//
//  PlaceCard.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 15/03/24.
//

import Foundation
import SwiftUI

struct PlaceCard:View {
    let cityName : String
    let vm = PlacesViewModel()
    @State var image = UIImage()
    @State var imgIsLoaded = false
    var apiIsCallable = false
    var body: some View {
        VStack{
            if !imgIsLoaded{
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.thickMaterial)
                    .overlay{
                        ProgressView()
                    }
                    .frame(width: 155, height: 155)
                
            }
            else{
                VStack{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 155, height: 155)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    HStack{
                        Image("pin")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(cityName)
                            .bold()
                        Spacer()
                    }
                }.frame(width: 155)
            }
        }.task {
            Task{
                if apiIsCallable{
                    try await vm.getTouristicPlaces(in: cityName)
                    self.image = try await vm.getImage(imgName: vm.getRandomPlace().photos.first!.name)
                }
                else{
                    self.image = UIImage(named: "Image_Load_Failed")!
                }
                
                self.imgIsLoaded = true
            }
        }
    }
}

#Preview {
    PlaceCard(cityName: "Rio de Janeiro")
}
