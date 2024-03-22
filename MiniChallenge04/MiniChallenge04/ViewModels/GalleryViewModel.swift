import SwiftUI
import Photos

class GalleryViewModel: ObservableObject {
    @Published var assetsByLocation: [String: [PHAsset]] = [:]
    @Published var selectedPhoto: PHAsset?
    @Published var locationString: String = ""
    private let locationManager = LocationManager()
    private let batchSize = 10 // Tamanho do lote para processamento paralelo
    
    private var requestCount = 0
    private let maxRequestsPerInterval = 50
    private let intervalDuration = 65.0 // segundos
    private var lastRequestTimestamp: TimeInterval = 0

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
        let allAssets = PHAsset.fetchAssets(with: .image, options: fetchOptions)

        var assetBatches: [[PHAsset]] = []

        allAssets.enumerateObjects { asset, _, _ in
            if var lastBatch = assetBatches.last, lastBatch.count < self.batchSize {
                lastBatch.append(asset)
                assetBatches[assetBatches.count - 1] = lastBatch
            } else {
                assetBatches.append([asset])
            }
        }

        let dispatchGroup = DispatchGroup()

        for batch in assetBatches {
            dispatchGroup.enter()
            DispatchQueue.global().async { [weak self] in
                guard let self = self else {
                    dispatchGroup.leave()
                    return
                }
                self.processAssets(batch, completion: {
                    dispatchGroup.leave()
                })
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("Todos os lotes foram processados")
        }
    }

    private func processAssets(_ assets: [PHAsset], completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        
        for asset in assets {
            dispatchGroup.enter()
            
            guard let location = asset.location else {
                dispatchGroup.leave()
                continue
            }

            let currentTimestamp = Date().timeIntervalSinceReferenceDate
            let timeSinceLastRequest = currentTimestamp - lastRequestTimestamp

            if timeSinceLastRequest < intervalDuration && requestCount >= maxRequestsPerInterval {
                // Esperar até o próximo período de reinício
                let timeToWait = intervalDuration - timeSinceLastRequest
                DispatchQueue.main.asyncAfter(deadline: .now() + timeToWait) {
                    self.processAssets(assets, completion: completion)
                }
                return
            }

            self.locationManager.getAddressFromCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { [weak self] address in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    let locationString = address ?? "Desconhecido"
                    self.updateAssetsDictionary(asset, with: locationString)
                    self.requestCount += 1
                    self.lastRequestTimestamp = Date().timeIntervalSinceReferenceDate
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
    }

    private func updateAssetsDictionary(_ asset: PHAsset, with locationString: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.assetsByLocation[locationString] == nil {
                self.assetsByLocation[locationString] = [PHAsset]()
            }
            self.assetsByLocation[locationString]?.append(asset)
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
}
