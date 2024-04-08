import SwiftUI
import Photos
import CoreML
import AVKit

class GalleryViewModel: ObservableObject {
    @Published var assetsByLocation: [String: [PHAsset]] = [:]
    //@Published var thumbnailImage: [PHAsset : UIImage] = [:]
    @Published var selectedPhoto: PHAsset?
    @Published var locationString: String = ""
    @Published var title:String
    @Published var currentUf: String?
    @Published var isImagePresented = false
    @Published var isVideoPresented = false
    var adaptiveColuns = [GridItem(.adaptive(minimum: 120, maximum: 200))]
    
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
    func playVideoFromPHAsset(_ asset: PHAsset) {
        PHCachingImageManager().requestAVAsset(forVideo: asset, options: nil) { (avAsset, _, _) in
            guard let avAsset = avAsset else { return }
            
            DispatchQueue.main.async {
                let player = AVPlayer(playerItem: AVPlayerItem(asset: avAsset))
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                
                // Presente o playerViewController
                // Aqui você pode optar por apresentar o player de vídeo em uma nova tela ou em uma folha modal, dependendo do seu aplicativo
                // Por exemplo:
                // UIApplication.shared.windows.first?.rootViewController?.present(playerViewController, animated: true, completion: nil)
            }
        }
    }
    

    func getImage(from asset: PHAsset) -> UIImage {
        var image = UIImage()
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 10000, height: 10000), contentMode: .aspectFit, options: options) { result, _ in
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
