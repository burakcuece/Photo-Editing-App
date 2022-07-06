//
//  ContentView.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 02.07.22.
//


import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var showImagePicker : Bool = false
    @State private var image : Image? = nil
    @State private var showCameraPicker : Bool = false
    
    @State private var blurAmount = 0.0
    @State private var sepiaAmount = 0.0
    
    @State private var inputImage: UIImage?
    
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @ObservedObject var camera = CameraModel()
    
    var body: some View {
        
        NavigationView{
            VStack {
                
                Spacer()
                
                if let image = image {
                    VStack {
                    image
                        .resizable()
                        .renderingMode(.original)
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .blur(radius: blurAmount)
                        
                        HStack {
                            Text("Blur")
                            
                            Slider(value: $blurAmount, in: 0...10)
                        }
                    }
                    .padding()
                    
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color(red: 4 / 255, green: 150 / 255, blue: 255 / 255))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.horizontal)
                }
                Spacer()
                
                HStack {
                    
                    Button {
                        self.showImagePicker = true
                    } label: {
                        Image(systemName: "photo.circle")
                            .resizable()
                            .renderingMode(.original)
                            .foregroundColor(Color(red: 4 / 255, green: 150 / 255, blue: 255 / 255))
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                            .padding()
                    }
                    
                    Button {
                        self.showCameraPicker = true
                    } label: {
                        Image(systemName: "camera.circle")
                            .resizable()
                            .renderingMode(.original)
                            .foregroundColor(Color(red: 4 / 255, green: 150 / 255, blue: 255 / 255))
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                            .padding()
                    }
                    .sheet(isPresented: self.$showImagePicker) {
                        PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
                    }
                    .sheet(isPresented: self.$showCameraPicker) {
                        CameraView()
                    }
                }
            }
            .background(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255))
            .navigationBarTitle(Text("Foto bearbeiten"))
        }
        
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
