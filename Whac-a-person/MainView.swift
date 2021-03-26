//
//  MainView.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 25/03/21.
//

import SwiftUI

struct MainView: View {
    
    @State var isPlaying = false
    
    var body: some View {
        if isPlaying == false {
            homePageView
        } else {
            playingView
        }
    }
    
    
    var homePageView: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            Button(action: {isPlaying = true}) {
                Text("Play")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(25)
            }
        }
    }
    
    
    var playingView: some View {
        ZStack {
            
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                Spacer()
                HStack {
                    Spacer()
                    MoleView()
                    Spacer()
                    Spacer()
                    MoleView()
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {isPlaying = false}) {
                        Text("Home")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    MoleView()
                    Spacer()
                    Spacer()
                    MoleView()
                    Spacer()
                }
                Spacer()
            }
        }
    }
}


struct MoleView: View {
    
    var text: String = "Mole"
    @State var isShowing = true
    
    var body: some View {
        ZStack {
            Ellipse()
                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                .frame(width: 100, height: 60)
            Button(action: {isShowing = false}) {
                ZStack {
                    Image("person")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                        .padding(.bottom, 60)
                    Ellipse()
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .frame(width: 100, height: 60)
                }
            }
            .opacity(isShowing ? 1.0 : 0.0)
            .animation(.easeIn(duration: 2.0))
        }
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
