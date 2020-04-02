//
//  ContentView.swift
//  RPS
//
//  Created by Vlad Vrublevsky on 03.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import SwiftUI

struct configButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.pink)
            .shadow(radius: 5)
            .font(.largeTitle)
    }
}

struct configText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .shadow(radius: 5)
    }
}

extension View {
    func textConfigurator() -> some View {
        self.modifier(configText())
    }
    func buttonConfigurator() -> some View {
        self.modifier(configButton())
    }
}

struct ContentView: View {
    let availableChose = ["Rock", "Paper", "Scissors"]
    
    @State var appChoice = Int.random(in: 0...2)
    @State var shouldWin = Bool.random()
    @State var score = 0
    
    func movement(userChoice: Int)
    {
        let multiplier = shouldWin ? 1 : -1
        switch userChoice {
            case 0 where appChoice == 2:
                self.score += multiplier
            case 1 where appChoice == 0:
                self.score += multiplier
            case 2 where appChoice == 1:
                self.score += multiplier
            default:
                self.score -= multiplier
        }
        print(userChoice)
        self.appChoice = Int.random(in: 0...2)
        self.shouldWin = Bool.random()
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Rock Paper or Scissors")
                    .textConfigurator()
                    .font(.headline)
                HStack {
                    Text("You need to")
                        .textConfigurator()
                    Text("\(shouldWin ? "win" : "lose")")
                        .foregroundColor(shouldWin ? .green : .yellow)
                        .font(.headline)
                    Spacer()
                    Text("Score: \(score)")
                    .textConfigurator()
                }.padding()
                
                Spacer()
                // Image ?
                Text("\(availableChose[appChoice])")
                    .textConfigurator()
                    .font(.largeTitle)
                //
                Spacer()
                
                HStack(spacing: 30) {
                    ForEach(0..<availableChose.count) { chose in
                        Button(self.availableChose[chose])
                        {
                            self.movement(userChoice: chose)
                        }
                    .buttonConfigurator()
                    }
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
