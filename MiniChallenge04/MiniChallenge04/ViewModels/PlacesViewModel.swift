//
//  PlacesViewModel.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 18/03/24.
//

import Foundation
import UIKit

struct PlaceData {
    var cityName : String
    var places : [Place]
}


class PlacesViewModel : ObservableObject{
    @Published var api = APIManager()
    @Published var recomendationModel: RecomendationModel = RecomendationModel()
    @Published var places : PlacesResponse = PlacesResponse(places: [])
    @Published var placesData : [PlaceData] = []
    @Published var apiIsCallable : Bool = false
    //MARK: Get touristic places in a specific city
    @MainActor
    func getTouristicPlaces(in city : String) async throws {
        print("Searching places in \(city)")
        let places = try await api.getTouristAttractions(city: city)
        
        switch places.result{
            
        case .success(_):
            if let locations = places.value?.places{
                    self.placesData.append(PlaceData(cityName: city, places: locations))
            }
        case .failure(_):
            print("failed")
            throw APIError.invalidResponse("Algo deu errado ao buscar dados do local")
        }
    }
    
    //MARK: Get images from a place
    @MainActor
    func getImage(imgName : String) async throws -> UIImage{
        let imgData = try await api.getImageUrl(imageName: imgName)
        
        switch imgData.result{
        case .success(_):
            if let imageResponse = imgData.value{
                guard let _ = imageResponse.first else{
                    return UIImage(named: "Image_Load_Failed")!
                }
            }
            
            return UIImage(data: imgData.value!)!
            
        case .failure(_):
            print("Failed to get Image")
            return UIImage(named: "Image_Load_Failed")!
        }
    }
    
    //MARK: Get a random place in the array
    func getRandomPlace(_ city : String) -> String{
        let filteredData = placesData.filter { $0.cityName == city }
        let randomNumber = Int.random(in: 0..<filteredData.count)
        let randomPlace = Int.random(in: 0..<filteredData[randomNumber].places.count)
        
        
        return filteredData[randomNumber].places[randomPlace].photos.first!.name
    }
    
    
    
    init(api: APIManager = APIManager(), recomendationModel: RecomendationModel = RecomendationModel()) {
        self.api = api
        self.recomendationModel = recomendationModel
    }
}
