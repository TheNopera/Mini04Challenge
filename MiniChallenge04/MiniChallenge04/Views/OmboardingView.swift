//
//  OmboardingView.swift
//  MiniChallenge04
//
//  Created by Luiz Felipe on 21/03/24.
//

import SwiftUI

struct OmboardingView: View {
    
    @StateObject var omboardingViewModel = OmboardingViewModel()
    var body: some View {
        VStack{
            OmboardingQuestionsTop()
            OmboardingQuestionsMiddle()
            OmboardingQuestionsBottom()
        }.environmentObject(omboardingViewModel)
    }
}

struct OmboardingQuestionsTop:View {
    @EnvironmentObject var omboardingViewModel: OmboardingViewModel
    
    var body: some View {
        ZStack{
            Rectangle().frame(width: 300, height: 2)
            HStack(spacing:80){
                ForEach (omboardingViewModel.numberOfCircle, id: \.self){ num in
                    ZStack{
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(withAnimation(.bouncy){
                                omboardingViewModel.switchColor(isCircle: true, num: num)
                            })
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                        Text("\(num)")
                            .foregroundColor(omboardingViewModel.switchColor(isCircle: false, num: num))
                            .font(.title)
                    }
                }
            }
        }
    }
}
struct OmboardingQuestionsMiddle:View {
    @EnvironmentObject var omboardingViewModel: OmboardingViewModel
    private var girdIte = [GridItem(.adaptive(minimum: 120, maximum: 200))]
    var body: some View {
        rectangleComponent
            .overlay {
                VStack(){
                    HStack{
                        Text("Texto")
                            .font(.callout)
                            .foregroundStyle(.white)
                            .bold()
                            .padding(10)
                        Spacer()
                    }
                    Text("Quais tipos de clima mais te interessa em uma viagem?")
                        .font(.callout)
                        .foregroundStyle(.white)
                        .bold()
                        .padding(10)
                        .multilineTextAlignment(.leading)
                    
                    customGrid
                    
                }
            }
    }
    
    private var rectangleComponent : some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .opacity(0.2)
                .shadow(radius: 10)
                .offset(y:20)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 310, height: 500)
                .opacity(0.4)
                .shadow(radius: 10)
                .offset(y:10)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 320, height: 500)
                .foregroundStyle(.black)
                .shadow(radius: 10)
        }
    }
    
    private var customGrid: some View {
        LazyVGrid(columns: omboardingViewModel.adaptiveColuns, spacing: 0) {
            ForEach(omboardingViewModel.imagesOmboardingForm, id: \.self) { item in
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 130,height: 100)
                        .foregroundColor(.red).padding(15)
                        .shadow(color: .gray,radius: 10)
                    Text(item.debugDescription)
                }
            }
        }
    }
}

struct OmboardingQuestionsBottom:View {
    @EnvironmentObject var omboardingViewModel: OmboardingViewModel
    var body: some View {
        HStack(spacing:50){
            Button(action: {
                print("test")
            }, label: {
                ZStack{
                    buttonComponent.overlay {
                        HStack(alignment:.center){
                            Image(systemName: "chevron.backward")
                                .foregroundStyle(.white)
                            Text("Voltar")
                                .foregroundStyle(.white)
                        }
                    }
                }
            }).disabled(omboardingViewModel.omboardingCount != 0 ? false : true)
                .opacity(omboardingViewModel.omboardingCount != 0 ? 1 : 0)
            Button(action: {
                omboardingViewModel.nextForm()
            }, label: {
                ZStack{
                    buttonComponent.overlay {
                        HStack(alignment:.center){
                            Text("Próximo")
                                .foregroundStyle(.white)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.white)
                        }
                        
                    }
                }
            })
        }.padding()
    }
    
    private var buttonComponent: some View{
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.black)
            .frame(width: 130, height: 50)
            .shadow(radius: 10)
    }
}



#Preview {
    OmboardingView()
}
