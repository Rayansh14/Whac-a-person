//
//  CustomeButtonTextView.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 31/03/21.
//

import SwiftUI

struct SettingsButton: View {
    
    var text: String
    var imageName: String?
    var foregroundColor = Color.white
    var backgroundColor = Color("green")
    var cornerRadius: CGFloat = 10
    var font = Font.system(size: 21)
    var frameHeight: CGFloat = 45
    
    var body: some View {
        HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .foregroundColor(.white)
                    .font(font)
                    .imageScale(.large)
                    .frame(width: frameHeight, height: frameHeight)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .foregroundColor(Color("dark green"))
                    )
            }
            
            Text(text)
                .fontWeight(.semibold)
                .foregroundColor(foregroundColor)
                .font(font)
                .frame(height: frameHeight)
                .padding(.horizontal, 12)
                .if(imageName != nil) { view in
                    view.frame(width: 150)
                }
                .background(Color("dark green"))
                .cornerRadius(cornerRadius)
        }
        .shadow(color: Color.gray, radius: 2, x: 2, y: 2)
    }
}

struct CustomButtonTextView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(text: "Resume", imageName: "play.circle.fill")
    }
}
