//
//  OmboardingViewModel.swift
//  MiniChallenge04
//
//  Created by Luiz Felipe on 21/03/24.
//

import Foundation
import SwiftUI

class OmboardingViewModel:ObservableObject{
    private var formResult : [String:Int] = ["Umidade" : 0, "Temperatura" : 0, "Urbano" : 0, "Rural" : 0, "Divertido" : 0, "Calmo": 0, "Culinaria": 0, "Historico": 0, "Religioso": 0, "Radical": 0]
    
    @Published var numberOfCircle=[1,2,3]
    @Published var omboardingCount = 0
    @Published var imagesOmboardingForm:[String] = ["aa","a","s","d"]
    @Published var animation: Bool = false

    var adaptiveColuns = [GridItem(.adaptive(minimum: 120, maximum: 200))]
    
    func nextForm(){
//        switch omboardingCount {
//        case 0:
//            formResult[]
//        default:
//            <#code#>
//        }
        withAnimation {
            self.omboardingCount += 1
        }
        
        print(omboardingCount)
    }
    
    func switchColor(isCircle:Bool, num:Int) -> Color{
        withAnimation {
            if omboardingCount == (num-1){
                if isCircle{
                    return .black
                }else{
                    return .white
                }
            }else{
                if isCircle{
                    return .white
                }else{
                    return .black
                }
            }
        }
    }
    
}
