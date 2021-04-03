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
    var backgroundColor = Color.blue
    var cornerRadius: CGFloat = 25
    var font = Font.largeTitle
    var padding: CGFloat = 15
    
    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .font(font)
            .padding(padding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
    }
    
}

struct CustomButtonTextView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonTextView(text: "")
    }
}
