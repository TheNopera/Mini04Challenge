//
//  GaleriaEstado.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 15/03/24.
//

import Foundation
import SwiftUI
import Photos

struct GaleriaView:View {
    
    var titulo:String
    var fotos:[Image] = []
    
    @StateObject var galleryViewModel:GalleyViewModel = GalleyViewModel()
    
    init(titulo: String) {
        self.titulo = titulo
        self.fotos = []
    }
    
    var body: some View {
        
            VStack {
                // Exibir fotos organizadas por localização
                List(galleryViewModel.photosByLocation.sorted(by: { $0.key < $1.key }), id: \.key) { location, assets in
                    Section(header: Text(location)) {
                        ForEach(assets, id: \.self) { asset in
                            // Exibir a foto usando a função 'image' do 'PHAsset'
                            Image(uiImage: self.getImage(from: asset))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
            .navigationBarTitle("Minha Galeria de Fotos") // Definir o título da barra de navegação
            .onAppear {
                galleryViewModel.requestPhotoLibraryAccess() // Solicitar permissão para acessar a biblioteca de fotos ao aparecer na tela

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

#Preview {
    GaleriaView(titulo: "Distrito Federal")
}
