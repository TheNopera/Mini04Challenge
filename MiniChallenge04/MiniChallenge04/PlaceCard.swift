//
//  PlaceCard.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 15/03/24.
//

import Foundation
import SwiftUI

struct CardModifier : ViewModifier{
    var cornerRadius : CGFloat
    var title : String
    var image : Image
    func body(content: Content) -> some View {
        
    }
}


struct CardView : View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .modifier(CardModifier(cornerRadius: 25, title: "Rio de Janeiro", image: Image(systemName: "")))
        
    }
}

#Preview {
    CardView()
}
