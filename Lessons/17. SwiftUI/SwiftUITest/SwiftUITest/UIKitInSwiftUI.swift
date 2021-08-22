//
//  UIKitInSwiftUI.swift
//  SwiftUITest
//
//  Created by Alexander on 22.08.2021.
//

import SwiftUI

struct TextView: UIViewRepresentable {

    @Binding var text: NSMutableAttributedString

    func makeUIView(context: Context) -> UITextView {
        UITextView()
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
    }
}
