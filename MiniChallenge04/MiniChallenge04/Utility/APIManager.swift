//
//  APIManager.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 13/03/24.
//

import Foundation
import Alamofire

class APIManager : ObservableObject{
    var ENV : APIKeyable {
        return ProdENV()
    }
    
    var API_BASE_URL = "https://places.googleapis.com/v1/"
    
    
    //MARK: FUNÇÃO PARA RETORNAR PONTOS TURISTICOS EM CIDADE ESPECIFICA
    func getTouristAttractions(city : String) async throws -> PlacesResponse? {
        //O body do request
        let parameters : [String:Any] = [
            "textQuery" : "Pontos turisticos \(city)",
            "languageCode" : "pt-br"
        ]
        
        //Configuração do header do request
        let headers : HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Goog-Api-Key": ENV.SERVICE_API_KEY,
            "X-Goog-FieldMask": "places.displayName,places.editorialSummary,places.photos" // Informações que você quer que a API retorne
        ]
        
        let data = try await AF.request("\(API_BASE_URL)places:searchText", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).serializingDecodable(PlacesResponse.self).value
        
        return data
    }
    
    
    //MARK: FUNÇÃO PARA RETORNAR IMAGEM DE UM LOCAL
    func getPlaceImage(imageName : String) async throws-> Data? {
        let maxHeight : Int = 400
        let maxWidht  : Int = 400
        
        let data = try await AF.request("\(API_BASE_URL+imageName)/media?maxHeightPx=\(maxHeight)&maxWidthPx=\(maxWidht)&key=\(ENV.SERVICE_API_KEY)").serializingData().value
        
        return data
    }
    
}
