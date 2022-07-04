//
//  ImagePickerViewModel.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 04.07.22.
//

import SwiftUI

class ImagePickerViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
}
