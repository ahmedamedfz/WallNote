//
//  DrawModalViewModel.swift
//  WallNote
//
//  Created by Ahmad Fariz on 25/05/23.
//

import Foundation
import PencilKit
import SwiftUI

class DrawModalViewModel: ObservableObject{
    @Published var canvasView = PKCanvasView()
}

extension PKCanvasView {
    func asImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        
        let image = renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}
