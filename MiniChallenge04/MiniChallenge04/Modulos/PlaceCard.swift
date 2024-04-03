//
//  PlaceCard.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 15/03/24.
//

import Foundation
import SwiftUI

struct PlaceCard: View {
    let cityName : String
    let vm : PlacesViewModel
    @State var image = UIImage()
    @State var imgIsLoaded = false
    var body: some View {
        VStack{
            if !imgIsLoaded{
                LoadingCardView()
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
        }
        .task {
            if vm.places.places.isEmpty{
                updateImage()
            }
        }
        .onChange(of: vm.apiIsCallable){
            if vm.apiIsCallable{
                updateImage()
            }
        }
        
    }
    
    @MainActor
    func updateImage(){
        Task{
            if vm.apiIsCallable{
                self.imgIsLoaded = false
                vm.places.places.removeAll()
                do{
                    try await vm.getTouristicPlaces(in: cityName)
                }
                catch{
                    self.image = UIImage(named: "Image_Load_Failed")!
                }
                self.image = try await vm.getImage(imgName: vm.getRandomPlace(self.cityName))
            }
            else{
                self.image = UIImage(named: "Image_Load_Failed")!
            }
            
            self.imgIsLoaded = true
            vm.apiIsCallable = false
            
        }
    }
}

#Preview {
    PlaceCard(cityName: "Rio de Janeiro", vm: PlacesViewModel())
}

struct LoadingCardView : View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.thickMaterial)
            .overlay{
                ProgressView()
            }
            .frame(width: 155, height: 155)
    }
}
