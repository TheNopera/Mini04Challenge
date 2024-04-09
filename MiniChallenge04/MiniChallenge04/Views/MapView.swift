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
    @State var isPresented: Bool
    
    var body: some View {
        ZStack{
            
            if selectedUF != nil && isPresented {
                
                GalleryView(title: selectedUF ?? "", isPresente: $isPresented )
            } else {
                SceneKitView(selectedUF: $selectedUF, isPresented: $isPresented)
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.top)
            }
            
        }
        .onAppear {
            if StateInfoManager.shared.loadStateInfos().isEmpty {
                
                StateInfoManager.shared.initializeStateInfos()
            }
        }
    }
    
    struct SceneKitView: UIViewRepresentable {
        
        @Binding var selectedUF: String?
        @State private var lastScale: CGFloat = 1.0
        @State private var lastPanLocation: CGPoint = .zero
        @Binding var isPresented: Bool
        
        func makeUIView(context: Context) -> SCNView {
            let sceneView = SCNView()
            let scene = SCNScene(named: "MapaBrasil3D.dae")
            
            sceneView.scene = scene
            sceneView.autoenablesDefaultLighting = true
            sceneView.allowsCameraControl = false
            sceneView.backgroundColor = .clear
            
            if let BgImage = UIImage(named: "BG") {
                sceneView.scene?.background.contents = BgImage
            }
            
            
            scene?.rootNode.eulerAngles.x -= 5
            scene?.rootNode.position.y += 5
            
            let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(_:)))
            sceneView.addGestureRecognizer(pinchGesture)
            
            let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(_:)))
            sceneView.addGestureRecognizer(panGesture)
            
            // Permitir zoom e pan simultaneamente
            pinchGesture.delegate = context.coordinator
            panGesture.delegate = context.coordinator
            
            scene?.rootNode.enumerateChildNodes { node, _ in
                if node.geometry != nil {
                    let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
                    sceneView.addGestureRecognizer(tapGesture)
                    
                    let randomColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                    
                    if let geometryName = node.geometry?.name, geometryName.hasSuffix("_mesh") {
                        
                        if let uf = geometryName.split(separator: "_").first.map({ String($0 )})  {
                            
                            if let imageData = StateInfoManager.shared.getStateFoto(forUF: String(uf)) {
                                
                                let image = UIImage(data: imageData)
                                
                                node.geometry?.firstMaterial?.diffuse.contents = image
                            } else {
                                node.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                            }
                            
                        }
                        
                        
                    }
                    
                }
            }
            
            return sceneView
        }
        
        func updateUIView(_ uiView: SCNView, context: Context) {}
        
        func makeCoordinator() -> Coordinator {
            Coordinator(selectedUF: $selectedUF, lastScale: $lastScale, lastPanLocation: $lastPanLocation, isPresented: $isPresented)
        }
        
        class Coordinator: NSObject, UIGestureRecognizerDelegate {
            @Binding var selectedUF: String?
            @Binding var lastScale: CGFloat
            @Binding var lastPanLocation: CGPoint
            @Binding var isPresented: Bool
            
            init(selectedUF: Binding<String?>, lastScale: Binding<CGFloat>, lastPanLocation: Binding<CGPoint>, isPresented:Binding<Bool>) {
                _selectedUF = selectedUF
                _lastScale = lastScale
                _lastPanLocation = lastPanLocation
                _isPresented = isPresented
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
                    let scaled = min(max(newScale * currentScale, 1), 10.0)
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
                        isPresented = true
                    }
                }
            }
            
            
            // Permitir gestos de zoom e pan simultaneamente
            func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
                return true
            }
        }
    }
}

#Preview {
    MapView(isPresented: true)
}
