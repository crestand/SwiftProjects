//
//  ContentView.swift
//  WeSplit
//
//  Created by Hamza Eren Koc on 31.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 15

    @FocusState private var amountIsFocused: Bool
    
    private let tipPercentages = [5, 10, 15, 20, 25, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = (checkAmount / 100) * tipSelection
        let grandTotal = tipValue + checkAmount
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "TRY"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip Percentages", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                
                Section("Total Amount is:") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "TRY"))
                }
                
                
                Section("Amount per person is:") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "TRY"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
        
        
    }
}

#Preview {
    ContentView()
}

