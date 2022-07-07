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
        
        NavigationView{
            VStack {
                
                Spacer()
                
                if let image = image {
                    VStack {
                        
                        
                        image
                            .resizable()
                            .renderingMode(.original)
                            .scaledToFit()                        
                            .blur(radius: blurAmount)
                        
                        HStack {
                            Text("Blur")
                            
                            Slider(value: $blurAmount, in: 0...10)
                        }
                        
                        DrawingScreen()
                            .environmentObject(model)
                        
                        
                        
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
                
            }
            .background(Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255))
            .navigationBarTitle(Text("Foto"))
            .navigationBarItems(trailing: HStack {
                Button {
                    self.showImagePicker = true
                } label: {
                    Image(systemName: "photo.circle")
                        .resizable()
                        .renderingMode(.original)
                        .foregroundColor(Color(red: 4 / 255, green: 150 / 255, blue: 255 / 255))
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                }
                Button {
                    self.showCameraPicker = true
                } label: {
                    Image(systemName: "camera.circle")
                        .resizable()
                        .renderingMode(.original)
                        .foregroundColor(Color(red: 4 / 255, green: 150 / 255, blue: 255 / 255))
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                }
                .sheet(isPresented: self.$showImagePicker) {
                    PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
                }
                .sheet(isPresented: self.$showCameraPicker) {
                    CameraView()
                }
            })
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
