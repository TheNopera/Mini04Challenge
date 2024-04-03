//
//  PLaceDetailView.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 02/04/24.
//

import Foundation
import SwiftUI

struct PlaceDetailView : View {
    var img : Image
    var title : String
    var description : String
    var autor : String
    var body: some View {
        VStack{
            Spacer()
            VisualEffectView(effect: UIBlurEffect(style: .dark))
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.4 )
                .cornerRadius(35)
                .opacity(0.9)
                .background(
                    RoundedRectangle(cornerRadius: 35)
                        .opacity(0.3)
                    
                )
                .overlay {
                    HStack{
                        VStack{
                            CardTitle(text: title)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundStyle(.white)
                            LocationInfo()
                            CardTitle(text: "Sobre")
                                
                            Text(description)
                                .foregroundStyle(.white)
                            Spacer()
                        }.padding(.top)
                        Spacer()
                    }
                    .padding()
                }
            HStack{
                Text("Foto por: "+autor)
                Spacer()
            }.foregroundStyle(.white)
            
        }
        .padding([.horizontal,.bottom], 30)
        .background(
            img
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        
        
    }
    
}

#Preview {
    PlaceDetailView(img: Image("Cristo"),title: "Cristo Redentor- RJ",description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor.",autor: "Arthur Liberal")
}


struct CardTitle : View {
    var text : String
    var body: some View {
        HStack{
            Text(text)
                .bold()
                .foregroundStyle(.white)
                .font(.title2)
            Spacer()
        }
    }
}

struct LocationInfo : View {
    var body: some View {
        HStack{
            Image(systemName: "thermometer.medium")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("32Cº")
               
            Spacer()
            Image(systemName: "airplane")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("7.000Km")
        }.foregroundStyle(.white)
            .padding(.vertical)
            .font(.title3)
            .bold()
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

