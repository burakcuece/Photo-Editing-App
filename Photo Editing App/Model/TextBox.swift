//
//  TextBox.swift
//  Photo Editing App
//
//  Created by Burak Cüce on 08.07.22.
//

import SwiftUI
import PencilKit

struct TextBox: Identifiable {
    
    var id = UUID().uuidString
    var text: String = ""
    var isBold: Bool = false
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColor: Color = .white
}
