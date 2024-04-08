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
    @Published var placesData : [PlaceData] = []
    @Published var apiIsCallable : Bool = true
    
    
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
            print(places.result)
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
    @MainActor
    func getRandomPlace(_ city: String) async -> PlaceCardModel {
        if !apiIsCallable {
            return PlaceCardModel(image: UIImage(named: "Image_Load_Failed")!, cityName: city, description: "Erro ao tentar recuperar informações do local")
        }
        do{
            try await getTouristicPlaces(in: city)
            guard let filteredData = placesData.first(where: { $0.cityName == city }) else {
                return PlaceCardModel(image: UIImage(named: "Image_Load_Failed")!, cityName: city, description: "Erro ao tentar recuperar informações do local")
            }
            let randomPlaceIndex = Int.random(in: 0..<filteredData.places.count)
            
            var img = UIImage()
            
            guard let photos = filteredData.places[randomPlaceIndex].photos else{
                return PlaceCardModel(image: UIImage(named: "Image_Load_Failed")!, cityName: city, description: "Erro ao tentar recuperar informações do local")
            }
            
            try await img = getImage(imgName: photos.first!.name)
            apiIsCallable = true
            return PlaceCardModel(image: img ,cityName: city, placeName: filteredData.places[randomPlaceIndex].displayName.text, description: filteredData.places[randomPlaceIndex].editorialSummary?.text, author: photos.first!.authorAttributions.first?.displayName)
        }
        catch{
            return PlaceCardModel(image: UIImage(named: "Image_Load_Failed")!, cityName: city, description: "Erro ao tentar recuperar informações do local")
            
        }
        
        
    }
    
    
    
    init(api: APIManager = APIManager()) {
        self.api = api
        
    }
}
