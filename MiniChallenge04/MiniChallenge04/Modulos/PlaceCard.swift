//
//  PlaceCard.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 15/03/24.
//

import Foundation
import SwiftUI

struct PlaceCard:View {
    
    let nome:String
    
    var body: some View {
        VStack{
            Button {} label: {
                Image(systemName: "photo")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(width: 155, height: 155)
            }
            HStack{
                Image("pin")
                    .resizable()
                    .frame(width: 14, height: 16.9)
                Text(nome)
                    .font(.custom("Bold", size: 15))
                    
                Spacer()
            }
        }
        .padding(2)
        .frame(width: 155, height: 180)
    }
}

#Preview {
    PlaceCard(nome: "Rio de Janeiro")
}
