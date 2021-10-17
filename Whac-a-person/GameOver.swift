//
//  GameOver.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 12/10/21.
//

import SwiftUI

struct GameOverView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .ignoresSafeArea()
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .opacity(0.3)
                VStack {
                    Text("Score: \(score)")
                    Button(action: {status = .home}) {
                        CustomButtonTextView(text: "Home")
                    }
                }
                .position(x: geometry.size.width/2, y: geometry.size.height/2)
            }
        }
    }
}
