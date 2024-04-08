//
//  PlaceDetailVM.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 08/04/24.
//

import Foundation
import CoreLocation
import WeatherKit

class PlaceDetailVM :ObservableObject{
    @Published var tempIsLoading : Bool = true
  
    var weatherProvider = WeatherService()
    private func geocodeAddress(_ address: String) async throws -> CLLocationCoordinate2D {
        print("trying to get location")
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.geocodeAddressString(address)
        
        guard let coordinate = placemarks.first?.location?.coordinate else {
            print("error place not found")
            throw NSError(domain: "GeocodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Coordinates not found for address: \(address)"])
        }
        
        return coordinate
    }
    
    func currentWeather(for location: CLLocation) async throws -> Weather? {
        var weather : Weather?
        
        do{
            print("trying to get temperature")
           weather = try await weatherProvider.weather(for: location)
        }
        catch{
            print(error.localizedDescription)
            return nil
        }
        
        return weather
    }
    
  

    
    func getTemperature(place: String) async -> String {
        var coord : CLLocationCoordinate2D
        var weatherResponse : String = ""
        
        do{
            coord = try await geocodeAddress(place)
            if let weather = try await currentWeather(for: CLLocation(latitude: coord.latitude, longitude: coord.longitude)){
                let temperature = weather.currentWeather.apparentTemperature.converted(to: .celsius).value
                weatherResponse = String(format: "%.0f", temperature) 
            }
            
        }
        catch{
            return "-/-"
        }
        
        self.tempIsLoading = false
        return "\(weatherResponse)Cº"
    }
}
