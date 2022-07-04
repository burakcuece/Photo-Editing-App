//
//  ImagePicker.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 04.07.22.
//

import UIKit
import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
   @Binding var isShown : Bool
   @Binding var image : Image?
func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
}
func makeCoordinator() -> ImagePickerCordinator {
      return ImagePickerCordinator(isShown: $isShown, image: $image)
   }
func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
let picker = UIImagePickerController()
      picker.delegate = context.coordinator
      return picker
   }
}
