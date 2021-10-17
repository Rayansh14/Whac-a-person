//
//  ContentView.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 27/03/21.
//

import SwiftUI

enum UserStatus {
    case home, playing, settings, gameOver
}


struct ContentView: View {
    
    @State var status = UserStatus.home
    @State var score = 0
    @State var timeRemaining = 0
    @State var defaultTimeRemaining = 25
    @State var rotateHammer = false
    @State var imageData: Data?
    @State var showImagePicker = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if status == .home {
            HomePageView
        } else if status == .playing{
            PlayingView
        } else if status == .settings {
            SettingsView
        } else {
            GameOverView
        }
    }
    
    
    var HomePageView: some View {
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
    
    
    var PlayingView: some View {
        GeometryReader { geometry in
            ZStack {
                
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                MoleView(score: $score, imageData: $imageData)
                    .position(x: (geometry.size.width/4), y: (geometry.size.height/3.5))
                MoleView(score: $score, imageData: $imageData)
                    .position(x: ((geometry.size.width/4)*3), y: (geometry.size.height/3.5))
                
                MoleView(score: $score, imageData: $imageData)
                    .position(x: geometry.size.width/2, y: geometry.size.height/1.88)
                
                MoleView(score: $score, imageData: $imageData)
                    .position(x: (geometry.size.width/4), y: (geometry.size.height/3.5)*3)
                MoleView(score: $score, imageData: $imageData)
                    .position(x: ((geometry.size.width/4)*3), y: (geometry.size.height/3.5)*3)
                
                GameInfoDisplayView
                
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            status = .settings
                        }) {
                            Image(systemName: "gear")
                                .padding(8)
                                .foregroundColor(.gray)
                                .font(.largeTitle)
                                .background(Color.clear)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                
            }
        }
        .onReceive(timer) { time in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                DataController.shared.saveScore(score: score)
                status = .gameOver
            }
        }
    }
    
    
    var SettingsView: some View {
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
                        
                        Button(action: {
                            imageData = nil
                        }) {
                            CustomButtonTextView(text: "Reset photo", cornerRadius: 20, font: Font.title, padding: 12)
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
    
    
    var GameOverView: some View {
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
    
    
    var GameInfoDisplayView: some View {
        HStack {
            VStack {
                Text("Time: \(timeRemaining)")
                Text("Score: \(score)")
                Spacer()
            }
            .foregroundColor(.black)
            .padding(5)
            Spacer()
        }
    }
    
    
    var PastScoresView: some View {
        VStack{
            ForEach(DataController.shared.pastScores, id: \.self) { score in
                Text(String(score))
            }
        }
    }
    
    
    func startNewGame() {
        score = 0
        timeRemaining = defaultTimeRemaining
        status = .playing
    }
    
    
    func image() -> Image? {
        if let data = imageData {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
