//
//  CanvasView.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 07.07.22.
//

import SwiftUI
import UIKit
import PencilKit

struct CanvasView: UIViewRepresentable {
    
    @Binding var canvas: PKCanvasView
    @Binding var imageData: Data
    @Binding var toolPicker: PKToolPicker
    
    var rect: CGSize
    
    func makeUIView(context: Context) ->PKCanvasView {
        canvas.drawingPolicy = .anyInput
        
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        
        if let image = UIImage(data: imageData) {
            
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)
            
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
        }
        
        return canvas
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
       
    }
}
