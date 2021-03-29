//
//  MoleView.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 28/03/21.
//

import SwiftUI

struct MoleView: View {
    
    var text: String = "Mole"
    @State var isShowing = false
    @Binding var score: Int
    @Binding var imageData: Data?
    let moleTimer = Timer.publish(every: [0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3, 1.4].randomElement()!, tolerance: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Ellipse()
                .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                .frame(width: 100, height: 60)
            
            ZStack {
                if image() != nil {
                    image()!
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(minWidth: 60, maxWidth: 80, minHeight: 100, maxHeight: 130)
                        .padding(.bottom, isShowing ? 60 : 20)
                    
                } else {
                    Image("person")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                        .padding(.bottom, isShowing ? 60 : 20)
                }
                Image("base2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            }
            .opacity(isShowing ? 1.0 : 0.0)
            .onTapGesture {
                isShowing = false
                score += 1
            }
            .animation(.easeOut(duration: 0.2))
        }
        .onReceive(moleTimer) { time in
            isShowing.toggle()
        }
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
