//
//  TextModalViewModel.swift
//  WallNote
//
//  Created by Ahmad Fariz on 24/05/23.
//

import Foundation
import SwiftUI
import PencilKit

class TextModalViewModel: ObservableObject {
    @Published var text = "typehere"
    @Published var isEditing = false
    @Published var isDrawing = false
    func commitChanges() {
        // Commit changes and export view as image for use as texture in AR
    }
}
