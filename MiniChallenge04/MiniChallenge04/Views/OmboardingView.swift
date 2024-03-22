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
                ForEach (omboardingViewModel.numberOfCircle, id: \.self){ numero in
                    ZStack{
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(omboardingViewModel.changeColor(color: .black))
                        Text("\(numero)")
                            .foregroundColor(omboardingViewModel.changeColor(color: .white))
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
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 320, height: 500)
                .opacity(0.7)
                .shadow(radius: 10)
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
                            
                        CustomGrid()
                        
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
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.black)
                        .frame(width: 130, height: 50).overlay {
                            HStack(alignment:.center){
                                Image(systemName: "chevron.backward")
                                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/.foregroundStyle(.white)
                            }
                        }
                }
            })
            Button(action: {
                print("test")
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.black)
                        .frame(width: 130, height: 50).overlay {
                            HStack(alignment:.center){
                                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/.foregroundStyle(.white)
                                Image(systemName: "chevron.right")
                            }

                        }
                }
            })
        }.padding()
    }
}

struct CustomGrid: View {
    @EnvironmentObject var omboardingViewModel: OmboardingViewModel

    var body: some View {
        LazyVGrid(columns: omboardingViewModel.adaptiveColuns, spacing: 0) {
            ForEach(omboardingViewModel.imagesOmboardingForm, id: \.self) { item in
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 130,height: 100)
                        .foregroundColor(.red).padding(15)
                    Text(item.debugDescription)
                }
            }
        }
    }
}

#Preview {
    OmboardingView()
}
