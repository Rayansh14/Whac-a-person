//
//  Testing.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 25/10/21.
//

import SwiftUI

struct Testing: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.75)
            
            VStack {
                Text("\("Not a great score 😬. Surely you can do better!")")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text("Score: \(13)")
                    .font(.title2)
                    .foregroundColor(.white)
                Button(action: {}) {
//                    CustomButtonTextView(text: "Home", font: Font.largeTitle, horizontalPadding: 25)
                }
            }
        }
    }
}


struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
