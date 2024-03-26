//
//  GaleriaEstado.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 15/03/24.
//

import Foundation
import SwiftUI
import Photos
import AVKit

struct GalleryView: View {
    
    @StateObject var galleryViewModel: GalleryViewModel
    
    init(title: String) {
        let viewModel = GalleryViewModel(title: title)
        _galleryViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            
            List(galleryViewModel.assetsByLocation.sorted(by: { $0.key < $1.key }), id: \.key) { location, assets in
                Section(header: Text(location)) {
                    ForEach(assets, id: \.self) { asset in
                        if asset.mediaType == .image {
                            Image(uiImage: galleryViewModel.getImage(from: asset))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        } else if asset.mediaType == .video {
                            Image(systemName: "video.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(galleryViewModel.title)
        .onAppear {
            galleryViewModel.requestPhotoLibraryAccess()
        }
    }
}


#Preview {
    GalleryView(title: "Df")
}
