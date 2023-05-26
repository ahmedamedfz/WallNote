//
//  FileModalView.swift
//  WallNote
//
//  Created by Ahmad Fariz on 22/05/23.
//

import SwiftUI
import FilePicker

struct FileModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isFilePickerPresented = false
    @StateObject var viewModel = FileModalViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                Button(action: {
                    isFilePickerPresented.toggle()
                }, label: {
                    Text("Select File")
                })
                .fileImporter(isPresented: $isFilePickerPresented, allowedContentTypes: [.item], onCompletion: viewModel.handleFileSelection)
                
                if let fileURL = viewModel.selectedFile {
                    Image(systemName: "doc.fill")
                    Text(fileURL.lastPathComponent)
                        .padding()
                }
            }
        }
    }
}


struct FileModalView_Previews: PreviewProvider {
    static var previews: some View {
        FileModalView()
    }
}
