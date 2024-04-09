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
    
    @Published var imagesOmboardingForm:[[String:Int]] = [["Chuvoso":2,"Quente":4,"Úmido":3,"Frio":1],
                                                          ["Urbano":5,"Rural":5],
                                                          ["Divertido":5,"Calmo":5,"Culinária":5,"Histórico":5,"Religião":5,"Radical":5]]
    @Published var numberOfCircle=[1,2,3]
    @Published var disabledButtons: [String] = []
    @Published var contLimitButtons: Int = 0
    @Published var omboardingCount = 0
    @Published var formReponseIndetifier : Bool = false
    
    func formAdd(value: Int, item:String){
        switch omboardingCount {
        case 0:
            omboardingModel.formResult.updateValue(value, forKey: "Temperatura")
        case 1:
            omboardingModel.formResult.updateValue(value, forKey: item)
        case 2:
            omboardingModel.formResult.updateValue(value, forKey: item)
        default:
            print("error in form")
        }
    }
    func nextForm(){
        withAnimation {
            self.omboardingCount += 1
            self.contLimitButtons = 0
        }
        
        if omboardingCount == 3{
            UserDefaults.standard.set(omboardingModel.formResult, forKey: "formResult")
            formReponseIndetifier = true
        }
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
        UserDefaults.standard.set(omboardingModel.formResult, forKey: "formResult")
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
