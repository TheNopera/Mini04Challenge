import SwiftUI
import Photos
import CoreML

class GalleryViewModel: ObservableObject {
    @Published var assetsByLocation: [String: [PHAsset]] = [:]
    @Published var selectedPhoto: PHAsset?
    @Published var locationString: String = ""
    @Published var title:String
    @Published var currentUf: String?
    
    init(title:String) {
        self.title = title
    }

    func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            guard let self = self else { return }
            if status == .authorized {
                self.loadAssets()
            } else {
                print("O usuário não concedeu permissão para acessar a biblioteca de fotos.")
            }
        }
    }
    
    func loadAssets() {
        let fetchOptions = PHFetchOptions()
        let allAssets = PHAsset.fetchAssets(with: .image, options: fetchOptions) // Fetch all photos from the library
        let allVAssets = PHAsset.fetchAssets(with: .video, options: fetchOptions) // Fetch all videos from the library
        
        allAssets.enumerateObjects { (asset, _, _) in
            if let location = asset.location {
                let locationString = "\(self.getUFLocalization(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))" // Create a unique key based on location
                DispatchQueue.main.async {
                    if self.assetsByLocation[locationString] == nil {
                        self.assetsByLocation[locationString] = [PHAsset]() // Initialize the asset list for this location
                    }
                    self.assetsByLocation[locationString]?.append(asset)
                }
            }
        }
        
        allVAssets.enumerateObjects { (asset, _, _) in
            if let location = asset.location {
                let locationString = "\(self.getUFLocalization(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))" // Create a unique key based on location
                DispatchQueue.main.async {
                    if self.assetsByLocation[locationString] == nil {
                        self.assetsByLocation[locationString] = [PHAsset]() // Initialize the asset list for this location
                    }
                    self.assetsByLocation[locationString]?.append(asset)
                }
            }
        }
    }
    
    func getImage(from asset: PHAsset) -> UIImage {
        var image = UIImage()
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: options) { result, _ in
            if let result = result {
                image = result
            }
        }
        
        return image
    }

    func getUFLocalization(latitude:Double,longitude:Double) -> String {
        do {
            let config = MLModelConfiguration()
            let model = try UFLocalization(configuration: config)
            
            let prediction = try model.prediction(latitude: latitude, longitude: longitude)
            
            return ufDictionary[Int(prediction.codigo_uf)] ?? "DF"
        } catch {
            print("erro in get localization UF")
            return "Nil"
        }
    }
}
