//
//  MainView.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 25/03/21.
//
/*
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



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
*/
