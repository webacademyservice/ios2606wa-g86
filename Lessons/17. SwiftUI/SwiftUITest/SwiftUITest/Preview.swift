//
//  Preview.swift
//  SwiftUITest
//
//  Created by Alexander on 22.08.2021.
//

import SwiftUI

struct ShareButtonView: View {
    
    var body: some View {
        Button(action: {
            print("Sharing")
        }) {
            Text("button.share.title")
                .font(.body)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background(Color(UIColor.systemBlue))
                .cornerRadius(15)
                .foregroundColor(.white)
        }
    }
}

struct ShareButtonView_Previews: PreviewProvider {

    static var previews: some View {
        Group {

            ShareButtonView()
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Default preview 1")

            ShareButtonView()
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
