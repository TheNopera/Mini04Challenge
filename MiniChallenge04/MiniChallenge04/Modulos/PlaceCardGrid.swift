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
    @StateObject var vm = PlacesViewModel()
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 10) {
                ForEach(vm.categoryPlaces, id:\.self){ place in
                    PlaceCard(cityName: place.cityName,vm: self.vm, placeCard: place)
                }
                .padding()
            }.navigationTitle(categoryName)
            
        }
        .task {
            Task{
               await self.vm.getCategoryPlaces(for:categoryName)
            }
        }
    }
}
#Preview {
    PlaceCardGrid(categoryName: "Acampamento", cityName: nil)
}
