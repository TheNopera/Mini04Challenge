//
//  GalleyViewModel.swift
//  MiniChallenge04
//
//  Created by Lucas Nascimento on 19/03/24.
//

import SwiftUI
import Photos

class GalleyViewModel: ObservableObject{
    @Published var photosByLocation: [String: [PHAsset]] = [:] // Dicionário para armazenar fotos por localização
    
    func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                self.loadPhotos() // Se a permissão for concedida, carregar as fotos da biblioteca
            } else {
                print("O usuário não concedeu permissão para acessar a biblioteca de fotos.")
            }
        }
    }

    func loadPhotos() {
        let fetchOptions = PHFetchOptions()
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions) // Obter todas as fotos da biblioteca

        allPhotos.enumerateObjects { (asset, _, _) in
            guard let location = asset.location else {
                return // Ignorar fotos sem informações de localização
            }

            let locationString = "\(location.coordinate.latitude), \(location.coordinate.longitude)" // Criar uma chave única com base na localização
            if self.photosByLocation[locationString] == nil {
                DispatchQueue.main.async {
                    self.photosByLocation[locationString] = [PHAsset]() // Inicializar a lista de fotos para essa localização
                }
            }
            DispatchQueue.main.async {
                self.photosByLocation[locationString]?.append(asset) // Adicionar a foto à lista correspondente à localização
            }
            
        }
    }

    func getImage(from asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        var image = UIImage()

        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: options) { result, _ in
            if let result = result {
                image = result // Obter a imagem da foto
            }
        }

        return image // Retornar a imagem da foto
    }
}
