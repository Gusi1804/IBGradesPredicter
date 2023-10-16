//
//  File.swift
//  Grade Tracker
//
//  Created by Gustavo Garfias on 14/04/22.
//

import Foundation
import CoreML

class VM: ObservableObject {
    @Published var grades = [Grade]()
    
    func predict(kind: Grade.Kind, subject: Grade.Subject, version: MLModelVersion = .V3) -> Prediction {
        var prediction: Prediction = Prediction(value: 0, likelihood: .Unlikely, version: .V1)
        
        if (version == .V1) {
            let model = GradesPredicter1()
            var likelihood = Prediction.Likelihood.Unlikely
            
            guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Type_: kind.rawValue) else {
                fatalError("Unexpected runtime error.")
            }
            
            let grade = gradesPredicterOutput.Grade
            
            if (grade > 0 && grade < 10) {
                likelihood = .Likely
            }
            
            prediction = Prediction(value: grade, likelihood: likelihood, version: .V1)
        } else if (version == .V2) {
            let model = GradesPredicter2()
            var likelihood = Prediction.Likelihood.Unlikely
            
            guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Type_: kind.rawValue) else {
                fatalError("Unexpected runtime error.")
            }
            
            let grade = gradesPredicterOutput.Grade
            
            if (grade > 0 && grade < 10) {
                likelihood = .Likely
            }
            
            prediction = Prediction(value: grade, likelihood: likelihood, version: .V2)
        } else if (version == .V3) {
            let model = GradesPredicter3()
            var likelihood = Prediction.Likelihood.Unlikely
            
            guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Type_: kind.rawValue) else {
                fatalError("Unexpected runtime error.")
            }
            
            let grade = gradesPredicterOutput.Grade
            
            if (grade > 0 && grade < 10) {
                likelihood = .Likely
            }
            
            prediction = Prediction(value: grade, likelihood: likelihood, version: .V3)
        } else if (version == .V1_1) {
            let model = GradesPredicter1_1()
            var likelihood = Prediction.Likelihood.Unlikely
            
            guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Type_: kind.rawValue) else {
                fatalError("Unexpected runtime error.")
            }
            
            let grade = gradesPredicterOutput.Grade
            
            if (grade > 0 && grade < 10) {
                likelihood = .Likely
            }
            
            prediction = Prediction(value: grade, likelihood: likelihood, version: .V1_1)
        }
        
        return prediction
    }
}

class IB_VM: ObservableObject {
    func predict(subject: Subject, level: Level, grade: Grade, version: ModelVersion = .V4) -> Double {
        
        var predictedGrade: Double = 0
        
        switch version {
        case .V1:
            let model = IBGradesPredicter1()
            
            guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Level: level.rawValue, Predicted_grade: Double(grade.rawValue)) else {
                fatalError("Unexpected runtime error.")
            }
            
            predictedGrade = gradesPredicterOutput.Grade
        case .V2:
            let model = IBGradesPredicter2()
            
            guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Level: level.rawValue, Predicted_grade: Double(grade.rawValue)) else {
                fatalError("Unexpected runtime error.")
            }
            
            predictedGrade = gradesPredicterOutput.Grade
        case .V3:
            let model = IBGradesPredicter3()
            
            guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Level: level.rawValue, Predicted_grade: Double(grade.rawValue)) else {
                fatalError("Unexpected runtime error.")
            }
            
            predictedGrade = gradesPredicterOutput.Grade
        case .V4:
            let model = IBGradesPredicter4()
            
            guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Level: level.rawValue, Predicted_grade: Double(grade.rawValue)) else {
                fatalError("Unexpected runtime error.")
            }
            
            predictedGrade = gradesPredicterOutput.Grade
        case .V5:
            let model = IBGradesPredicter5()
            
            guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Level: level.rawValue, Predicted_grade: Double(grade.rawValue)) else {
                fatalError("Unexpected runtime error.")
            }
            
            predictedGrade = gradesPredicterOutput.Grade
        case .V6:
            let model = IBGradesPredicter6()
            
            guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Level: level.rawValue, Predicted_grade: Double(grade.rawValue)) else {
                fatalError("Unexpected runtime error.")
            }
            
            predictedGrade = gradesPredicterOutput.Grade
        }
        
        return predictedGrade
    }
    
    func predictV1(subject: Subject, level: Level, grade: Grade) -> Double {
        let model = IBGradesPredicter1()
        
        guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Level: level.rawValue, Predicted_grade: Double(grade.rawValue)) else {
            fatalError("Unexpected runtime error.")
        }
        
        let grade = gradesPredicterOutput.Grade
        
        return grade
    }
    
    func predictAllVersions(subject: Subject, level: Level, grade: Grade) -> [Prediction] {
        var predictions = [Prediction]()
        
        for version in ModelVersion.allCases {
            let grade = predict(subject: subject, level: level, grade: grade, version: version)
            
            predictions.append(Prediction(value: grade, version: version))
        }
        
        return predictions
    }
    
    func interval(_ prediction: Prediction) -> String {
        var result = ""
        let grade = prediction.value
        
        let rounded = Int(grade.rounded())
        
        if (abs(grade - Double(rounded)) > 0.2) {
            let min = Int(floor(grade))
            let max = Int(ceil(grade))
            
            if (min == rounded) {
                result = "Range: \(String(min)) (most likely) to \(String(max))"
            } else if (max == rounded) {
                result = "Range: \(String(min)) to \(String(max)) (most likely)"
            }
        } else {
            result = "Most likely: \(String(rounded))"
        }
        
        return result
    }
    
    
    enum Subject: String, CaseIterable {
        case BIOLOGY
        case CHEMISTRY
        case ECONOMICS
        case ENGLISH_B = "ENGLISH B"
        case GEOGRAPHY
        case GERMAN_B = "GERMAN B"
        case MATHEMATICS
        case PHYSICS
        case PSYCHOLOGY
        case SPANISH_A_Lang_and_Literature = "SPANISH A: Lang and Literature"
        case VISUAL_ARTS = "VISUAL ARTS"
    }
    
    enum Level: String, CaseIterable {
        case SL, HL
    }
    
    enum Grade: Int, CaseIterable {
        case One = 1
        case Two = 2
        case Three = 3
        case Four = 4
        case Five = 5
        case Six = 6
        case Seven = 7
    }
    
    enum ModelVersion: String, CaseIterable {
        case V1, V2, V3, V4, V5, V6
    }
    
    struct Prediction: Hashable {
        var value: Double
        var version: ModelVersion
    }
    
}

enum MLModelVersion: String, CaseIterable, Codable {
    case V1, V1_1, V2, V3
}

enum Likelihood: String, Codable {
    case Likely, Unlikely
}

struct Prediction: Codable, Hashable {
    var value: Double
    var likelihood: Likelihood
    var version: MLModelVersion
    
    enum Likelihood: String, Codable {
        case Likely, Unlikely
    }
}
