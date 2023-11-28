//
//  MenuButton.swift
//  WallNote
//
//  Created by Ahmad Fariz on 22/05/23.
//

import SwiftUI

struct MenuButtons<Destination: View>: View {
    var buttonImage: String
    var destinationView: Destination
    
    @State var isShowingView = false
    
    var body: some View {
        HStack{
            Spacer()
            
            Button(action: {
                isShowingView = true
            }) {
                ZStack {
                    Circle()
                        .foregroundColor(.primaryColor)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: buttonImage)
                        .imageScale(.large)
                        .foregroundColor(.secondaryColor)
                }
            }
        }
        .sheet(isPresented: $isShowingView,onDismiss: {isShowingView = false}){
                destinationView
                    .presentationDetents([.medium])
        }
    }
}

