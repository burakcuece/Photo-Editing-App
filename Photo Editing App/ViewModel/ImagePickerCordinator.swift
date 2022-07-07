//
//  ImagePickerCordinator.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 04.07.22.
//

import UIKit
import SwiftUI

class ImagePickerCordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
@Binding var isShown : Bool
@Binding var image : Image?
init(isShown : Binding<Bool>, image: Binding<Image?>) {
      _isShown = isShown
      _image = image
   }
//Selected Image
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
let uiImage = info[UIImagePickerController.InfoKey.originalImage]   as! UIImage
image = Image(uiImage: uiImage)
   isShown = false
}
//Image selection got cancel
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
   isShown = false
   }
    func makeCoordinator() -> ImagePickerCordinator {
       return ImagePickerCordinator(isShown: $isShown, image: $image)
    }
}
