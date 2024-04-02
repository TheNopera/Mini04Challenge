//
//  MapView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 20/03/24.
//
import SwiftUI
import SceneKit

extension String: Identifiable {
    public var id: String { self }
}

struct MapView: View {
//    // Array de siglas das UFs do Brasil
//    @StateObject var mapViewModel = MapViewModel()
//
//    @State private var selectedUF: String?
//
//    var body: some View {
//        NavigationStack{
//            VStack {
//                // Criando uma LazyVGrid para organizar os botões em uma grade vertical
//                LazyVGrid(columns: [
//                                GridItem(.flexible(minimum: 50)),
//                                GridItem(.flexible(minimum: 50)),
//                                GridItem(.flexible(minimum: 50))
//                ], spacing: 10) {
//                    ForEach(mapViewModel.ufs, id: \.self) { uf in
//                        NavigationLink(destination: GalleryView(title: uf)) {
//                        
//                            // Label do botão contendo a sigla da UF
//                            Text(uf)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color.blue)
//                                .cornerRadius(10)
//                        }
//                    }
//                }
//                .padding()
//            }
//        }
//    }
    
    
    var body: some View {
        VStack{
            SceneKitView()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // Defina o tamanho da cena conforme necessário
        }
        }
    }

    struct SceneKitView: UIViewRepresentable {
        func makeUIView(context: Context) -> SCNView {
            // Crie uma cena SceneKit
            let sceneView = SCNView()
            let scene = SCNScene(named: "MapaBrasil3D.dae") // Substitua "seu_objeto.dae" pelo nome do seu arquivo .dae
            
            // Adicione a cena à visualização
            sceneView.scene = scene
            
            // Personalize as configurações da cena conforme necessário
            sceneView.autoenablesDefaultLighting = true // Adiciona iluminação à cena
            sceneView.allowsCameraControl = true // Permite ao usuário controlar a câmera
            
            return sceneView
        }
        
        func updateUIView(_ uiView: SCNView, context: Context) {
            // Atualiza a visualização conforme necessário
        }
    }

#Preview {
    MapView()
}
