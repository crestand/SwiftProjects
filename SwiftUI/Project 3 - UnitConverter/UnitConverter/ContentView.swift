//
//  ContentView.swift
//  UnitConverter
//
//  Created by Hamza Eren Koc on 31.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    enum LengthEnum: String, CaseIterable {
        case meter, kilometer, feet, yard, mile
    }
    @State private var originalAmount: Double = 0
    @State private var sourceUnit: LengthEnum = .meter
    @State private var destinationUnit: LengthEnum = .kilometer
    
    private var valueInMeter: Double {
        
        var valueInMeter: Double
        
        switch sourceUnit {
        case .meter:
            valueInMeter = originalAmount;
        case .kilometer:
            valueInMeter = originalAmount * 1000
        case .feet:
            valueInMeter = originalAmount * 0.3048
        case .yard:
            valueInMeter = originalAmount * 0.9144
        case .mile:
            valueInMeter = originalAmount * 1609.344
        }
        
        return valueInMeter
    }
    
    private var convertedValue: Double {
        var temp: Double
        
        switch destinationUnit {
        case .meter:
            temp = valueInMeter
        case .kilometer:
            temp = valueInMeter / 1000
        case .feet:
            temp = valueInMeter / 0.3048
        case .yard:
            temp = valueInMeter / 0.9144
        case .mile:
            temp = valueInMeter / 1609.344
        }
        
        return temp
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Original Valuse is:") {
                    TextField("Enter your value", value: $originalAmount, format: .number)
                }
                
                Section("Choose units") {
                    Picker("From", selection: $sourceUnit) {
                        ForEach(LengthEnum.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    Picker("To", selection: $destinationUnit) {
                        ForEach(LengthEnum.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                }
                
                Section("Converted Value is:") {
                    Text(convertedValue, format: .number)
                        
                }
                
                
            }
            .navigationTitle("Unit Converter")
        }
    }
}

#Preview {
    ContentView()
}
