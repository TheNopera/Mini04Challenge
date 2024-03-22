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
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            TextField("Pesquisar", text: $text)
        }.modifier(OutlinedCardStyle(padding: 10))
    }
}
