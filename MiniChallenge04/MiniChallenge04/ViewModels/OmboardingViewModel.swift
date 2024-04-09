//
//  OmboardingViewModel.swift
//  MiniChallenge04
//
//  Created by Luiz Felipe on 21/03/24.
//

import Foundation
import SwiftUI

class OmboardingViewModel:ObservableObject{
    
    var omboardingModel = OmboardingModel()
    
    @Published var imagesOmboardingForm:[[String:Int]] = [["Alice":1,"Bob":2,"Carlos":3,"Denise":4], ["Gustavo":1,"Helena":2], ["Marcelo":1,"Natália":2,"Otávio":3,"Paula":4,"Rafael":5,"Sandra":6]]
    @Published var numberOfCircle=[1,2,3]
    @Published var disabledButtons: [String] = []
    @Published var contLimitButtons: Int = 0
    @Published var omboardingCount = 0
    @Published var formReponseIndetifier : Bool = false
    

    func nextForm(){
        withAnimation {
            self.omboardingCount += 1
            self.contLimitButtons = 0
        }
        
        switch omboardingCount {
        case 1:
            omboardingModel.formResult["Temperatura"] = 0
            omboardingModel.formResult["Umidade"] = 0
        case 2:
            omboardingModel.formResult["Urbano"] = 0
            omboardingModel.formResult["Rural"] = 0
        case 3:
            omboardingModel.formResult["Divertido"] = 0
            omboardingModel.formResult["Calmo"] = 0
            omboardingModel.formResult["Culinaria"] = 0
            omboardingModel.formResult["Historico"] = 0
            omboardingModel.formResult["Religioso"] = 0
            omboardingModel.formResult["Radical"] = 0
            formReponseIndetifier = true
            
            UserDefaults.standard.set(omboardingModel.formResult, forKey: "formResult")
        default:
            print("error in form")
        }
        
        print(omboardingCount)
        print(formReponseIndetifier)
    }
    func backForm(){
        withAnimation {
            self.omboardingCount -= 1
            self.contLimitButtons = 0
            
        }
        
        switch omboardingCount {
        case 0:
            omboardingModel.formResult["Umidade"] = 0
            omboardingModel.formResult["Temperatura"] = 0
            for imagems in self.imagesOmboardingForm[0]{
                if disabledButtons.contains(imagems.key){
                    disabledButtons.removeAll(where:{$0 == imagems.key})
                }
            }
            
            
        case 1:
            omboardingModel.formResult["Urbano"] = 0
            omboardingModel.formResult["Rural"] = 0
            for imagems in self.imagesOmboardingForm[1]{
                if disabledButtons.contains(imagems.key){
                    disabledButtons.removeAll(where:{$0 == imagems.key})
                }
            }
        default:
            print("error in form")
        }
        
        print(omboardingCount)
    }
    
    func disableButton(value: String) {
            // Define o botão como desabilitado após ser clicado
        disabledButtons.append(value)
        }
        
        func isButtonDisabled(value: String) -> Bool {
            if self.omboardingCount != 2{
                if contLimitButtons == 1{
                    return true
                }
            }
            return disabledButtons.contains(value)
        }
    
    func switchColor(isCircle:Bool, num:Int) -> Color{
        withAnimation {
            if omboardingCount == (num-1){
                if isCircle{
                    return .blueSystem
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
