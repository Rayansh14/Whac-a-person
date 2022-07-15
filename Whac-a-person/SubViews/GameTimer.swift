//
//  GameTimer.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 01/07/22.
//

import SwiftUI

struct GameTimer: View {
    
    @Binding var timeRemaining: Int
    var totalTime = 25
    var circleDimension: CGFloat = 45
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.black, lineWidth: 1)
                .frame(width: circleDimension, height: circleDimension)
            
            Circle()
                .trim(from: 0, to: (Double(timeRemaining)/Double(totalTime)))
                .stroke(.blue, lineWidth: 7)
                .rotationEffect(.degrees(-90))
                .frame(width: circleDimension, height: circleDimension)
                .animation(.spring(), value: timeRemaining)
            
            Text(String(timeRemaining))
                .font(.system(size: 18))
                .bold()
        }
        .background(
            Circle()
                .foregroundColor(.white)
                .opacity(0.6)
        )
    }
}

struct GameTimer_Previews: PreviewProvider {
    static var previews: some View {
        GameTimer(timeRemaining: .constant(12))
    }
}
