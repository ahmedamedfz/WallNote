//
//  GalleryModalViewModel.swift
//  WallNote
//
//  Created by Ahmad Fariz on 24/05/23.
//
import SwiftUI
import PhotosUI

class GalleryModalViewModel: ObservableObject {
    @Published var selection: PhotosPickerItem?
    @Published var image: UIImage?
    
    func loadImage() {
        guard let item = selection else { return }
        item.loadTransferable(type: ImageDrawer.self) { result in
            switch result {
            case .success(let imageDrawer?):
                DispatchQueue.main.async {
                    self.image = imageDrawer.image
                }
            case .success(nil), .failure:
                break
            }
        }
    }
}

struct ImageDrawer: Transferable {
    let image: UIImage
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw TransferError.importFailed
            }
            
            return ImageDrawer(image: uiImage)
        }
    }
}

enum TransferError: Error {
    case importFailed
}
