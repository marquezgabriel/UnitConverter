//
//  ContentView.swift
//  UnitConverter
//
//  Created by Gabriel Marquez on 2022-05-28.
//  Updated by Gabriel Marquez on 2022-06-01.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 1.0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.yards
    @State var selectedUnits = 0
    
    let unitTypes = [
        [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    
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
    
    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    
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
                
                Picker("Conversion", selection: $selectedUnits) {
                    ForEach(0..<conversions.count) {
                        Text(conversions[$0])
                    }
                }.pickerStyle(.segmented)

                Picker("Convert from", selection: $inputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }

                Picker("Convert to", selection: $outputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                
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
        .onChange(of: selectedUnits) { newSelection in
            let units = unitTypes[newSelection]
            inputUnit = units[0]
            outputUnit = units[1]
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11 Pro")
    }
}
