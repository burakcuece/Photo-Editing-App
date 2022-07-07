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

    var body: some View {
        ZStack {
            GeometryReader { proxy -> AnyView in
                
                let size = proxy.frame(in: .global).size
                
                return AnyView(
                    
                    ZStack {
                        
                        CanvasView(canvas: $model.canvas, imageData: $model.imageData, toolPicker: $model.toolPicker, rect: size)
                    }
                )
            }
        }
//        .toolbar {
//
//                ToolbarItem(placement: .navigationBarTrailing) {
//
//
//                    Button {
//                        
//                    } label: {
//                        Text("Speichern")
//                    }
//
//                }
//
//            }
        }
    }
    
    struct DrawingScreen_Previews: PreviewProvider {
        static var previews: some View {
            DrawingScreen()
        }
    }
