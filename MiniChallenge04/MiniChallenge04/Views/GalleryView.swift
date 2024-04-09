//
//  GaleriaEstado.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 15/03/24.
//

import Foundation
import SwiftUI
import Photos
//import AVKit
import SwiftUIImageViewer

struct GalleryView: View {
    
    @StateObject var galleryViewModel: GalleryViewModel
    var title:String
//    @State var changeValue: UIImage
//    @State var image: Image
    @State var assetAuxiliar:PHAsset?
    
    init(title: String) {
        let viewModel = GalleryViewModel(title: title)
        _galleryViewModel = StateObject(wrappedValue: viewModel)
        self.title = title
    }
    
    var body: some View {
        VStack {
            List(galleryViewModel.assetsByLocation.sorted(by: { $0.key < $1.key }), id: \.key) { location, assets in
<<<<<<< Updated upstream

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


=======
                            Section(header: Text(location)) {
                                ForEach(assets, id: \.self) { asset in
                                    if asset.mediaType == .image {
                                        // Exibir a foto usando a função 'image' do 'PHAsset'
                                        Image(uiImage: galleryViewModel.getImage(from: asset))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .onTapGesture {
                                                galleryViewModel.isImagePresented = true
                                                assetAuxiliar = asset
                                            }
                                            .fullScreenCover(isPresented: $galleryViewModel.isImagePresented) {
                                                
                                                SwiftUIImageViewer(image: Image(uiImage: galleryViewModel.getImage(from: assetAuxiliar ?? asset)))
                                                    .overlay(alignment: .topTrailing) {
                                                    closeButton
                                                }
                                            }
                                        
                                    } else if asset.mediaType == .video {
                                        
                                        Image(systemName: "video.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .onTapGesture {
                                                galleryViewModel.playVideoFromPHAsset(asset)
                                            }
                                            
                                    }
                                }
>>>>>>> Stashed changes
                            }
                        }
                    }
        .navigationBarTitle(galleryViewModel.title)
        .onAppear {
            galleryViewModel.requestPhotoLibraryAccess()
        }
    }
//    private var closeButton: some View {
//            Button {
//                galleryViewModel.isImagePresented = false
//            } label: {
//                Image(systemName: "xmark")
//                    .font(.headline)
//            }
//            .buttonStyle(.bordered)
//            .clipShape(Circle())
//            .tint(.purple)
//            .padding()
//        }
}


#Preview {
    GalleryView(title: "Df")
}
