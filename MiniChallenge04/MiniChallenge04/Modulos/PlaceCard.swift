//
//  PlaceCard.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 15/03/24.
//

import Foundation
import SwiftUI

struct PlaceCardModel{
    var image : UIImage?
    var cityName : String
    var placeName : String?
    var description : String?
    var author : String?
}

struct PlaceCard: View {
    let cityName : String
    let vm : PlacesViewModel
    @State var imgIsLoaded = false
    @State var placeCard : PlaceCardModel?
    
    var body: some View {
        VStack{
            if placeCard == nil{
                LoadingCardView()
            }
            else{
                VStack{
                    Image(uiImage: (placeCard?.image ?? UIImage(named: "Image_Load_Failed"))!)
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
            vm.places.places.removeAll()
            self.placeCard = await vm.getRandomPlace(self.cityName)
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
