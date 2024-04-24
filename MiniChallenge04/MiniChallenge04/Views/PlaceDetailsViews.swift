//
//  PLaceDetailView.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 02/04/24.
//

import Foundation
import SwiftUI
import WeatherKit

struct PlaceDetailView : View {
    var place : PlaceCardModel?
    var btn = BackBtn()
    var body: some View {
        VStack{
            Spacer()
            VisualEffectView(effect: UIBlurEffect(style: .dark))
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3 )
                .cornerRadius(35)
                .opacity(0.9)
            
                .overlay {
                    HStack{
                        VStack{
                            CardTitle(text: "\(place?.placeName ?? "")")
                            Rectangle()
                                .frame(height: 1)
                                .foregroundStyle(.white)
                            LocationInfo(place: place?.cityName ?? "")
                           
                            HStack{
                                Link(destination: googleSearchURL(searchText: place?.cityName ?? ""), label: {
                                               Text("Search on Google")
                                        .buttonStyle(.bordered)
                                           })
                                Spacer()
                                Image(systemName: "applelogo")
                                    .resizable()
                                    .frame(width: 17, height: 20)
                                    .foregroundColor(.white)
                                Text("Weather")
                                    .foregroundColor(.white)
                            }
                          
                        }.padding(.top)
                        Spacer()
            
                    }
                    .padding()
                }
            HStack{
                Text("Foto por:" + (place?.author ?? "Autor desconhecido") )
                Spacer()
            }.foregroundStyle(.white)
            
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .padding([.horizontal,.bottom], 30)
        .background(
            Image(uiImage: (place?.image ?? UIImage(named: "Image_Load_Failed"))! )
                .resizable()
                .scaledToFill()
                .frame(height: UIScreen.main.bounds.height)
                .ignoresSafeArea(.container, edges: .top)
        )
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                btn
            }
        })
        
    }
    
    private func googleSearchURL(searchText: String) -> URL {
         if let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "https://www.google.com/search?q=\(encodedText)") {
             return url
         } else {
             return URL(string: "https://www.google.com")!
         }
     }
}

struct BackBtn : View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "chevron.backward.circle.fill")
                .font(.system(size: 30))
                .foregroundStyle(.regularMaterial)
                
        })
    }
}

#Preview{
    BackBtn()
}
#Preview {
    PlaceDetailView(place: PlaceCardModel(image: UIImage(named: "Cristo")!, cityName: "Rio de Janeiro", placeName: "Cristo redentor", description:"Estatua de cristo localiczado no rio de janeiro dawdadadadwadadawdawdawdawdawdawdawdawdawdadwadadadawdadada", author: "Arthur Liberal"))
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
        } .task {
            Task{
                
            }
        }
    }
}

struct LocationInfo : View {
   @StateObject var vm : PlaceDetailVM = PlaceDetailVM()
    var place : String
    
    @State var temp : String?
    
    var body: some View {
        HStack{
            Text(place)
            Spacer()
            Image(systemName: "thermometer.medium")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            if(vm.tempIsLoading || temp == nil){
                ProgressView()
                    .preferredColorScheme(.dark)
                    .padding(.leading)
            }else{
                Text(temp!)
                    .padding(.trailing)
            }
            
        }.foregroundStyle(.white)
            .padding(.vertical)
            .font(.title3)
            .bold()
            .task {
                Task{
                    self.temp = await vm.getTemperature(for: self.place)
                  
                }
            }
    }
}



struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

