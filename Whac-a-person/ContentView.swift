//
//  ContentView.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 27/03/21.
//

import SwiftUI

enum UserStatus {
    case home, playing, gameOver
}

struct ContentView: View {
    
    @State var status = UserStatus.home
    @State var score = 0
    @State var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if status == .home {
            homePageView
        } else if status == .playing{
            playingView
        } else {
            gameOverView
        }
    }
    
    
    var homePageView: some View {
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
    
    
    var playingView: some View {
        GeometryReader { geometry in
            ZStack {
                
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                MoleView(score: $score)
                    .position(x: (geometry.size.width/4), y: (geometry.size.height/3.5))
                MoleView(score: $score)
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
                
                MoleView(score: $score)
                    .position(x: (geometry.size.width/4), y: (geometry.size.height/3.5)*3)
                MoleView(score: $score)
                    .position(x: ((geometry.size.width/4)*3), y: (geometry.size.height/3.5)*3)
                
                TimerView
                Text(geometry.size.width.description)
                
            }
        }
        .onReceive(timer) { time in
            if timeRemaining > 0 {
                timeRemaining -= 1
                score += 1
            } else {
                status = .gameOver
            }
        }
    }
    
    
    var gameOverView: some View {
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
    
    
    var TimerView: some View {
        HStack {
            VStack {
                Text("Time: \(timeRemaining)")
                Text("Score: \(score)")
                Spacer()
            }
            .padding(5)
            Spacer()
        }
    }
}


struct MoleView: View {
    
    var text: String = "Mole"
    @State var isShowing = true
    @Binding var score: Int
    
    var body: some View {
        ZStack {
            Ellipse()
                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                .frame(width: 100, height: 60)
            Button(action: {
                isShowing = false
                score += 1
            }) {
                ZStack {
                    Image("person")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                        .padding(.bottom, isShowing ? 60 : 20)
                    //                        .opacity(isShowing ? 1.0 : 0.0)
                    Image("base2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                    //                    Ellipse()
                    //                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    //                        .frame(width: 100, height: 60)
                }
            }
            .animation(.easeInOut(duration: 0.2))
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
