//
//  ContentView.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 02.07.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var vm: ImagePickerViewModel
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity)
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.horizontal)
                }
                HStack {
                    Button {
                        vm.source = .camera
                        vm.showPicker = true
                    } label: {
                        Text("Kamera")
                    }
                    
                    Button {
                        vm.source = .library
                        vm.showPicker = true
                    } label: {
                        Text("Foto")
                    }

                }
                Spacer()
            }
            .sheet(isPresented: $vm.showPicker, content: {
            })
            .navigationTitle("Meine Fotos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ImagePickerViewModel())
    }
}
