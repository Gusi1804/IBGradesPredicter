import SwiftUI
import CoreML

struct IBGrades: View {
    
    @State var vm = IB_VM()
    @State var subject = IB_VM.Subject.BIOLOGY
    @State var level = IB_VM.Level.SL
    @State var predictedGrade = IB_VM.Grade.Four
    
    @State var likelyGradeInt: Int = 0
    @State var likelyGradeDouble: Double = 0
    @State var predictions = [IB_VM.Prediction]()
    
    var body: some View {
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
            
            //Results
            if (likelyGradeInt != 0 || likelyGradeDouble != 0) {
                
                
                ForEach($predictions, id: \.self) { prediction in
                    Section(header: Text("Your final grade might be:")) {
                        Text("\(vm.interval(prediction.wrappedValue))")
                    }
                }
            }
        }
        .navigationTitle("IB Grades Prediction")
        .navigationBarBackButtonHidden(true)
    }
}
