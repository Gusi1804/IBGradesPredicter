//
//  IBGrades.swift
//  CoreMLTestGrades
//
//  Created by Gustavo Garfias on 16/04/22.
//

import SwiftUI

struct IBGrades: View {
    
    @State var vm = IB_VM()
    @State var subject = IB_VM.Subject.BIOLOGY
    @State var level = IB_VM.Level.SL
    @State var predictedGrade = IB_VM.Grade.Four
    
    @State var likelyGradeInt: Int = 0
    @State var likelyGradeDouble: Double = 0
    @State var predictions = [IB_VM.Prediction]()
    
    var body: some View {
        NavigationView {
            Form {
                //Inputs
                Section {
                    Picker(selection: $subject, label: Text("Subject")) {
                        ForEach(Array(IB_VM.Subject.allCases), id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    
                    HStack {
                        Text("Level")
                        Spacer()
                        Picker(selection: $level, label: Text("Level")) {
                            ForEach(Array(IB_VM.Level.allCases), id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 150)
                    }
                    
                    Picker(selection: $predictedGrade, label: Text("Predicted Grade")) {
                        ForEach(Array(IB_VM.Grade.allCases), id: \.self) {
                            Text(String($0.rawValue))
                        }
                    }
                }
                
                //Calculate Button
                Section(footer: HStack {
                    Spacer()
                    Button("Predict your final grade", action: {
                        likelyGradeInt = Int(vm.predict(subject: subject, level: level, grade: predictedGrade).rounded())
                        likelyGradeDouble = vm.predict(subject: subject, level: level, grade: predictedGrade)
                        
                        predictions = vm.predictAllVersions(subject: subject, level: level, grade: predictedGrade)
                    })
                    .buttonStyle(.borderedProminent)
                    .font(.headline)
                    Spacer()
                }) {
                    EmptyView()
                }
                
                //Debug Button
                Section(footer: HStack {
                    Spacer()
                    Button("Autotest Models", action: {
                        //likelyGradeInt = Int(vm.predict(subject: subject, level: level, grade: predictedGrade).rounded())
                        //likelyGradeDouble = vm.predict(subject: subject, level: level, grade: predictedGrade)
                        
                        //predictions = vm.predictAllVersions(subject: subject, level: level, grade: predictedGrade)
                        
                        print("Subject,Level,Predicted Grade (by teacher),Final Grade (calculated),Model Version")
                        for subject in IB_VM.Subject.allCases {
                            for grade in IB_VM.Grade.allCases {
                                for level in IB_VM.Level.allCases {
                                    for version in IB_VM.ModelVersion.allCases {
                                        likelyGradeDouble = vm.predict(subject: subject, level: level, grade: grade, version: version)
                                        
                                        print("\(subject.rawValue),\(level.rawValue),\(grade.rawValue),\(String(likelyGradeDouble)),\(version.rawValue)")
                                    }
                                }
                            }
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .font(.headline)
                    Spacer()
                }) {
                    EmptyView()
                }
                
                //Results
                if (likelyGradeInt != 0 || likelyGradeDouble != 0) {
                    
                    Section(header: Text("Your final grades might be:")) {
                        EmptyView()
                    }
                    
                    ForEach($predictions, id: \.self) { prediction in
                        Section(header: Text("\(prediction.wrappedValue.version.rawValue)")) {
                            
                            Text("Rounded: \(String(Int(prediction.wrappedValue.value.rounded())))")
                            
                            Text("\(String(format: "Unrounded: %.2f", prediction.wrappedValue.value))")
                            
                            Text("\(vm.interval(prediction.wrappedValue))")
                        }
                    }
                }
            }
            .navigationTitle("IB Grades Prediction")
        }
    }
}

struct IBGrades_Previews: PreviewProvider {
    static var previews: some View {
        IBGrades()
    }
}
