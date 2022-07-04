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
                image?.resizable().scaledToFit()
                Button("Öffne Galerie"){
                    self.showImagePicker = true
                }.padding()
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }.sheet(isPresented: self.$showImagePicker) {
                PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)
            }
            .navigationBarTitle(Text("Galerie"))
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
