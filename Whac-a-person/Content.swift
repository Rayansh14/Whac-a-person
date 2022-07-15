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

let gifImageWidth: CGFloat = 300.0

struct ContentView: View {
    
    @State var status = UserStatus.home
    @State var score = 0
    @State var timeRemaining = 0
    var defaultTimeRemaining = 30
    @State var rotateHammer = false
    @State var imageData: Data?
    @State var showImagePicker = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if status == .home {
            HomePageView
        } else if status == .playing {
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
            HStack {
                GifImage("whack")
                    .frame(width: gifImageWidth, height: gifImageWidth*0.88)
                    .padding(.top, 40)
                Button(action: {
                    startNewGame()
                }) {
                    CustomButton(text: "Play", font: .system(size: 30), horizontalPadding: 20, verticalPadding: 15)
                }
            }
            VStack {
                Text("Whack-a-person")
                    .bold()
                    .font(.system(size: 40))
                    .foregroundColor(.black)
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
                
                HStack {
                    Spacer()
                    MoleView(score: $score, imageData: $imageData)
                    Spacer()
                    MoleView(score: $score, imageData: $imageData)
                    Spacer()
                }
                .position(x: geometry.size.width/2, y: geometry.size.height/3.5)
                
                HStack {
                    Spacer()
                    MoleView(score: $score, imageData: $imageData)
                    Spacer()
                    Spacer()
                    MoleView(score: $score, imageData: $imageData)
                    Spacer()
                    Spacer()
                    MoleView(score: $score, imageData: $imageData)
                    Spacer()
                }
                .position(x: geometry.size.width/2, y: geometry.size.height/1.75)
                
                HStack {
                    Spacer()
                    MoleView(score: $score, imageData: $imageData)
                    Spacer()
                    MoleView(score: $score, imageData: $imageData)
                    Spacer()
                }
                .position(x: geometry.size.width/2, y: geometry.size.height/3.5*3)
                
                VStack {
                    HStack {
                        
                        Text("SCORE\n")
                        //                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.black)
                        +
                        Text("\(score)")
                        //                            .foregroundColor(.white)
                            .font(.system(size: 35))
                            .fontWeight(.black)
                        
                        Spacer()
                        
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
                        
                        GameTimer(timeRemaining: $timeRemaining, totalTime: defaultTimeRemaining)
                    }
                    Spacer()
                }
                .padding(.vertical, 10)
                
                //                HStack {
                //                    VStack {
                //                        Text("Time: \(timeRemaining)")
                //                        Spacer()
                //                    }
                //                    .foregroundColor(.black)
                //                    .padding(5)
                //                    Spacer()
                //                }
                //
                //                HStack {
                //                    Spacer()
                //                    VStack {
                //
                //                        Spacer()
                //                    }
                //                    Spacer()
                //                }
                
                
                
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
                
                HStack {
                    
                    VStack(spacing: 12) {
                        Button(action: {
                            status = .playing
                        }) {
                            SettingsButton(text: "RESUME", imageName: "play.circle.fill")
                        }
                        
                        Button(action: {
                            startNewGame()
                        }) {
                            SettingsButton(text: "RESTART", imageName: "gobackward")
                        }
                        
                        Button(action: {
                            status = .home
                        }) {
                            SettingsButton(text: "MAIN MENU", imageName: "rectangle.portrait.and.arrow.right.fill")
                        }
                    }
                    .padding(.horizontal, 50)
                    
                    VStack {
                        Button(action: {showImagePicker = true}) {
                            SettingsButton(text: "Pick image to whack")
                        }
                        
                        if let image = image() {
                            Button(action: {
                                showImagePicker = true
                            }) {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(8)
                                    .frame(maxHeight: 210)
                                    .padding(.vertical, 10)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .padding(.bottom, -5)
                            
                            
                            Button(action: {
                                imageData = nil
                            }) {
                                SettingsButton(text: "Reset photo")
                            }
                        }
                        
                    }
                    .padding(.horizontal, 50)
                    
                }
                .padding(.vertical, 35)
                .position(x: geometry.size.width/2, y: geometry.size.height/2)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(imageData: $imageData)
                }
                //                GameInfoDisplayView
            }
        }
    }
    
    
    var GameOverView: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .opacity(0.75)
            
            VStack {
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title2)
                Text("\(score < 20 ? "Not a great score 😬. Surely you can do better!" : "Seems like you're a pro 😎!!!")")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .foregroundColor(.white)
                Button(action: {
                    status = .home
                }) {
                    CustomButton(text: "Home", font: Font.largeTitle, horizontalPadding: 25, verticalPadding: 12)
                }
            }
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
        ContentView(status: UserStatus.home)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
