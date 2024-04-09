import Foundation
import CoreLocation
import Photos

class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
    }

    func getAddressFromCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)

        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }

            var addressComponents = [String]()

            if let name = placemark.name {
                addressComponents.append(name)
            }

            if let thoroughfare = placemark.thoroughfare {
                addressComponents.append(thoroughfare)
            }

            if let locality = placemark.locality {
                addressComponents.append(locality)
            }

            if let administrativeArea = placemark.administrativeArea {
                addressComponents.append(administrativeArea)
            }

            if let postalCode = placemark.postalCode {
                addressComponents.append(postalCode)
            }

            if let country = placemark.country {
                addressComponents.append(country)
            }

            let address = addressComponents.joined(separator: ", ")
            completion(address)
        }
    }
}
