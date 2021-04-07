//
//  TestView.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 02/04/21.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Color.gray
            .gesture(DragGesture(minimumDistance: 0).onEnded({ (value) in
                print(value.location) // Location of the tap, as a CGPoint.
            }))
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

