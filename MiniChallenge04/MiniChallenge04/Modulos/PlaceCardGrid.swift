//
//  PlaceCardGrid.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 09/04/24.
//

import SwiftUI

struct PlaceCardGrid: View {
    let categoryName : String
    let cityName: String?
    let vm = PlacesViewModel()
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 10) {
//                ForEach(vm.placesData, id: \.self) { place in
//                    PlaceCard(cityName: cityName, place: place, vm: vm)
//                }
            }
            .padding()
        }.navigationTitle(categoryName)
            .task {
                
            }
    }
    
}

#Preview {
    PlaceCardGrid(categoryName: "Acampamento", cityName: nil)
}
