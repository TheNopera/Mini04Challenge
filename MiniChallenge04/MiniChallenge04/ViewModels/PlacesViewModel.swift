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
    @Published var categoryPlaces : [PlaceCardModel] = []
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
    func getRandomPlace(_ city: String) async -> PlaceCardModel? {
        if !apiIsCallable {
            return nil
        }
        do{
            try await getTouristicPlaces(in: city)
            guard let filteredData = placesData.first(where: { $0.cityName == city }) else {
                return nil
            }
            let randomPlaceIndex = Int.random(in: 0..<filteredData.places.count)
            
            var img = UIImage()
            
            guard let photos = filteredData.places[randomPlaceIndex].photos else{
                return nil
            }
            
            try await img = getImage(imgName: photos.first!.name)
            apiIsCallable = true
            return PlaceCardModel(image: img ,cityName: city, placeName: filteredData.places[randomPlaceIndex].displayName.text, description: filteredData.places[randomPlaceIndex].editorialSummary?.text, author: photos.first!.authorAttributions.first?.displayName)
        }
        catch{
           return nil
            
        }
        
        
    }
    
    //MARK: GET PLACES FROM A SPECIFIC  CATEGORY
    @MainActor
    func getCategoryPlaces(for category : String ) async{
        var recommendations : [PlaceCardModel] = []
        var contents = 5
        
        switch category{
        case "Acampamento":
            recommendations = recomendationCamping
        case "Praia":
            recommendations = recomendationBeach
        case "Montanhas":
            recommendations = recomendationMontain
        case "Floresta":
            recommendations = recomendationForest
        default:
            fatalError("Nenhuma categoria encontrada")
        }
        
        while contents < recommendations.count{
            for i in (contents - 5)..<contents{
                do{
                    guard let fetchPlace = await self.getRandomPlace(recommendations[i].placeName!) else{
                        continue
                    }
                    categoryPlaces.append(fetchPlace)
                }
            }
            
            contents = contents + 5
        }
    
    }
    
    
    init(api: APIManager = APIManager()) {
        self.api = api
        
    }
}
