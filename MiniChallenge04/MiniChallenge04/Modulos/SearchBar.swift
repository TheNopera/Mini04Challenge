//
//  SearchBar.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 21/03/24.
//

import Foundation
import SwiftUI

struct OutlinedCardStyle : ViewModifier {
    var padding : CGFloat
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .cornerRadius(15)
            .foregroundColor(.black)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.08), radius: 5,y: 5)
            )
            
    }
}

struct SearchBar: View {
    @Binding var text: String
    @StateObject var vm = PlacesViewModel()
    @State private var isNavigationActive = false
    @State var place : PlaceCardModel?
    var body: some View {
        
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                    TextField("Pesquisar", text: $text)
                        .onSubmit {
                            
                            Task{
                                vm.apiIsCallable = true
                                vm.placesData.removeAll()
                                self.place = await vm.getRandomPlace(self.text)
                                isNavigationActive = true
                                vm.apiIsCallable = false
                                    
                            }
                        }
                }.modifier(OutlinedCardStyle(padding: 10))
                    
                // Use NavigationLink to navigate to another view
                NavigationLink(destination: PlaceDetailView(place: place), isActive: $isNavigationActive) {
                    
                }
                .hidden()
            }
        
    }
}
