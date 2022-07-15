//
//  MoleView.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 28/03/21.
//

import SwiftUI
import AVFoundation

var player: AVAudioPlayer!

struct MoleView: View {
    
    
    @State var isShowing = false
    @State var showExplosion = false
    @State var rotateHammer = false
    @State var showHammer = false
    @Binding var score: Int
    @Binding var imageData: Data?
    
    let moleTimer = Timer.publish(every: [0.5, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2].randomElement()!, tolerance: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Ellipse()
                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                .frame(width: 100, height: 60)
            
            ZStack {
                image()
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(2)
                    .frame(minWidth: 60, maxWidth: 80, minHeight: 80, maxHeight: 105)
                    .padding(.bottom, isShowing ? 60 : 20)
                
                Image("base2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            }
            .opacity(isShowing ? 1.0 : 0.0)
            .onTapGesture {
                if !showHammer && isShowing {
                    showHammer = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) {
                        playSound(fileName: "shorterTestSound")
                        score += 1
                        showExplosion = true
                        rotateHammer = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                            isShowing = false
                            showExplosion = false
                            rotateHammer = false
                            showHammer = false
                        }
                    }
                }
            }
            .animation(.easeOut(duration: 0.15), value: isShowing)
            
            ZStack {
                
                Image("hammer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .rotationEffect(.degrees(rotateHammer ? -30 : 0), anchor: .bottomTrailing)
                    .padding(.bottom, 175)
                    .padding(.leading, 60)
                    .opacity(showHammer ? 1 : 0)
                
                Image("explosion")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 130)
                    .padding(.leading, 5)
                    .opacity(showExplosion ? 1 : 0)
                
                Text("Die!!!!") // choose random out of a bunch of string, other can be like 'good riddance', etc
                    .font(.system(size: 25, weight: .heavy))
                    .foregroundColor(.white)
                    .opacity((showExplosion && [true, false, true].randomElement()!) ? 1 : 0)
                    .offset(y: showExplosion ? -90 : -40)
                    .animation(.easeOut(duration: 0.3), value: showExplosion)
            }
            .opacity(showHammer ? 1 : 0)
        }
        .onReceive(moleTimer) { time in
            isShowing = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(900)) {
                if !showHammer { // otherwise image disappears and hammer whacks empty space
                    isShowing = false
                }
                
            }
        }
    }
    
    
    func image() -> Image {
        if let data = imageData {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return Image("person")
    }
    
    
    func playSound(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "wav")
        
        if url != nil {
            do {
                player = try AVAudioPlayer(contentsOf: url!)
                player.play()
            } catch {
                print(error)
            }
        }
    }
}
