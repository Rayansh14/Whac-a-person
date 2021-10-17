//
//  HomePage.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 12/10/21.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Button(action: {
                startNewGame()
            }) {
                CustomButtonTextView(text: "Play")
            }
            VStack {
                Text("Home")
                    .bold()
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
        }
    }
}
