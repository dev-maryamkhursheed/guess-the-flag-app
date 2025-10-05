//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Maryam Khursheed on 2025-10-02.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Italy", "Ireland", "Spain", "UK", "Nigeria", "Poland", "Ukraine", "US", "Canada"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    
    
    var body: some View {
        ZStack {
            
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.1, blue: 0.3), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
           
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .foregroundStyle(.white).font(.largeTitle).bold()
                VStack(spacing: 20){
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary).font(.headline)
                        Text(countries[correctAnswer]).foregroundStyle(.secondary).font(.title).bold()
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number]).cornerRadius(40).shadow(radius: 10)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(30)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 40))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white).font(.title2).bold()
                Spacer()
            }
            .padding(20)

        }.alert(scoreTitle, isPresented: $showingScore ) {
            Button("Continue", action: askNewQuestion)
        } message: {
            Text("You score is \(score)")
        }
        
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    
    func askNewQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
