//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Linda Lau on 9/22/22.
//

import SwiftUI

struct ContentView: View {
    @State private var scoreDisplay = false
    @State private var scoreDisplayTitle = ""
    @State private var round = 1
    @State private var score = 0
    @State private var scoreMessage = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    // automatically picks a random number
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            //LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
                VStack(spacing: 15){
                    VStack{
                        Text("\(round). Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagButton_Clicked(number)
                        } label: {
                            FlagImage(img: countries[number])
                        }
                        .alert(scoreDisplayTitle, isPresented: $scoreDisplay){
                            Button("Continue", action: nextQuestion)
                        } message: {
                            Text(scoreMessage)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
            }
            .padding()
        }
    }
    
    func flagButton_Clicked(_ number: Int){
        if number == correctAnswer {
            score += 1
            scoreMessage = "You are correct!\nScore: \(score)/8"
            scoreDisplayTitle = "Correct"
        }
        else {
            scoreMessage = "Oops! That is the flag of \(countries[number]).\nScore: \(score)/8"
            scoreDisplayTitle = "Wrong"
        }
        
        scoreDisplay = true
    }
    
    func nextQuestion(){
        if round == 8{
            score = 0
            round = 1
        }
        else{
            round += 1
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct FlagImage: View{
    var img: String
    
    var body: some View{
        Image(img)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
