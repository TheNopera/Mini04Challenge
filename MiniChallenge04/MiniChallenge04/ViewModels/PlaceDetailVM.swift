//
//  PlaceDetailVM.swift
//  MiniChallenge04
//
//  Created by Daniel Ishida on 08/04/24.
//

import Foundation
import CoreLocation
import WeatherKit


class PlaceDetailVM : ObservableObject{
    @Published var tempIsLoading : Bool = true
//    private var manager = CLLocationManager()
    private var weatherProvider = WeatherService()// Create weather service
    
//    override init() {
//        super.init()
//        manager.delegate = self
//        self.locationManagerDidChangeAuthorization(manager)
//    }
//    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .authorizedWhenInUse:  // Location services are available.
//            print("authorized")
//            break
//            
//        case .restricted, .denied:  // Location services currently unavailable.
//            print("restricted")
//            break
//            
//        case .notDetermined:   // Authorization not determined yet.
//            print("not determined")
//            manager.requestWhenInUseAuthorization()
//            break
//            
//        default:
//            break
//        }
//    }
//
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//         print("error:: \(error.localizedDescription)")
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            manager.requestLocation()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if locations.first != nil {
//            print("location:: (location)")
//        }
//
//    }
    
    //MARK: GET COORDINATES FROM A PLACE
    private func geocodeAddress(_ address: String) async throws -> CLLocationCoordinate2D {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.geocodeAddressString(address)
        
        guard let coordinate = placemarks.first?.location?.coordinate else {
            throw NSError(domain: "GeocodingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Coordinates not found for address: \(address)"])
        }
        
        return coordinate
    }
    
    //MARK: GET CURRENT WEATHER FROM A PLACE
    private func currentWeather(for location: CLLocation) async throws -> Weather? {
        var weather : Weather?
        
        weather = try await weatherProvider.weather(for: location)
        
        return weather
    }
    
    //MARK: CALCULATE THE DISTANCE FROM THE USER LOCATION TO ANOTHER PLACE
    private func calculateDistance(from userLocation: CLLocation, to destinationLocation: CLLocation) async throws -> CLLocationDistance {
        let distance = userLocation.distance(from: destinationLocation)
        return distance
    }
    
    
    //MARK: GET THE TEMPERATURE FROM A SPECIFIC PLACE/CITY
    @MainActor
    func getTemperature(for place : String) async -> String {
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
            self.tempIsLoading = false
            return "-/-"
        }
        
        self.tempIsLoading = false
        return "\(weatherResponse)Cº"
    }
}
