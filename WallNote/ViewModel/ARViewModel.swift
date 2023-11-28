//
//  ARViewModel.swift
//  WallNote
//
//  Created by Ahmad Fariz on 23/05/23.
//

import Foundation
import RealityKit
import UIKit
import CoreData

class ARViewModel: ObservableObject {
    let context: NSManagedObjectContext
      @Published var capturedImage: UIImage? {
          didSet {
              saveImage()
          }
      }
      
      init(context: NSManagedObjectContext) {
          self.context = context
      }

//    // Reference to the managed object context
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // Function to save the captured image to Core Data
    func saveImage() {
        // Get the documents directory URL
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Create a unique file name for the image
        let fileName = UUID().uuidString
        
        // Create the full file path
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        // Save the image to the local storage
        if let data = capturedImage?.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: fileURL)
            } catch {
                print("Error saving image to local storage: \(error)")
            }
        }
        
        // Create a new Image entity
        let newImage = ImageModel(context: context)
        
        // Set the image file path
        newImage.filePath = fileURL.path
        
        // Set the order attribute
        newImage.order = getNextOrder()
        
        // Save the context
        do {
            try context.save()
        } catch {
            print("Error saving image: \(error)")
        }
    }


    // Function to retrieve the last captured image from Core Data
    func retrieveImage() -> UIImage? {
        // Create a fetch request for the Image entity
        let request = NSFetchRequest<ImageModel>(entityName: "ImageModel")
        
        // Sort the results by order, in descending order
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        // Fetch the results
        do {
            let results = try context.fetch(request)
            
            // Check if there are any results
            if let firstResult = results.first,
               let filePath = firstResult.filePath,
               let image = UIImage(contentsOfFile: filePath) {
                return image
            }
        } catch {
            print("Error retrieving image: \(error)")
        }
        
        return nil
    }


    // Function to get the next order value for a new image
    func getNextOrder() -> Int64 {
        // Create a fetch request for the Image entity
        let request = NSFetchRequest<ImageModel>(entityName: "ImageModel")
        // Sort the results by order, in descending order
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        // Fetch the results
        do {
            let results = try context.fetch(request)
            // Check if there are any results
            if let firstResult = results.first {
                return firstResult.order + 1
            }
        } catch {
            print("Error retrieving next order value: \(error)")
        }
        return 0
    }
}




