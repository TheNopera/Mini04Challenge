//
//  PlacesViewModel.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 18/03/24.
//

import Foundation
import UIKit

class PlacesViewModel : ObservableObject{
    var api = APIManager()
    
    @Published var places : PlacesResponse
    
    func getPlaces(in city : String) async throws -> PlacesResponse?{
        let places = try await api.getTouristAttractions(city: city)
        
        switch places.result{
            
        case .success(_):
            return places.value
        case .failure(_):
            throw APIError.invalidResponse("Algo deu errado ao buscar dados do local")
        }
    }
    
    func getImageUrl(imgName : String) async throws -> URL?{
        let imgData = try await api.getImageUrl(imageName: imgName)
        
        switch imgData.result{
        case .success(_):
            guard let img = imgData.value?.authorAttributions.first?.photoUri else{
                return nil
            }
            return URL(string: img)
        case .failure(_):
            throw APIError.invalidResponse("Não foi possivel recuperar imagens deste local")
        }
    }
    
    func getImage(imgName : String) async throws -> UIImage{
        var imgUrl = try await getImageUrl(imgName: imgName)
        guard let url = imgUrl else{
            throw APIError.invalidData("NO IMAGE DATA")
        }
        
        var imgData = try await api.downloadImage(url: url)
        switch imgData.result{
            
        case .success(_):
            guard let img = imgData.data else{
                //colocar imagem de não encontrado aqui
                throw APIError.invalidData("NO IMAGE DATA")
            }
        
            return UIImage(data: img)!
        case .failure(_):
            throw APIError.invalidData("Something went wrong")
        }
    }
    
    init(api: APIManager = APIManager(), places: PlacesResponse) {
        self.api = api
        self.places = places
    }
}
