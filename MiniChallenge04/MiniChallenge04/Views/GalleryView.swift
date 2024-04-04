//
//  GaleriaEstado.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 15/03/24.
//

import SwiftUI

struct GalleryView: View {
    
    @StateObject var galleryViewModel: GalleryViewModel
    var title: String
    
    @Binding var isPresented: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    init(title: String, isPresente:Binding<Bool>) {
        let viewModel = GalleryViewModel(title: title)
        _galleryViewModel = StateObject(wrappedValue: viewModel)
        self.title = title
        
        _isPresented = isPresente
        
    }
    
    var body: some View {
        VStack {
            List(galleryViewModel.assetsByLocation.sorted(by: { $0.key < $1.key }), id: \.key) { location, assets in
                if location == title {
                    Section(header: Text(location)) {
                        ForEach(assets.filter { asset in
                            guard let location = asset.location else { return false }
                            let uf = galleryViewModel.getUFLocalization(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                            return uf == title
                        }, id: \.self) { asset in
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
        }
        .navigationBarItems(leading:
                                Button(action: {
                                    isPresented = false
                                }) {
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                        .foregroundColor(.blue)
                                }
        )
        .navigationBarTitle(galleryViewModel.title)
        .onAppear {
            galleryViewModel.requestPhotoLibraryAccess()
        }
    }
}
