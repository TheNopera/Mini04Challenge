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
    var width : CGFloat = 130
    var height : CGFloat = 210
    func body(content: Content) -> some View {
        content
            .overlay(
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            )
            .overlay(
                VStack{
                    Text(title)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(5)
                    Spacer()
                }
                
            )
            .frame(width: width,height: height)
    }
}


struct CardView : View {
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 25)
                .modifier(CardModifier(cornerRadius: 25, title: "Rio de Janeiro", image: Image("Cristo")))
        }
    }
}

#Preview {
    CardView()
}
