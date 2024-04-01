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
    
    init() {
        appendInModel()
        print(recomendationModel.recomendacoes.description)
    }
    
    func appendInModel(){
        recomendationModel.recomendacoes["MG"]?.append(getCity(uf: "GO", umidade: Int64(3), temperatura: Int64(2), urbano: Int64(3), rural: Int64(2), divertido: Int64(5), calmo: Int64(2), culinaria: Int64(5), historico: Int64(3), religioso: Int64(2), radical: Int64(4)))
    }
    
    func getCity(uf:String, umidade:Int64, temperatura:Int64, urbano:Int64, rural:Int64, divertido:Int64, calmo:Int64, culinaria:Int64, historico:Int64, religioso:Int64, radical:Int64) -> String{
        do{
            let config = MLModelConfiguration()
            let model = try RecommenderCity(configuration: config)
            
            let prediction = try model.prediction(UF: uf, Umidade: umidade, Temperatura: temperatura, Urbano: urbano, Rural: rural, Divertido: divertido, Calmo: calmo, Culinaria: culinaria, Historico: historico, Religioso: religioso, Radical: radical)
            //print(prediction.NameProbability.debugDescription)
            return prediction.Name
        }catch{
            print("erro in get localization UF")
        }
        return ""
    }
    
}
