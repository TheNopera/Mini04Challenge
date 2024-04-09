//
//  Section.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 21/03/24.
//

import SwiftUI

struct SectionComponent: View {
    var sectionName : String
    var linkText : String?
    var body: some View {
        HStack(alignment: .bottom){
            Text(sectionName)
                .font(.system(size: 24,weight: .heavy))
                .bold()
            Spacer()
            Button(action: {
                
            }, label: {
                Text(linkText ?? "")
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
                    .fontWeight(.heavy)
                if linkText != nil{
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
            })
        }.padding([.horizontal,.top], 20)
    }
}


#Preview {
    SectionComponent(sectionName: "Rio de Janeiro", linkText: "Mostrar Mais")
}
