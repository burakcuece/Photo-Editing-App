//
//  Photo_Editing_App.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 02.07.22.
//

import SwiftUI

@main
struct Photo_Editing_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ImagePickerViewModel())
        }
    }
}
