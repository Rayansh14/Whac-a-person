//
//  Settings.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 12/10/21.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .background(Color.white)
                    .opacity(0.3)
                
                VStack {
                    Button(action: {showImagePicker = true}) {
                        Text("Pick image to whack")
                            .font(.system(size: 20))
                    }
                    if image() != nil {
                        image()!
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 150, maxWidth: 200, maxHeight: 250)
                            .padding(0)
                    }
                    
                    HStack {
                        Button(action: {
                            status = .playing
                        }) {
                            CustomButtonTextView(text: "Resume", cornerRadius: 20, font: Font.title, padding: 12)
                        }
                        
                        Button(action: {
                            startNewGame()
                        }) {
                            CustomButtonTextView(text: "Restart", cornerRadius: 20, font: Font.title, padding: 12)
                        }
                        
                        Button(action: {
                            status = .home
                        }) {
                            CustomButtonTextView(text: "Main Menu", cornerRadius: 20, font: Font.title, padding: 12)
                        }
                    }
                    .padding(.top, 5)
                }
                .position(x: geometry.size.width/2, y: geometry.size.height/2)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(imageData: $imageData)
                }
                GameInfoDisplayView
            }
        }
}
