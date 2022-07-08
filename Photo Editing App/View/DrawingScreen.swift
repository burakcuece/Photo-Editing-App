//
//  DrawingScreen.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 07.07.22.
//

import SwiftUI
import PencilKit

struct DrawingScreen: View {
    @EnvironmentObject var model: DrawingViewModel
    @State private var showCameraPicker : Bool = false
    
    @State private var blurAmount = 0.0
    
    
    var body: some View {
        ZStack {
            GeometryReader { proxy -> AnyView in
                
                let size = proxy.frame(in: .global).size
                
                return AnyView(
                    
                    
                    
                    ZStack {
                        
                        CanvasView(canvas: $model.canvas, imageData: $model.imageData, toolPicker: $model.toolPicker, rect: size)
                        
                        ForEach(model.textBoxes) { box in
                            
                            Text(model.textBoxes[model.currentIndex].id == box.id && model.addNewBox ? "" : box.text)
                                .font(.system(size: 30))
                                .fontWeight(box.isBold ? .bold : .none)
                                .foregroundColor(box.textColor)
                                .offset(box.offset)
                                .gesture(DragGesture().onChanged({ (value) in
                                    
                                }).onEnded({ (value) in
                                    
                                    
                                }))
                        }
                    }
                )
            }
        }
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                
                Button {
                    
                } label: {
                    Text("Speichern")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                    model.textBoxes.append(TextBox())
                    
                    model.currentIndex = model.textBoxes.count - 1
                    
                    withAnimation {
                        model.addNewBox.toggle()
                    }
                    model.toolPicker.setVisible(false, forFirstResponder: model.canvas)
                    model.canvas.resignFirstResponder()
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        
    }
}
