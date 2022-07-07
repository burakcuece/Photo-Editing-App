//
//  ContentView.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 02.07.22.
//


import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import PencilKit

struct ContentView: View {
    
    @State private var showImagePicker : Bool = false
    @State private var image : Image? = nil
    @State private var showCameraPicker : Bool = false

    @State private var blurAmount = 0.0
    @State private var sepiaAmount = 0.0
    
    @State private var inputImage: UIImage?
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @StateObject var model = DrawingViewModel()
    @ObservedObject var camera = CameraModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                if let ImageFile = UIImage(data: model.imageData) {
                    
                    Spacer()
                    
                    HStack {
                        Text("Blur")
                        Slider(value: $blurAmount, in: 0...10)
                    }
                    .padding(.horizontal)
                    
                    DrawingScreen()
                        .environmentObject(model)
                        .blur(radius: blurAmount)
                    
                    
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button {
                                    model.cancelImageEditing()
                                } label: {
                                    Image(systemName: "xmark")
                                }
                            }
                            
                        }
                    
                } else {
                    
                    Button {
                        model.showImagePicker.toggle()
                    } label: {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 350, alignment: .center)
                    }
                    
                }
                
            }
            .navigationTitle("Foto bearbeiten")
            .navigationBarItems(trailing:
                            Button {
                                self.showCameraPicker = true
                            } label: {
                                Image(systemName: "camera.circle")
                                    .resizable()
                                    .renderingMode(.original)
                                    .foregroundColor(Color(red: 4 / 255, green: 150 / 255, blue: 255 / 255))
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                            })
            .sheet(isPresented: self.$showCameraPicker) {
                CameraView()
            }
        }
        .sheet(isPresented: $model.showImagePicker) {
            ImagePicker(showPicker: $model.showImagePicker, imageData: $model.imageData )
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
