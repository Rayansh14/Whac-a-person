//
//  Testing.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 25/10/21.
//

import SwiftUI

struct Testing: View {
    var body: some View {
        HStack {
            CustomButtonTextView(text: "Main Menu", cornerRadius: 20, font: Font.title, padding: 12)
            
            CustomButtonTextView(text: "Resume", cornerRadius: 20, font: Font.title, padding: 12)
            
            CustomButtonTextView(text: "Restart", cornerRadius: 20, font: Font.title, padding: 12)
        }
        
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
