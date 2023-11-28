//
//  FileModalViewModel.swift
//  WallNote
//
//  Created by Ahmad Fariz on 24/05/23.
//

import Foundation
import SwiftUI

class FileModalViewModel: ObservableObject {
    @Published var selectedFile: URL?
    
    func handleFileSelection(result: Result<URL, Error>) {
        switch result {
        case .success(let url):
            selectedFile = url
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

