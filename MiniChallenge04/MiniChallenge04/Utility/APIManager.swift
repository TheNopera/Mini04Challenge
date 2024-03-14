//
//  APIManager.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 13/03/24.
//

import Foundation
import Alamofire

class APIManager : ObservableObject{
    @Published var response : PlacesResponse = PlacesResponse(places: [])
    var ENV : APIKeyable {
        return ProdENV()
    }
    
    var apiURL = "https://places.googleapis.com/v1/places:searchText"
    
    func getTouristAttractions(city : String) {
    
        //O body do request
        let parameters : [String:Any] = [
            "textQuery" : "Pontos turisticos \(city)"
        ]
        
        //Configuração do header do request
        let headers : HTTPHeaders = [
            "Content-Type": "application/json",
            "X-Goog-Api-Key": ENV.SERVICE_API_KEY,
            "X-Goog-FieldMask": "places.displayName,places.editorialSummary" // Informações que você quer que a API retorne
        ]
        
        AF.request(apiURL, method: .post,parameters: parameters ,encoding: JSONEncoding.default,headers: headers).response{ response in
            switch response.result {
                case .success:
                    print("Raw Response: ")
                
            
            case .failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
    }
    
    
}
