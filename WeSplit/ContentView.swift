//
//  ContentView.swift
//  WeSplit
//
//  Created by Yau Chin Pang on 27/11/2023.
//

import SwiftUI

// View is protocol
struct ContentView: View {
    
    // @State to indicate this variables can be modified
    // When state variables changes, it will reload body
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    private var totalAmountPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        return checkAmount * (1 + tipSelection / 100) / peopleCount
    }
    
    // computed property
    // conforms to View
    var body: some View {
        NavigationStack {
            Form {
                // List of data like settings
                Section {
                    TextField("Amount", 
                              // $stateVar to indicate it can be read/write at the same time (2-way binding)
                              value: $checkAmount,
                              // get current device money
                              format: .currency(code: Locale.current.currency?.identifier ?? "HKD")
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Tip Percentage") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section {
                    Text(totalAmountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "HKD"))
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
            // view modifier
            // return a new view with original data + modification
        }
    }
}

// Not on final app, but just display on Xcode
#Preview {
    ContentView()
}
