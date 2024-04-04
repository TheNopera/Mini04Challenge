//
//  GaleriaEstado.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 15/03/24.
//

import SwiftUI

import Photos

import SwiftUIImageViewer


struct GalleryView: View {
    
    @StateObject var galleryViewModel: GalleryViewModel


    @Binding var isPresented: Bool
    var title:String
//    @State var changeValue: UIImage
//    @State var image: Image
    @State var assetAuxiliar:PHAsset?
    
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
                                                    .overlay(alignment: .topLeading) {
                                                        setButton
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
    
    private var setButton: some View {
        Button {
            if let asset = assetAuxiliar {
                let uiImage = galleryViewModel.getImage(from: asset)
                if let imageData = uiImage.jpegData(compressionQuality: 1.0) {
                    StateInfoManager.shared.updateStateFoto(forUF: title.uppercased(), withFoto: imageData)
                    print(imageData)
                }
                
                
                
            }
        } label: {
            Text("Set")
        }
        .buttonStyle(.bordered)
        .clipShape(Circle())
        .tint(.purple)
        .padding()
    }


    
}
