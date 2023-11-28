//
//  MainView.swift
//  WallNote
//
//  Created by Ahmad Fariz on 26/05/23.
//

import SwiftUI
import CoreData

struct MainView: View {
    @StateObject var arviewModel: ARViewModel
    
    init(context: NSManagedObjectContext) {
        _arviewModel = StateObject(wrappedValue: ARViewModel(context: context))
    }
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Rectangle()
                    .foregroundColor(.primaryColor)
                    .frame(height: 100)
            }
            TabView {
                ContentView()
                    .environmentObject(arviewModel)
                    .tabItem {
                        RoundedRectangle(cornerRadius: 10)
                        Label("New Notes", systemImage: "square.and.pencil")
                    }
                
                CoreDataDebugView()
                    .tabItem {
                        RoundedRectangle(cornerRadius: 10)
                        Label("Debug", systemImage: "photo.on.rectangle")
                    }
            }.tint(.secondaryColor)
        }
    }
}


//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(context: persistentContainer.viewContext)
//    }
//}
