//
//  LinkModalView.swift
//  WallNote
//
//  Created by Ahmad Fariz on 24/05/23.
//

import SwiftUI
import LinkPresentation

struct LinkModalView: View {
    @State private var urlString = ""
    @State private var url: URL?
    @StateObject private var arviewModel: ARViewModel
    @Environment(\.managedObjectContext) private var viewContext

    init() {
        let arViewModel = ARViewModel(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        self._arviewModel = StateObject(wrappedValue: arViewModel)
    }
    var body: some View {
        ZStack{
            VStack {
                TextField("Enter URL", text: $urlString, onCommit: {
                    url = URL(string: urlString)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .foregroundColor(.secondaryColor)
                
                if let url = url {
                    LinkView(url: url)
                }
            }
            VStack {
                HStack(spacing: 10) {
                    Spacer()
                    Button(action: {
                        arviewModel.capturedImage = saveImageTexture(url: url!)
                        
                    }) {
                        Text("Done")
                            .foregroundColor(.secondaryColor)
                    }.disabled(url == nil)
                }
                .padding(20)
                Spacer()
            }
        }
        .onAppear {
        }
    }
    
    private func createImageTexture(url: URL)-> some View{
        VStack{
            LinkView(url: url)
        }
        .multilineTextAlignment(.center)
        .frame(width: 1000, height: 1000)
    }
    private func saveImageTexture(url:URL)-> UIImage{
        let printedView = createImageTexture(url: url)
        let renderer = ImageRenderer(content: printedView)
        guard let image = renderer.uiImage else { return UIImage(imageLiteralResourceName: "Image") }
        return image
    }
}

struct LinkView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> LPLinkView {
        let linkView = LPLinkView(url: url)
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url) { metadata, error in
            if let metadata = metadata {
                DispatchQueue.main.async {
                    linkView.metadata = metadata
                }
            }
        }
        return linkView
    }
    
    func updateUIView(_ uiView: LPLinkView, context: Context) {}
}


struct LinkModalView_Previews: PreviewProvider {
    static var previews: some View {
        LinkModalView()
    }
}
