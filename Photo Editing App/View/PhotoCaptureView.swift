//
//  PhotoCaptureView.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 04.07.22.
//

import SwiftUI
struct PhotoCaptureView: View {
   @Binding var showImagePicker : Bool
   @Binding var image : Image?
 
   var body: some View {
      ImagePicker(isShown: $showImagePicker, image: $image)
   }
}
struct PhotoCaptureView_Previews: PreviewProvider {
   static var previews: some View {
      PhotoCaptureView(showImagePicker: .constant(false), image:  .constant(Image("")))
   }
}
