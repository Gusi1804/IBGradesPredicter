//
//  CoreMLTestGradesApp.swift
//  CoreMLTestGrades
//
//  Created by Gustavo Garfias on 14/04/22.
//

import SwiftUI

@main
struct CoreMLTestGradesApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MyGrades()
                    .tabItem {
                        Image(systemName: "person")
                        Text("My Grades")
                    }
                IBGrades()
                    .tabItem {
                        Image(systemName: "7.circle")
                        Text("IB Grades")
                    }
            }
        }
    }
}
