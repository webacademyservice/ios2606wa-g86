//
//  Bluetooth.swift
//  SwiftUITest
//
//  Created by Alexander on 22.08.2021.
//

import SwiftUI

struct BluetoothView: View {

    @State private var isBluetoothOn = true

    var body: some View {

        VStack {
            Toggle(isOn: $isBluetoothOn) {
                Text("Bluetooth")
            }.padding()

            if isBluetoothOn {
                Image("bluetooth-logo")
            } else {
                Text("Bluetooth is off")
            }

            Spacer()
        }
    }
}

struct BluetoothView_Previews: PreviewProvider {

    static var previews: some View {
        BluetoothView().previewDevice(PreviewDevice(rawValue: "iPhone SE")).previewDisplayName("iPhone SE2")
    }
}
