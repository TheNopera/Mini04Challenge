//
//  MapView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 20/03/24.
//

import SwiftUI
import SceneKit

struct MapView: View {
    @State private var SelectedUF: String? = nil
    
    var body: some View {
        NavigationStack {
            if SelectedUF != nil {
                GalleryView(title: SelectedUF ?? "")
            } else {
                SceneKitView(SelectedUF: $SelectedUF)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
    }
    
    struct SceneKitView: UIViewRepresentable {
        @Binding var SelectedUF: String?
        
        func makeUIView(context: Context) -> SCNView {
            let sceneView = SCNView()
            let scene = SCNScene(named: "MapaBrasil3D.dae")
            
            sceneView.scene = scene
            sceneView.autoenablesDefaultLighting = true
            sceneView.allowsCameraControl = true
            
            // Adicionando gesto de toque para cada nó da malha
            scene?.rootNode.enumerateChildNodes { node, _ in
                if node.geometry != nil {
                    let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
                    sceneView.addGestureRecognizer(tapGesture)
                }
            }
            
            return sceneView
        }
        
        func updateUIView(_ uiView: SCNView, context: Context) {
            // Atualiza a visualização conforme necessário
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(SelectedUF: $SelectedUF)
        }
    }
    
    class Coordinator: NSObject {
        @Binding var SelectedUF: String?
        
        init(SelectedUF: Binding<String?>) {
            _SelectedUF = SelectedUF
        }
        
        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            let sceneView = gestureRecognizer.view as? SCNView
            let touchLocation = gestureRecognizer.location(in: sceneView)
            let hitTestResult = sceneView?.hitTest(touchLocation, options: nil)
            
            if let hitNode = hitTestResult?.first?.node {
                // Quando o nó é clicado, define o estado para mostrar a nova visualização
                if let estado = hitNode.name?.split(separator: "_").last.map({ String($0) }) {
                    SelectedUF = estado
                }
            }
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
