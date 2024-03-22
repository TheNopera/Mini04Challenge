//
//  RoundCard.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 22/03/24.
//

import SwiftUI

struct RoundCard: View {
    var category : String
    var body: some View {
        VStack{
            Image(category)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
                .clipShape(Circle())
            Text(category)
                .font(.system(size: 15,weight: .heavy))
        }
    }
}

#Preview {
    RoundCard(category: "Acampamento")
}
