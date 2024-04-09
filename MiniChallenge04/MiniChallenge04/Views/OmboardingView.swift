//
//  OmboardingView.swift
//  MiniChallenge04
//
//  Created by Luiz Felipe on 21/03/24.
//

import SwiftUI



struct OmboardingView: View {
    
    @StateObject var omboardingViewModel = OmboardingViewModel()
    @Binding var formReponseIndetifier:Bool
    var body: some View {
        NavigationStack{
            VStack{
           
                OmboardingQuestionsTop()
                OmboardingQuestionsMiddle()
                OmboardingQuestionsBottom(formReponseIndetifier: $formReponseIndetifier)

            }.environmentObject(omboardingViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image("FormBackground")
                        .resizable()
                        .scaledToFill()
                )
                .edgesIgnoringSafeArea(.all)
        }
    }
}


struct OmboardingSlider:View {
    @Binding var animation:Bool
    @State var viewState = CGSize.zero
    @StateObject var omboardingViewModel = OmboardingViewModel()
    var body: some View {
        VStack(spacing:10){
            Text("Explore Suas Melhores Memórias").multilineTextAlignment(.center).font(.title).foregroundStyle(.white)
            Text("Vamos viajar no tempo?").foregroundStyle(.white)
            Spacer()
            Capsule()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.clear]), startPoint: .leading, endPoint: .trailing))
                .frame(minWidth: 100, maxWidth: 200, minHeight: 50, maxHeight: 100)
                .opacity(0.6)
                .overlay{
                HStack{
                    ZStack{
                        Circle().frame(minWidth: 30, maxWidth: 90).foregroundStyle(.white)
                        Image(systemName: "airplane").font(.system(size: 40)).foregroundStyle(.black)
                    }.padding(5)
                        .offset(x: viewState.width)
                        .gesture(
                        DragGesture()
                            .onChanged({ value in
                                if value.translation.width <= 100 && value.translation.width >= 0{
                                    withAnimation {
                                            viewState = value.translation
                                    }
                                    if value.translation.width > 95{
                                        withAnimation {
                                            animation = true
                                        }
                                    }
                                }
                        })
                            .onEnded({ value in
                                withAnimation {
                                    animation = true
                                }
                            })
                    )
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                        .fontWeight(.light)
                        .opacity(viewState.width > 50 ? 0:1)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                        .fontWeight(.light)
                        .opacity(viewState.width > 50 ? 0:0.6)
                    Spacer()
                    
                }
            }
        }.padding(50)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("OmboardingBackground")
                    .resizable()
                    .scaledToFill()
            )
            .edgesIgnoringSafeArea(.all)
        
    }
}
struct OmboardingQuestionsTop:View {
    @EnvironmentObject var omboardingViewModel: OmboardingViewModel
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 300, height: 2)
                .foregroundStyle(.blueSystem)
            HStack(spacing:80){
                ForEach (omboardingViewModel.numberOfCircle, id: \.self){ num in
                    ZStack{
                        if omboardingViewModel.omboardingCount >= num{
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(withAnimation(.bouncy){
                                    .blueSystem
                                })
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                                .bold()
                        }else{
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(withAnimation(.bouncy){
                                    omboardingViewModel.switchColor(isCircle: true, num: num)
                                })
                            Text("\(num)")
                                .foregroundColor(omboardingViewModel.switchColor(isCircle: false, num: num))
                                .font(.title)
                        }
                        
                    }
                }
            }
        }
    }
    
    
}
struct OmboardingQuestionsMiddle:View {
    @EnvironmentObject var omboardingViewModel: OmboardingViewModel
    @State var adaptiveColuns: [GridItem] = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
    var body: some View {
        rectangleComponent
            .overlay {
                GeometryReader(content: { geometry in
                    VStack(){
                        Text(omboardingViewModel.omboardingModel.textOmboarding[omboardingViewModel.omboardingCount < 3 ? omboardingViewModel.omboardingCount : 2])
                            .font(.system(size: 18))
                            .foregroundStyle(.black)
                            .bold()
                            .padding()
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                        LazyVGrid(columns: adaptiveColuns, spacing: 0) {
                            ForEach(omboardingViewModel.imagesOmboardingForm[omboardingViewModel.omboardingCount < 3 ? omboardingViewModel.omboardingCount : 2].sorted(by: { $0.key < $1.key }), id: \.key){ item, value in
                                
                                Button(action: {
                                    omboardingViewModel.formAdd(value: value, item: item)
                                    omboardingViewModel.disableButton(value: item)
                                    print(omboardingViewModel.disabledButtons)
                                    omboardingViewModel.contLimitButtons += 1
                                }, label: {
                                    
                                    VStack(spacing:0) {
                                        
                                        Image(item)
                                            .resizable()
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .frame(minWidth: 80, maxWidth: 120, minHeight: geometry.size.height*0.14, maxHeight: geometry.size.height*0.15)
                                            .padding(10)
                                            
                                        Text(item)
                                            .padding(-5)
                                            .font(.system(size: 12))
                                            .foregroundStyle(.black)
                                    }.padding(5).opacity(omboardingViewModel.isButtonDisabled(value: item) ? 0.5 : 1.0)
                                }).disabled(omboardingViewModel.isButtonDisabled(value: item))
                                
                            }
                        }
                        Spacer()
                    }
                })
            }
    }
    
    private var rectangleComponent : some View{
        ZStack{
            Image("CardOmboarding")
                .resizable()
                .frame(width: 330, height: 570)
                .foregroundStyle(.black)
                .shadow(radius: 10)
        }
    }
}

struct OmboardingQuestionsBottom:View {
    @EnvironmentObject var omboardingViewModel: OmboardingViewModel
    @State var isButtonClick: Bool = false
    @Binding var formReponseIndetifier:Bool
    var body: some View {
        HStack(spacing:50){
            Button(action: {
                omboardingViewModel.backForm()
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
                if (omboardingViewModel.contLimitButtons < 1){
                        isButtonClick = true
                }else{
                    isButtonClick =  false
                    omboardingViewModel.nextForm()
                    if omboardingViewModel.formReponseIndetifier == true{
                        self.formReponseIndetifier =  true
                        UserDefaults.standard.set(self.formReponseIndetifier, forKey: "formReponseIndetifier")
                    }
                }

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
            .alert(isPresented: $isButtonClick) {
                Alert(title: Text("Selecione ao menos uma opção"), dismissButton: .cancel(Text("OK")))
            }
        }.padding()
    }
    
    private var buttonComponent: some View{
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.blueSystem)
            .frame(width: 130, height: 50)
            .shadow(radius: 10)
    }
}



#Preview {
    OmboardingSlider(animation: .constant(true))
}
