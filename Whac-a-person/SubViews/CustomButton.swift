//
//  CustomButton.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 07/07/22.
//

import SwiftUI


struct CustomButton: View {
    
    var text: String
    var foregroundColor = Color.white
    var backgroundColor = Color("green")
    var cornerRadius: CGFloat = 10
    var font = Font.system(size: 21)
    var horizontalPadding: CGFloat = 18
    var verticalPadding: CGFloat = 9
    
    var body: some View {
        Text(text)
            .fontWeight(.semibold)
            .foregroundColor(foregroundColor)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .font(font)
            .background(
                LinearGradient(colors: [Color("dark green"), Color("light green")], startPoint: .bottom, endPoint: .top)
            )
            .cornerRadius(cornerRadius)
            .shadow(color: Color.gray, radius: 4, x: 4, y: 4)
    }
}


struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "Play")
    }
}
