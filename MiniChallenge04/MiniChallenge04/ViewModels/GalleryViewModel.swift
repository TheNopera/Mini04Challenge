import SwiftUI
import Photos
import CoreML

class GalleryViewModel: ObservableObject {
    @Published var assetsByLocation: [String: [PHAsset]] = [:]
    @Published var selectedPhoto: PHAsset?
    @Published var locationString: String = ""

    
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
        let allAssets = PHAsset.fetchAssets(with: .image, options: fetchOptions) // Obter todas as fotos da biblioteca
        
        allAssets.enumerateObjects { (asset, _, _) in
            guard let location = asset.location else {
                return // Ignorar assets sem informações de localização
            }
            
            
            let locationString = "\(self.getUFLocalization(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))" // Criar uma chave única com base na localização
            DispatchQueue.main.async {
                if self.assetsByLocation[locationString] == nil {
                    self.assetsByLocation[locationString] = [PHAsset]() // Inicializar a lista de assets para essa localização
                }
                self.assetsByLocation[locationString]?.append(asset)
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

    
    func getUFLocalization(latitude:Double,longitude:Double) -> Int{
        do{
            let config = MLModelConfiguration()
            let model = try UFLocalization(configuration: config)
            
            let prediction = try model.prediction(latitude: latitude, longitude: longitude)
            
            return Int(prediction.codigo_uf)
        }catch{
            print("erro in get localization UF")
        }
        return 0
    }
}
