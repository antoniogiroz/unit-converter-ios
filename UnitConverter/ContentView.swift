//
//  ContentView.swift
//  UnitConverter
//
//  Created by Antonio Giroz on 26/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.kilometers
    @State private var inputValue = 1.0
    @State private var outputValue = 1.0
    @State private var selectedUnits = 0
    
    @FocusState private var inputIsFocused: Bool
    @FocusState private var outputIsFocused: Bool

    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    
    let unitTypes = [
        [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    let formatter: MeasurementFormatter
    

    var result: String {
        let inputMeasurement = Measurement(value: inputValue, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        
        return formatter.string(from: outputMeasurement)
    }
    
    func calculateConversion(from: Dimension, to: Dimension, value: Double) -> Double {
        let inputMeasurement = Measurement(value: value, unit: from)
        return inputMeasurement.converted(to: to).value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Conversion", selection: $selectedUnits) {
                        ForEach(0..<conversions.count, id: \.self) {
                            Text(conversions[$0])
                        }
                    }
                }
                
                Section("From unit") {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: inputUnit) {
                        outputValue = calculateConversion(from: inputUnit, to: outputUnit, value: inputValue)
                    }
                    
                    TextField("Enter a value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                        .onChange(of: inputValue) {
                            if !outputIsFocused {
                                outputValue = calculateConversion(from: inputUnit, to: outputUnit, value: inputValue)
                            }
                        }
                }
                
                Section("To unit") {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(unitTypes[selectedUnits], id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: outputUnit) {
                        outputValue = calculateConversion(from: inputUnit, to: outputUnit, value: inputValue)
                    }
                    
                    TextField("Enter a value", value: $outputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($outputIsFocused)
                        .onChange(of: outputValue) {
                            if !inputIsFocused {
                                inputValue = calculateConversion(from: outputUnit, to: inputUnit, value: outputValue)
                            }
                        }
                }
                
                Section("Result") {
                    Text(result)
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                if inputIsFocused || outputIsFocused {
                    Button("Done") {
                        inputIsFocused = false
                        outputIsFocused = false
                    }
                }
            }
            .onChange(of: selectedUnits) {
                let units = unitTypes[selectedUnits]
                inputUnit = units[0]
                outputUnit = units[1]
            }
        }
    }
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}

#Preview {
    ContentView()
}
