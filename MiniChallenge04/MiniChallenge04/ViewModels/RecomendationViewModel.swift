//
//  RecomendationViewModel.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 20/03/24.
//

import Foundation
import SwiftUI
import CoreML

class RecomendationViewModel: ObservableObject {
    @Published var recomendationModel: RecomendationModel = RecomendationModel()
    @Published var omboardingModel = OmboardingModel()
    var galleryVm  = GalleryViewModel(title: "")
    var recomendacoes:[UF:String] = [.AC : "",.AL : "", .AM : "", .AP : "", .BA : "", .CE :"", .DF:"", .ES:"", .GO :"", .MA:"", .MG:"", .MS:"", .MT:"", .PA:"", .PB:"", .PE:"", .PI:"", .PR:"", .RJ:"", .RN:"", .RO:"", .RR:"", .RS:"", .SC:"", .SE:"", .SP:"", .TO:""]
    
    init() {
        appendInModel()
        print(recomendacoes.description)
    }
    
    
    func appendInModel(){
//        if let formResultSaved = UserDefaults.standard.dictionary(forKey: "formResult") {
//            if let temperaturaResult = formResultSaved["Temperatura"] as? Int {
//                if let urbanoResult = formResultSaved["Urbano"] as? Int{
//                    if temperaturaResult != 0 && urbanoResult != 0{
//                        for (uf) in recomendacoes.keys{
//                            if galleryVm.assetsByLocation[uf.rawValue] == nil{
//                                if uf == .DF{
//                                   recomendacoes[uf]?.append("Brasilia")
//                                }else{
//                                    recomendacoes[uf]?.append(getCity(uf: uf, umidade: Int64(3), temperatura: Int64(4), urbano: Int64(2), rural: Int64(5), divertido: Int64(5), calmo: Int64(2), culinaria: Int64(5), historico: Int64(5), religioso: Int64(5), radical: Int64(5)))
//                                }
//                            }
//                        }
//                    }
//                }
//                
//            }
//        }
        for (uf) in recomendacoes.keys{
            if galleryVm.assetsByLocation[uf.rawValue] == nil{
                if uf == .DF{
                   recomendacoes[uf]?.append("Brasilia")
                }else{
                    do{
                        recomendacoes[uf]?.append(getCity(uf: uf,
                                                               umidade: Int64(omboardingModel.formResult["Umidade"]!),
                                                               temperatura: Int64(omboardingModel.formResult["Temperatura"]!),
                                                               urbano: Int64(omboardingModel.formResult["Urbano"]!),
                                                               rural: Int64(omboardingModel.formResult["Rural"]!),
                                                               divertido: Int64(omboardingModel.formResult["Divertido"]!),
                                                               calmo: Int64(omboardingModel.formResult["Calmo"]!),
                                                               culinaria: Int64(omboardingModel.formResult["Culinária"]!),
                                                               historico: Int64(omboardingModel.formResult["Histórico"]!),
                                                               religioso: Int64(omboardingModel.formResult["Religião"]!),
                                                               radical: Int64(omboardingModel.formResult["Radical"]!)))
                    }catch{
                        print("error in create recomendation")
                    }
                }
            }
        }
        
    }
    
    
    func getCity(uf:UF, umidade:Int64, temperatura:Int64, urbano:Int64, rural:Int64, divertido:Int64, calmo:Int64, culinaria:Int64, historico:Int64, religioso:Int64, radical:Int64) -> String{
        do{
            let config = MLModelConfiguration()
            let model = try RecomenderCity(configuration: config)
            
            let prediction = try model.prediction(UF: uf.rawValue, Umidade: umidade, Temperatura: temperatura, Urbano: urbano, Rural: rural, Divertido: divertido, Calmo: calmo, Culinaria: culinaria, Historico: historico, Religioso: religioso, Radical: radical)
            return prediction.Name
        }catch{
            print("erro in get localization UF")
        }
        return ""
    }
    
    func getStates(quant : Int?) -> [String]{
        var arr : [String] = []
        
        if let quantity = quant {
            // If quant is not nil, return only the first `quant` elements
            let values = Array(recomendacoes.values)
            let endIndex = min(quantity, values.count)
            arr = values.prefix(endIndex).compactMap { String($0) }
        } else {
            // If quant is nil, include all values
            arr = Array(recomendacoes.values).compactMap { String($0) }
        }
        
        return arr
    }
    
    
}
