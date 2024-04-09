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

import Photos

import SwiftUIImageViewer


struct GalleryView: View {
    
    @StateObject var galleryViewModel: GalleryViewModel
    @Binding var isPresented: Bool
    var title: String
    @State var assetAuxiliar: PHAsset?
    
    @Environment(\.presentationMode) var presentationMode
    
    init(title: String, isPresente: Binding<Bool>) {
        let viewModel = GalleryViewModel(title: title)
        _galleryViewModel = StateObject(wrappedValue: viewModel)
        self.title = title
        _isPresented = isPresente
    }
    
    var body: some View {
        VStack {
            if let assets = galleryViewModel.assetsByLocation[title] {
                if assets.isEmpty {
                    Text("Sem fotos nesse estado")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(assets, id: \.self) { asset in
                            if asset.mediaType == .image {
                                // Exibir a foto usando a função 'image' do 'PHAsset'
                                Image(uiImage: galleryViewModel.getImageLQ(from: asset))
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
                            }
                        }
                    }
                }
            } else {
                Text("Sem fotos nesse estado")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { isPresented = false } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
        .navigationBarTitle(StateDictionary[galleryViewModel.title] ?? "")
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
                
                galleryViewModel.isImagePresented = false
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
