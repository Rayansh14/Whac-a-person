//
//  CustomeButtonTextView.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 31/03/21.
//

import SwiftUI

struct CustomButtonTextView: View {
    
    var text: String
    var foregroundColor = Color.white
    var backgroundColor = Color("green")
    var cornerRadius: CGFloat = 10
    var font = Font.largeTitle
    var padding: CGFloat = 15
    
    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(font)
            .padding(padding)
            .background(
                LinearGradient(colors: [Color.green, Color("green")], startPoint: .bottom, endPoint: .top)
            )
            .cornerRadius(cornerRadius)
            .shadow(color: Color.gray, radius: 5, x: -5, y: 5)
    }
    
}

struct CustomButtonTextView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonTextView(text: "Restart")
    }
}
