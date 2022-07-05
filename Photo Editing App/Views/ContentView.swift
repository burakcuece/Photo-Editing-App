//
//  ContentView.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 02.07.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showImagePicker : Bool = false
    @State private var image : Image? = nil
    
    var body: some View {
        
        NavigationView{
            VStack {
                
                Spacer()
                
                if let image = image {
                    image
                        .resizable()
                        .renderingMode(.original)
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.horizontal)
                    
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.horizontal)
                }
                Spacer()
                
                HStack {
                    
                    Button(){
                        self.showImagePicker = true
                    } label: {
                        Image(systemName: "photo.circle")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                            .padding()
                    }
                    Button(){
                        
                    } label: {
                        Image(systemName: "camera.circle")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            .sheet(isPresented: self.$showImagePicker) {
                PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
            }
            .navigationBarTitle(Text("Foto bearbeiten"))
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
