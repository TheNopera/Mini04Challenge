//
//  OmboardingModel.swift
//  MiniChallenge04
//
//  Created by Luiz Felipe on 04/04/24.
//

import Foundation
import SwiftUI
class OmboardingModel{
    let textOmboarding:[String] = ["Qual tipo de clima mais te agrada em uma viagem?","Qual tipo de local você mais gosta?","Quais desses tópicos não podem faltar em uma viajem para você?"]
    let buttonsImages:[String] = []
    @State var formResult : [String:Int?] = ["Umidade" : nil, "Temperatura" : nil, "Urbano" : 0, "Rural" : 0, "Divertido" : 0, "Calmo": 0, "Culinaria": 0, "Historico": 0, "Religioso": 0, "Radical": 0]
    

}
