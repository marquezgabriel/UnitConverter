//
//  ContentView.swift
//  UnitConverter
//
//  Created by Gabriel Marquez on 2022-05-28.
//  Updated by Gabriel Marquez on 2022-05-31.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 1.0
    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.kilometers
    
    let units: [UnitLength] = [.feet, .kilometers, .meters, .miles, .yards]
    let formatter: MeasurementFormatter
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
    
    
    var result: String {
        let inputMeasument = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasument.converted(to: outputUnit)
        return formatter.string(from: outputMeasurement)
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
                        Text(formatter.string(from: $0).capitalized)
                    }
                }.pickerStyle(.automatic)
                Picker("Convert to" ,selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                } .pickerStyle(.automatic)
                
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
