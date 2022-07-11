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
        
        ZStack {
            NavigationView {
                
                VStack {
                    
                    if let _ = UIImage(data: model.imageData) {
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
            
            if model.addNewBox {
                
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                
                TextField("Tippe hier", text: $model.textBoxes[model.currentIndex].text)
                    .font(.system(size: 35))
                    .colorScheme(.dark)
                    .foregroundColor(model.textBoxes[model.currentIndex].textColor)
                    .padding()
                
                HStack {
                    Button {
                        model.toolPicker.setVisible(true, forFirstResponder: model.canvas)
                        model.canvas.becomeFirstResponder()
                        
                        withAnimation {
                            model.addNewBox = false
                        }
                    } label: {
                        Text("Hinzufügen")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                    
                    Button {
                        model.cancelTextView()
                    } label: {
                        Text("Abbrechen")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .overlay(
                    HStack(spacing: 15){
                        
                        // Color Picker...
                        ColorPicker("", selection: $model.textBoxes[model.currentIndex].textColor)
                            .labelsHidden()
                        
                        Button(action: {
                            model.textBoxes[model.currentIndex].isBold.toggle()
                        }, label: {
                            Text(model.textBoxes[model.currentIndex].isBold ? "Normal" : "Bold")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        })
                    }
                )
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        
        .sheet(isPresented: $model.showImagePicker, content: {
            ImagePicker(showPicker: $model.showImagePicker, imageData: $model.imageData)
        })
        .alert(isPresented: $model.showAlert, content: {
            Alert(title: Text("Nachricht"), message: Text(model.message), dismissButton: .destructive(Text("Ok")))
        })

    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
