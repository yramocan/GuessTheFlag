//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Yuri Ramocan on 4/7/20.
//  Copyright © 2020 Yuri Ramocan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var currentScore = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .frame(maxWidth: .infinity)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(countryName: self.countries[number])
                    }
                }

                Text("Current score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.semibold)

                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(
                title: Text(scoreTitle),
                message: Text("Your score is \(currentScore)"),
                dismissButton: .default(Text("Okay")) {
                    self.askQuestion()
                }
            )
        }
    }

    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
            askQuestion()
        } else {
            scoreTitle = "Wrong, that's \(countries[number])!"
            showingScore = true
        }
    }
}

struct FlagImage: View {
    var countryName: String

    var body: some View {
        Image(countryName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
