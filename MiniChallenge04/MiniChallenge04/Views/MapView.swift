//
//  MapView.swift
//  MiniChallenge04
//
//  Created by Felipe Porto on 20/03/24.
//

import SwiftUI
import SceneKit

struct MapView: View {
    @State private var selectedUF: String? = nil
    
    var body: some View {
        NavigationStack {
            if selectedUF != nil {
                GalleryView(title: selectedUF ?? "")
            } else {
                SceneKitView(selectedUF: $selectedUF)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
    }
    
    struct SceneKitView: UIViewRepresentable {
        @Binding var selectedUF: String?
        
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
                    
                    // Define uma cor aleatória para cada material do nó
                    let randomColor = UIColor(red: CGFloat.random(in: 0...1),
                                              green: CGFloat.random(in: 0...1),
                                              blue: CGFloat.random(in: 0...1),
                                              alpha: 1.0)
                    node.geometry?.firstMaterial?.diffuse.contents = randomColor
                }
            }
            
            return sceneView
        }
        
        func updateUIView(_ uiView: SCNView, context: Context) {
            // Atualiza a visualização conforme necessário
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(selectedUF: $selectedUF)
        }
    }
    
    class Coordinator: NSObject {
        @Binding var selectedUF: String?
        
        init(selectedUF: Binding<String?>) {
            _selectedUF = selectedUF
        }
        
        @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
            let sceneView = gestureRecognizer.view as? SCNView
            let touchLocation = gestureRecognizer.location(in: sceneView)
            let hitTestResult = sceneView?.hitTest(touchLocation, options: nil)
            
            if let hitNode = hitTestResult?.first?.node {
                // Quando o nó é clicado, define o estado para mostrar a nova visualização
                if let estado = hitNode.name?.split(separator: "_").first.map({ String($0) }) {
                    selectedUF = estado
                }
            }
            
        }
    }
}



#Preview {
    MapView()
}
