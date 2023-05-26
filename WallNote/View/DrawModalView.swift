//
//  DrawModalView.swift
//  WallNote
//
//  Created by Ahmad Fariz on 25/05/23.
//

import SwiftUI
import UIKit
import PencilKit

struct DrawModalView: View {
    @StateObject var viewModel = DrawModalViewModel()
    @StateObject private var arviewModel: ARViewModel
    @Environment(\.managedObjectContext) private var viewContext

    init() {
        let arViewModel = ARViewModel(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        self._arviewModel = StateObject(wrappedValue: arViewModel)
    }
    var body: some View {
        NavigationView {
            ZStack {
                    drawView
                VStack {
                    HStack(spacing: 10) {
                        Spacer()
                        Button(action: {
                            convertPencilKitViewToImage()
                            
                        }) {
                            Text("Done")
                                .foregroundColor(.secondaryColor)
                        }
                    }
                    .padding(20)
                    Spacer()
                }
            }
            .onAppear {
            }
        }
    }
    var drawView: some View {
        Group{
            DrawingView(canvasView: $viewModel.canvasView)
        }
    }
    func convertPencilKitViewToImage(){
        if let image = viewModel.canvasView.asImage(){
            // save the image to user defaults or perform any further operations
            arviewModel.capturedImage = image
        }
    }
}
struct DrawingView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}


struct DrawModalView_Previews: PreviewProvider {
    static var previews: some View {
        DrawModalView()
    }
}
