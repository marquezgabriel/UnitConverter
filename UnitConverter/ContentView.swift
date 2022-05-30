//
//  ContentView.swift
//  UnitConverter
//
//  Created by Gabriel Marquez on 2022-05-28.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 1.0
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Kilometers"
    
    let units = ["Feet", "Kilometers", "Meters", "Miles", "Yards"]
    
    var result: String {
        let inputToMetersMultiplier: Double
        let metersToOutputMultiplier: Double
        
        switch inputUnit {
        case "Feet":
            inputToMetersMultiplier = 0.3048
        case "Kilometers":
            inputToMetersMultiplier = 1000
        case "Miles":
            inputToMetersMultiplier = 1609.34
        case "Yards":
            inputToMetersMultiplier = 0.9144
        default:
            inputToMetersMultiplier = 1.0
        }
        switch outputUnit {
        case "Feet":
            metersToOutputMultiplier = 3.28084
        case "Kilometers":
            metersToOutputMultiplier = 0.001
        case "Miles":
            metersToOutputMultiplier = 0.000621371
        case "Yards":
            metersToOutputMultiplier = 1.09361
        default:
            metersToOutputMultiplier = 1.0
        }
        let inputInMeters = input * inputToMetersMultiplier
        let output = inputInMeters * metersToOutputMultiplier
        let outputString = output.formatted()
        return "\(outputString) \(outputUnit.lowercased())"
    }
    
    @FocusState private var inputIsFocused: Bool

    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $input, format: .number)
                        .focused($inputIsFocused)
                        .keyboardType(.decimalPad)

                } header: {
                    Text("Amount to convert")
                }
                Picker("Convert from", selection: $inputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                Picker("Convert to" ,selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                } .pickerStyle(.segmented)
                
                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("UnitConverter")
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    inputIsFocused = false
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
