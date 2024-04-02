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
        @State private var lastScale: CGFloat = 1.0
        @State private var lastPanLocation: CGPoint = .zero
        
        func makeUIView(context: Context) -> SCNView {
            let sceneView = SCNView()
            let scene = SCNScene(named: "MapaBrasil3D.dae")
            
            sceneView.scene = scene
            sceneView.autoenablesDefaultLighting = true
            sceneView.allowsCameraControl = false
            
            scene?.rootNode.eulerAngles.x -= 5
            scene?.rootNode.position.y += 5
            
            let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(_:)))
            sceneView.addGestureRecognizer(pinchGesture)
            
            let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(_:)))
            sceneView.addGestureRecognizer(panGesture)
            
            scene?.rootNode.enumerateChildNodes { node, _ in
                if node.geometry != nil {
                    let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
                    sceneView.addGestureRecognizer(tapGesture)
                    
                    let randomColor = UIColor(red: CGFloat.random(in: 0...1),
                                              green: CGFloat.random(in: 0...1),
                                              blue: CGFloat.random(in: 0...1),
                                              alpha: 1.0)
                    node.geometry?.firstMaterial?.diffuse.contents = randomColor
                }
            }
            
            return sceneView
        }
        
        func updateUIView(_ uiView: SCNView, context: Context) {}
        
        func makeCoordinator() -> Coordinator {
            Coordinator(selectedUF: $selectedUF, lastScale: $lastScale, lastPanLocation: $lastPanLocation)
        }
        
        class Coordinator: NSObject {
            @Binding var selectedUF: String?
            @Binding var lastScale: CGFloat
            @Binding var lastPanLocation: CGPoint
            
            init(selectedUF: Binding<String?>, lastScale: Binding<CGFloat>, lastPanLocation: Binding<CGPoint>) {
                _selectedUF = selectedUF
                _lastScale = lastScale
                _lastPanLocation = lastPanLocation
            }
            
            @objc func handlePinch(_ gestureRecognizer: UIPinchGestureRecognizer) {
                guard let sceneView = gestureRecognizer.view as? SCNView else { return }
                let pinchScale: CGFloat = gestureRecognizer.scale
                
                switch gestureRecognizer.state {
                case .began:
                    lastScale = 1.0
                case .changed:
                    let newScale = 1.0 - (lastScale - pinchScale)
                    let currentScale = CGFloat(sceneView.scene?.rootNode.scale.x ?? 1.0)
                    let scaled = min(max(newScale * currentScale, 0.5), 10.0)
                    sceneView.scene?.rootNode.scale = SCNVector3(scaled, scaled, scaled)
                    lastScale = pinchScale
                default:
                    break
                }
            }
            
            @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
                guard let sceneView = gestureRecognizer.view as? SCNView else { return }
                let translation = gestureRecognizer.translation(in: sceneView)
                
                switch gestureRecognizer.state {
                case .changed:
                    let deltaX = Float(translation.x / 100.0)
                    let deltaY = Float(translation.y / 100.0)
                    sceneView.scene?.rootNode.position.x += deltaX
                    sceneView.scene?.rootNode.position.z -= deltaY
                    lastPanLocation = translation
                    gestureRecognizer.setTranslation(.zero, in: sceneView)
                default:
                    break
                }
            }
            
            @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
                let sceneView = gestureRecognizer.view as? SCNView
                let touchLocation = gestureRecognizer.location(in: sceneView)
                let hitTestResult = sceneView?.hitTest(touchLocation, options: nil)
                
                if let hitNode = hitTestResult?.first?.node {
                    if let estado = hitNode.name?.split(separator: "_").first.map({ String($0) }) {
                        selectedUF = estado
                    }
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
