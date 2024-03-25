//
//  GaleriaEstado.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 15/03/24.
//

import Foundation
import SwiftUI
import Photos

struct GalleryView:View {
    
    
    @StateObject var galleryViewModel:GalleryViewModel = GalleryViewModel()
    //@State var title:String
    
    var body: some View {
        
        VStack {
                        // Exibir assets (fotos ou vídeos) organizados por localização
            List(galleryViewModel.assetsByLocation.sorted(by: { $0.key < $1.key }), id: \.key) { location, assets in
                            Section(header: Text(location)) {
                                
                                ForEach(assets, id: \.self) { asset in
                                    if asset.mediaType == .image {
                                        // Exibir a foto usando a função 'image' do 'PHAsset'
                                        Image(uiImage: galleryViewModel.getImage(from: asset))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                    } else if asset.mediaType == .video {
                                        // Exibir o ícone do vídeo para indicar que é um vídeo
                                        Image(systemName: "video.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                    }
                                }
                            }
                        }
                    }
        .navigationBarTitle(galleryViewModel.title) // Definir o título da barra de navegação
                    .onAppear {
                        galleryViewModel.requestPhotoLibraryAccess() // Solicitar permissão para acessar a biblioteca de fotos ao aparecer na tela
                }
            
        }
}

#Preview {
    GalleryView()
}
