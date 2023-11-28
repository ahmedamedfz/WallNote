//
//  CoreDataDebugView.swift
//  WallNote
//
//  Created by Ahmad Fariz on 26/05/23.
//

import SwiftUI

struct CoreDataDebugView: View {
    // Fetch request to retrieve all images from Core Data
    @FetchRequest(
        entity: ImageModel.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ImageModel.order, ascending: true)]
    ) var images: FetchedResults<ImageModel>
    
    var body: some View {
        List(images) { image in
            if let filePath = image.filePath,
               let uiImage = UIImage(contentsOfFile: filePath) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}
struct CoreDataDebugView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataDebugView()
    }
}
