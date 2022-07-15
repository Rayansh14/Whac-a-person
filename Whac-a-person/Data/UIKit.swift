//
//  ImagePicker.swift
//  Whac-a-person
//
//  Created by Rayansh Gupta on 01/11/21.
//

import SwiftUI
import UIKit
import WebKit


struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var imageData: Data?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.allowsEditing = true
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.editedImage] as? UIImage {
                var actualHeight = Float(uiImage.size.height)
                var actualWidth = Float(uiImage.size.width)
                let maxHeight: Float = 300.0
                let maxWidth: Float = 300.0
                var imgRatio: Float = actualWidth / actualHeight
                let maxRatio: Float = maxWidth / maxHeight
                let compressionQuality: Float = 1
                
                if actualHeight > maxHeight || actualWidth > maxWidth {
                    if imgRatio < maxRatio { // if width is less than height
                        imgRatio = maxHeight / actualHeight
                        actualWidth = imgRatio * actualWidth
                        actualHeight = maxHeight
                    }
                    else if imgRatio > maxRatio { // if width is more than height
                        imgRatio = maxWidth / actualWidth
                        actualHeight = imgRatio * actualHeight
                        actualWidth = maxWidth
                    }
                    else { // if width and height are same
                        actualHeight = maxHeight
                        actualWidth = maxWidth
                    }
                }
                let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
                UIGraphicsBeginImageContext(rect.size)
                uiImage.draw(in: rect)
                let img = UIGraphicsGetImageFromCurrentImageContext()
                let compressedImageData = img?.jpegData(compressionQuality: CGFloat(compressionQuality))
                UIGraphicsEndImageContext()
                parent.imageData = compressedImageData // this uses the fact that classes are reference types
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct GifImage: UIViewRepresentable {
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
    
}
