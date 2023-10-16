//
//  VM.swift
//  Grade Tracker
//
//  Created by Gustavo Garfias on 23/04/22.
//

import Foundation
import CoreML

class IB_VM: ObservableObject {
    func predict(subject: Subject, level: Level, grade: Grade, version: ModelVersion = .V4) -> Double {
        
        var predictedGrade: Double = 0
        
        switch version {
        case .V4:
            let model = IBGradesPredicter4()
            
            guard let gradesPredicterOutput = try? model.prediction(Subject: subject.rawValue, Level: level.rawValue, Predicted_grade: Double(grade.rawValue)) else {
                fatalError("Unexpected runtime error.")
            }
            
            predictedGrade = gradesPredicterOutput.Grade
        }
        
        return predictedGrade
    }
    
    func predictV1(subject: Subject, level: Level, grade: Grade) -> Double {
        let model = IBGradesPredicter4()
        
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
                result = "In the range of \(String(min)) (most likely) to \(String(max))"
            } else if (max == rounded) {
                result = "In the range of \(String(min)) to \(String(max)) (most likely)"
            }
        } else {
            result = "Most likely: \(String(rounded))"
        }
        
        result += " " + gradeToEmoji(grade: rounded)
        
        return result
    }
    
    func gradeToEmoji(grade: Int) -> String {
        var res = ""
        
        switch(grade) {
        case 1:
            res = "😞"
        case 2:
            res = "🙁"
        case 3:
            res = "😕"
        case 4:
            res = "🙂"
        case 5:
            res = "😀"
        case 6:
            res = "😁"
        case 7:
            res = "🥳"
        default:
            res = ""
        }
        
        return res
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
        case V4
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
