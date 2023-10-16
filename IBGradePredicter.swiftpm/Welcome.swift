//
//  Welcome.swift
//  Grade Tracker
//
//  Created by Gustavo Garfias on 23/04/22.
//

import Foundation
import SwiftUI

struct Welcome: View {
    
    @State var active = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to IB Grades Predicter!")
                    .font(.title)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                
                Text("By inputting your predicted grades given to you by your teacher, you can predict you actual final grades according to the accuracy of your teacher's past predictions.")
                    .font(.body)
                    .padding([.horizontal, .top], 30)
                
                Text("Remember to input your predicted grade in the official 1-7 range, and make sure that you select the correct level that you are taking the subject at.\n\nPlease don't forget that this calculation is based on your teacher's performance, so always take it with a grain of salt and keep working hard to do great in your final exams 😀")
                    .font(.footnote)
                    .padding(.bottom)
                    .padding(25)
                                
                NavigationLink(destination: IBGrades(), isActive: $active) { EmptyView() }
                Button("Let's Go!") {
                    self.active = true
                }
                .buttonStyle(.borderedProminent)
                .font(.headline)
                
                Spacer()
            }
        }
    }
}
