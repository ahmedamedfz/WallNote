//
//  AddButton.swift
//  WallNote
//
//  Created by Ahmad Fariz on 22/05/23.
//

import SwiftUI

struct AddButton: View {
    @State var isExpanded = false
    
    var body: some View {
        HStack{
            VStack {
                Spacer()

                
                VStack(spacing: 16) {
                    MenuButtons(buttonImage: "square.and.pencil",destinationView: TextModalView())
                    MenuButtons(buttonImage: "paperclip",destinationView: LinkModalView())
                    MenuButtons(buttonImage: "photo",destinationView:GalleryModalView())
                    MenuButtons(buttonImage: "scribble",destinationView:DrawModalView())
                }
                .frame(height: isExpanded ? nil : 0, alignment: .top)
                .clipped()
                .padding(16)
                
                
                Button(action: {
                    print("Expandable button tapped!!!")
                    isExpanded.toggle()
                    
                }) {
                    ZStack{
                        Circle()
                            .frame(width: 74, height: 74)
                            .foregroundColor(.primaryColor)
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundColor(.secondaryColor)
                    }
                }
                
                
            }
            .animation(.interactiveSpring(blendDuration: 0.3), value: isExpanded)
            Spacer()
        }.padding(30)
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
