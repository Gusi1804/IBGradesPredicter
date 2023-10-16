//
//  File.swift
//  Grade Tracker
//
//  Created by Gustavo Garfias on 14/04/22.
//

import Foundation
import SwiftUI

struct Grade: Codable {
    var id: UUID
    var value: Float
    var weight: Float
    var name: String
    var type: Kind
    var subject: Subject
    
    enum Kind: String, Codable {
        case Essay, Exam, Exercise, Presentation, Project
    }
    
    enum Subject: String, Codable {
        case Maths, TOK, Historia, Español, Geografía, Química, Physics, Deutsch, Français, Biologie
    }
}



