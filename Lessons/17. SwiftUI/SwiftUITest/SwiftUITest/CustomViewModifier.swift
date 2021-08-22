//
//  CustomViewModifier.swift
//  SwiftUITest
//
//  Created by Alexander on 22.08.2021.
//

import SwiftUI

struct PrimaryLabel: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

/*
 
Использование:
.modifier(PrimaryLabel())
 
*/
