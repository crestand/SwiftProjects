//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Hamza Eren Koc on 5.02.2024.
//

import SwiftUI

struct ContentView: View {
    
    private static let numberOfQuestion = 8
    
    @State private var showingScore = false
    @State private var showingEndScore = false
    @State private var scoreTitle = ""
    
    @State private var currentScore = 0
    @State private var remainingQuestions = numberOfQuestion - 1
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {

        ZStack {
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Spacer()
                Spacer()
                Text("Score: \(currentScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                
                VStack(spacing: 15) {
                    
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        .alert(scoreTitle,isPresented: $showingScore){
                            Button("Next Question", action: newQuestion)
                        } message: {
                            Text("Your score is \(currentScore)")
                        }
                        .alert("Game Ended", isPresented: $showingEndScore){
                            Button("Restart the Game"){
                                resetGame()
                            }
                        } message: {
                            Text("Your final score is: \(currentScore)/8")
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding()
            
        }
    }
    
    func flagTapped(_ number:Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        
        if isGameEnded() {
            showingEndScore = true
        } else {
            showingScore = true
        }
        
    }
    
    func newQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        remainingQuestions -= 1
    }
    
    func resetGame() {
        remainingQuestions = ContentView.numberOfQuestion
        currentScore = 0
        newQuestion()
    }
    
    func isGameEnded() -> Bool {
        remainingQuestions == 0
    }
}

#Preview {
    ContentView()
}
