//
//  ContentView.swift
//  CoreMLTestGrades
//
//  Created by Gustavo Garfias on 14/04/22.
//

import SwiftUI

struct MyGrades: View {
    
    @State var kind: Grade.Kind = .Exam
    @State var subject: Grade.Subject = .Química
    @State var vm = VM()
    
    @State var predictedGrade: Double = 0
    @State var predictedGrades = [Prediction]()
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Subject")) {
                    Picker(selection: $subject, label: Text("Subject")) {
                        ForEach(Array(Grade.Subject.allCases), id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                }
                
                Section(header: Text("Type")) {
                    Picker(selection: $kind, label: Text("Type")) {
                        ForEach(Array(Grade.Kind.allCases), id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .labelsHidden()
                }
                
                Section(footer: HStack {
                    Spacer()
                    Button("Predict your grade!", action: {
                        predictedGrades = []
                        
                        for version in MLModelVersion.allCases {
                            predictedGrades.append(vm.predict(kind: kind, subject: subject, version: version))
                        }
                        predictedGrade = vm.predict(kind: kind, subject: subject).value
                    })
                    Spacer()
                }) {
                    EmptyView()
                }
                
                if (predictedGrade != 0) {
                    
                    /*
                    ForEach(Array(MLModelVersion.allCases), id: \.self) { version in
                        Section(header: Text("Predicted Grade (\(version.rawValue))")) {
                            if (predictedGrades[version]?.likelihood == .Likely) {
                                TextField("Predicted grade", value: $predictedGrades[version]!.value, formatter: formatter)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .disabled(true)
                            } else {
                                Text("Not enough data to predict this combination :(")
                            }
                        }
                    }
                     */
                    
                    ForEach($predictedGrades, id: \.self) { prediction in
                        Section(header: Text("Predicted Grade (\(prediction.wrappedValue.version.rawValue))")) {
                            if (prediction.likelihood.wrappedValue == Prediction.Likelihood.Likely) {
                                TextField("Predicted grade", value: prediction.value, formatter: formatter)
                                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                                .disabled(true)
                            } else {
                                Text("Not enough data to predict this combination (\(prediction.wrappedValue.value))")
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                            }
                        }
                    }
                } else {
                    EmptyView()
                }
                
            }
            .navigationTitle(Text("Grade Predicter"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MyGrades()
    }
}
