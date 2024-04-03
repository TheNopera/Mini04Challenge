//
//  GaleriaEstado.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 15/03/24.
//

import Foundation
import SwiftUI
//import Photos
//import AVKit
import SwiftUIImageViewer

struct GalleryView: View {
    
    @StateObject var galleryViewModel: GalleryViewModel
    var title:String
//    @State var changeValue: UIImage
//    @State var image: Image
    
    init(title: String) {
        let viewModel = GalleryViewModel(title: title)
        _galleryViewModel = StateObject(wrappedValue: viewModel)
        self.title = title
    }
    
    var body: some View {
        VStack {
            List(galleryViewModel.assetsByLocation.sorted(by: { $0.key < $1.key }), id: \.key) { location, assets in
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
                                            }
                                            .fullScreenCover(isPresented: $galleryViewModel.isImagePresented) {
                                                SwiftUIImageViewer(image: Image(uiImage: galleryViewModel.getImage(from: asset)))
                                                    .overlay(alignment: .topTrailing) {
                                                    closeButton
                                                }
                                            }
                                        
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
        .navigationBarTitle(galleryViewModel.title)
        .onAppear {
            galleryViewModel.requestPhotoLibraryAccess()
        }
    }
    private var closeButton: some View {
            Button {
                galleryViewModel.isImagePresented = false
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
            }
            .buttonStyle(.bordered)
            .clipShape(Circle())
            .tint(.purple)
            .padding()
        }
}


#Preview {
    GalleryView(title: "Df")
}
