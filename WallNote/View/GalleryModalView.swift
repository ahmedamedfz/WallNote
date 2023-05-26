//
//  GaleryModalView.swift
//  WallNote
//
//  Created by Ahmad Fariz on 22/05/23.
//

import SwiftUI
import PhotosUI
import CoreTransferable

struct GalleryModalView: View {
    @StateObject var viewModel = GalleryModalViewModel()
        @StateObject private var arviewModel: ARViewModel
        @Environment(\.managedObjectContext) private var viewContext

        init() {
            let arViewModel = ARViewModel(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
            self._arviewModel = StateObject(wrappedValue: arViewModel)
        }
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    if let image = viewModel.image {
                        ImageView(image: image) // print this
                    }
                    
                    PhotosPicker(selection: $viewModel.selection) {
                        Text("Select Photo")
                            .foregroundColor(.secondaryColor)
                    }
                    .onChange(of: viewModel.selection) { _ in
                        viewModel.loadImage()
                    }
                }
                VStack {
                    HStack(spacing: 10) {
                        Spacer()
                        Button(action: {
                            arviewModel.capturedImage = viewModel.image
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
}

struct ImageView: View{
    var image:UIImage
    var body: some View{
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
    }
}


struct GalleryModalView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryModalView()
    }
}
