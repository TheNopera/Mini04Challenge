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
        NavigationStack{
            VStack{
                if omboardingViewModel.animation{
                    OmboardingQuestionsTop()
                    OmboardingQuestionsMiddle()
                    OmboardingQuestionsBottom()
                }else{
                    OmboardingSlider()
                }
                
                
            }.environmentObject(omboardingViewModel)
        }
    }
}
struct OmboardingSlider:View {
    @EnvironmentObject var omboardingViewModel: OmboardingViewModel
    var body: some View {
        VStack(spacing:10){
            Text("Explore Suas Melhores Memórias").multilineTextAlignment(.center).font(.title).foregroundStyle(.black)
            Text("Vamos viajar no tempo?").foregroundStyle(.black)
            Spacer()
            
            Image(systemName: "airplane").font(.system(size: 50))
                .padding()
                .offset(x: omboardingViewModel.animation ? 250 : 0)
        }.task{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                withAnimation {
                    omboardingViewModel.animation = true
                }
            }
        }
    }
}
struct OmboardingSlider:View {
    //@EnvironmentObject var omboardingViewModel: OmboardingViewModel

    var body: some View {
        VStack{
            Text("Explore Suas Melhores Memórias").font(.title)
            Text("Vamos viajar no tempo?")
            Spacer()
            
            
        }
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
                            .foregroundStyle(.black)
                            .bold()
                            .padding(10)
                        Spacer()
                    }
                    Text("Quais tipos de clima mais te interessa em uma viagem?")
                        .font(.callout)
                        .foregroundStyle(.black)
                        .bold()
                        .padding(10)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                    customGrid
                    
                }
            }
    }
    
    private var rectangleComponent : some View{
        ZStack{
            //            Image("CardOmboarding").clipShape(RoundedRectangle(cornerRadius: 20))
            //                .frame(width: 300, height: 500)
            //                .opacity(0.2)
            //                .shadow(radius: 10)
            //                .offset(y:20)
            //            RoundedRectangle(cornerRadius: 20)
            //                .frame(width: 310, height: 500)
            //                .opacity(0.4)
            //                .shadow(radius: 10)
            //                .offset(y:10)
            Image("CardOmboarding")
                .resizable()
            //.clipShape(RoundedRectangle(cornerRadius: 20))
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
            if omboardingViewModel.omboardingCount>1{
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
                })
                NavigationLink {
                    MainView()
                } label: {
                    buttonComponent.overlay {
                        HStack(alignment:.center){
                            Text("Próximo")
                                .foregroundStyle(.white)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.white)
                        }
                        
                    }
                }

            }else{
                Button(action: {
                    print("test")
                }, label: {
                    
                        buttonComponent.overlay {
                            HStack(alignment:.center){
                                Image(systemName: "chevron.backward")
                                    .foregroundStyle(.white)
                                Text("Voltar")
                                    .foregroundStyle(.white)
                            }
                        }
                    
                }).disabled(omboardingViewModel.omboardingCount != 0 ? false : true)
                    .opacity(omboardingViewModel.omboardingCount != 0 ? 1 : 0)
                Button(action: {
                    omboardingViewModel.nextForm()
                }, label: {
                    
                        buttonComponent.overlay {
                            HStack(alignment:.center){
                                Text("Próximo")
                                    .foregroundStyle(.white)
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.white)
                            }
                            
                        }
                    
                })
            }
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
