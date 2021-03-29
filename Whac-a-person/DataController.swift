//
//  DataController.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 28/03/21.
//

import Foundation
import SwiftUI

class DataController: ObservableObject {
    static var shared = DataController()
    @Published var imageData: Data?
    
    func image() -> Image? {
        if let data = imageData {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return nil
    }
}


class whacImage: ObservableObject {
    @Published var imageData: Data?
    
    func image() -> Image? {
        if let data = imageData {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return nil
    }
}
