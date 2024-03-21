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
    @Published var places : PlacesResponse = PlacesResponse(places: [])
    
    //MARK: Get touristic places in a specific city
    @MainActor
    func getPlaces(in city : String) async throws {
        print("Searching places in \(city)")
        let places = try await api.getTouristAttractions(city: city)
        
        switch places.result{
            
        case .success(_):
            if let locations = places.value?.places{
                for location in locations{
                    self.places.places.append(location)
                }
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
    func getRandomPlace() -> Place{
        let randomNumber = Int.random(in: 0..<places.places.count)
        return places.places[randomNumber]
    }
    
    init(api: APIManager = APIManager()) {
        self.api = api
    }
}
