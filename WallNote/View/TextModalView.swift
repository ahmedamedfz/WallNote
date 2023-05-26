//
//  TextModalView.swift
//  WallNote
//
//  Created by Ahmad Fariz on 22/05/23.
//

import SwiftUI
import UIKit


struct TextModalView: View {
    @StateObject var viewModel = TextModalViewModel()
    @StateObject private var arviewModel: ARViewModel
    @Environment(\.managedObjectContext) private var viewContext

    init() {
        let arViewModel = ARViewModel(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        self._arviewModel = StateObject(wrappedValue: arViewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                    textView
                VStack {
                    HStack(spacing: 10) {
                        Spacer()
                        Button(action: {
                            arviewModel.capturedImage = saveImageTexture(text: viewModel.text)
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
    
    var textView: some View {
        Group{
            if viewModel.isEditing {
                TextField("typehere", text: $viewModel.text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.secondaryColor)
                    .keyboardType(.alphabet)
                    .onSubmit {
                        viewModel.isEditing = false
                    }
            } else {
                TextView(text: viewModel.text)
                    .onTapGesture { viewModel.isEditing = true }
                    .foregroundColor(.secondaryColor)
            }
        }
    }
    
//    func captureImage(arviewModel: ARViewModel) {
//        DispatchQueue.main.async {
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                  let window = windowScene.windows.first else { return }
//            let bounds = window.bounds
//            let renderer = UIGraphicsImageRenderer(bounds: bounds)
//            let uiImage = renderer.image { context in
//                window.rootViewController?.view.drawHierarchy(in: bounds, afterScreenUpdates: true)
//            }
//            arviewModel.capturedImage = uiImage
//        }
//    }
    private func createImageTexture(text: String)-> some View{
        VStack{
            TextView(text: text)
        }
        .multilineTextAlignment(.center)
        .frame(width: 1000, height: 1000)
    }
    private func saveImageTexture(text:String)-> UIImage{
        let printedView = createImageTexture(text: text)
        let renderer = ImageRenderer(content: printedView)
        guard let image = renderer.uiImage else { return UIImage(imageLiteralResourceName: "Image") }
        return image
    }
}




struct TextView:View {
    var text:String
    var body : some View{
        Text(text).font(.system(size: 30))
    }
}


struct TextModalView_Previews: PreviewProvider {
    static var previews: some View {
        TextModalView()
    }
}
