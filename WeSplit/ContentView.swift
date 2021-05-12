//
//  ContentView.swift
//  WeSplit
//
//  Created by Rejah Anuvar on 12/05/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var noOfPeople = ""
    @State private var tipPercentage = 0
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalAmount : Double {
        guard let checkAmount = Double(self.checkAmount) else {
            return 0.0
        }
        
        let total = checkAmount + (checkAmount * Double(tipPercentages[self.tipPercentage]) / 100 )
        
        return total
    }
    
    var splitAmount: Double {
        guard let numPeople = Double(self.noOfPeople),
              numPeople > 0 else { return 0 }
        
        return self.totalAmount / numPeople
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount: ", text: self.$checkAmount).keyboardType(.decimalPad)

                    TextField("No of People: ", text: self.$noOfPeople).keyboardType(.numberPad)
                }

                Section(header: Text("How much tip percentage?")) {
                    Picker("TipPercentage: ", selection: self.$tipPercentage) {
                        ForEach(0 ..< self.tipPercentages.count) {
                            Text("\(self.tipPercentages[$0]) %")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Total Amount")) {
                    Text("\(self.totalAmount, specifier: "%.2f")")
                }

                Section(header: Text("Amount per person")) {
                    Text("\(self.splitAmount , specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
