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
            
            GeometryReader{proxy -> AnyView in
                
                let size = proxy.frame(in: .global)
                
                DispatchQueue.main.async {
                    if model.rect == .zero{
                        model.rect = size
                    }
                }
                
                return AnyView(
                
                    ZStack{
                        
                        CanvasView(canvas: $model.canvas, imageData: $model.imageData, toolPicker: $model.toolPicker,rect: size.size)
                        
                        
                        ForEach(model.textBoxes){box in
                            
                            Text(model.textBoxes[model.currentIndex].id == box.id && model.addNewBox ? "" : box.text)
                                .font(.system(size: 30))
                                .fontWeight(box.isBold ? .bold : .none)
                                .foregroundColor(box.textColor)
                                .offset(box.offset)
                                .gesture(DragGesture().onChanged({ (value) in
                                    
                                    let current = value.translation
                                    // Adding with last Offset...
                                    let lastOffset = box.lastOffset
                                    let newTranslation = CGSize(width: lastOffset.width + current.width, height: lastOffset.height + current.height)
                                    
                                    model.textBoxes[getIndex(textBox: box)].offset = newTranslation
                                    
                                }).onEnded({ (value) in
                                    
                                    model.textBoxes[getIndex(textBox: box)].lastOffset = model.textBoxes[getIndex(textBox: box)].offset
                                    
                                }))
                                .onLongPressGesture {
                                    // closing the toolbar...
                                    model.toolPicker.setVisible(false, forFirstResponder: model.canvas)
                                    model.canvas.resignFirstResponder()
                                    model.currentIndex = getIndex(textBox: box)
                                    withAnimation{
                                        model.addNewBox = true
                                    }
                                }
                        }
                    }
                )
            }
        }
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: model.saveImage, label: {
                    Text("Speichern")
                })
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
    func getIndex(textBox: TextBox)->Int{
        
        let index = model.textBoxes.firstIndex { (box) -> Bool in
            return textBox.id == box.id
        } ?? 0
        
        return index
    }
}

