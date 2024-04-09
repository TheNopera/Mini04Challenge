//
//  CategoryCard.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 21/03/24.
//

//
//  PlaceCard.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 15/03/24.
//

import Foundation
import SwiftUI

struct CategoryCard:View {
    
    let categoria:String
    
    var body: some View {
        VStack{
            Button {} label: {
                Image(systemName: "photo")
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
            }
                Text(categoria)
                    .font(.custom("Bold", size: 15))

        }
        .padding(2)
        .frame(width: 111, height: 125)
    }
}

#Preview {
    CategoryCard(categoria: "Acampamento")
}
