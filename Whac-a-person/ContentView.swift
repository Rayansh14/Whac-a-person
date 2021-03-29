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
    @State var timeRemaining = 100
    @State var imageData: Data?
    @State var showImagePicker = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if status == .home {
            HomePageView
        } else if status == .playing{
            PlayingView
        } else if status == .settings {
            settingsView
        } else {
            GameOverView
        }
    }
    
    
    var HomePageView: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Button(action: {
                status = .playing
                score = 0
                timeRemaining = 100
            }) {
                Text("Play")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(25)
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
                
                
                Button(action: {status = .gameOver}) {
                    Text("End Game")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(25)
                }
                .position(x: ((geometry.size.width/2)), y: (geometry.size.height/2))
                
                MoleView(score: $score, imageData: $imageData)
                    .position(x: (geometry.size.width/4), y: (geometry.size.height/3.5)*3)
                MoleView(score: $score, imageData: $imageData)
                    .position(x: ((geometry.size.width/4)*3), y: (geometry.size.height/3.5)*3)
                
                HStack {
                    VStack {
                        Text("Time: \(timeRemaining)")
                        Text("Score: \(score)")
                        Spacer()
                    }
                    .padding(5)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {status = .settings}) {
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
                status = .gameOver
            }
        }
    }
    
    
    var settingsView: some View {
        VStack {
            Button(action: {
                status = .playing
            }) {
                Text("Resume")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            Button(action: {showImagePicker = true}) {
                Text("Pick image to whac")
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(imageData: $imageData)
        }
        
    }
    
    
    var GameOverView: some View {
        VStack {
            Text("Score: \(score)")
            Button(action: {status = .home}) {
                Text("Home")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
