//
//  ContentView.swift
//  WallNote
//
//  Created by Ahmad Fariz on 22/05/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    @EnvironmentObject var arviewModel: ARViewModel
    
    var body: some View {
        ZStack{
            ARViewContainer().edgesIgnoringSafeArea(.all)
            AddButton()
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var arviewModel: ARViewModel
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        context.coordinator.view = arView
        return arView
    }
    
    func makeCoordinator() -> Coordinator {
            Coordinator(arviewModel: arviewModel)
        }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

class Coordinator: NSObject {
        let arviewModel: ARViewModel
        
        init(arviewModel: ARViewModel) {
            self.arviewModel = arviewModel
        }
    @ObservedObject var imageViewModel = GalleryModalViewModel()
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let view = self.view else { return }
        
        let tapLocation = recognizer.location(in: view)
        let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .vertical)
        
        if let result = results.first {
            
            let anchorEntity = AnchorEntity(raycastResult: result)
            
            let modelEntity = ModelEntity(mesh: MeshResource.generatePlane(width: 2, depth: 2))
            modelEntity.generateCollisionShapes(recursive: true)
            
            modelEntity.model?.materials = [caseMissingImage(capturedImage: arviewModel.retrieveImage()?.cgImage)]
            anchorEntity.addChild(modelEntity)
            view.scene.addAnchor(anchorEntity)
            
            view.installGestures(.all, for: modelEntity)
        }
    }
        func caseMissingImage(capturedImage:CGImage?)-> SimpleMaterial{
            if capturedImage == nil {
                return SimpleMaterial(color: .white, isMetallic: false)
            }
            else
            {
                let texture = try! TextureResource.generate(from: capturedImage!, options: .init(semantic: .normal))
                let paperMaterial = createPaperMaterial(withTexture: texture)
                return paperMaterial
            }
        }
    func createPaperMaterial(withTexture texture: TextureResource) -> SimpleMaterial {
        var paperMaterial = SimpleMaterial()
        paperMaterial.color = .init(texture: .init(texture))
        paperMaterial.metallic = .float(0)
        paperMaterial.roughness = .float(1)
        
        return paperMaterial
    }

}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
