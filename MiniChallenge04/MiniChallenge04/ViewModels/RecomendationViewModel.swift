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
    //var galeryModel = GaleryModel()
    init() {
       // appendInModel()
        print(recomendationModel.recomendacoes.description)
    }
    

    func appendInModel(){
        for (uf) in recomendationModel.recomendacoes.keys{
            if uf == .DF{
                recomendationModel.recomendacoes[uf]?.append("Brasilia")
            }else{
                recomendationModel.recomendacoes[uf]?.append(getCity(uf: uf, umidade: Int64(3), temperatura: Int64(4), urbano: Int64(2), rural: Int64(5), divertido: Int64(5), calmo: Int64(2), culinaria: Int64(5), historico: Int64(5), religioso: Int64(5), radical: Int64(5)))
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
    
}
