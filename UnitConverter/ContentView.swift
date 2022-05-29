//
//  ContentView.swift
//  UnitConverter
//
//  Created by Gabriel Marquez on 2022-05-28.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var numberToConvert: Double = 0.0
    
    let unitsType = ["Milimeters", "Meters", "Miles"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField ("Type the number your want to convert", value: $numberToConvert, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    
                    
                    
                }
                Section {
                    Text (numberToConvert, format: .number)
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11 Pro Max")
    }
}
