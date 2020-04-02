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
    
    @State var endMove = false;
    @State var endMoveTitle = ""
    
    func movement(userChoice: Int)
    {
        var factor = 0
        switch userChoice {
            case 0 where appChoice == 2:
                factor = 1
            case 1 where appChoice == 0:
                factor = 1
            case 2 where appChoice == 1:
                factor = 1
            default:
                factor = -1
        }
        let multiplier = shouldWin ? 1 * factor : -1 * factor
        self.score += multiplier
        
        if (multiplier > 0)
        {
             self.endMoveTitle = "Correct"
        } else {
             self.endMoveTitle = "Wrong"
        }
        self.endMove = true
        print(userChoice)
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
        .alert(isPresented: $endMove) {
            Alert(title: Text(self.endMoveTitle), message: Text("Your new score: \(score)"), dismissButton: .default(Text("Ok")) {
                self.appChoice = Int.random(in: 0...2)
                self.shouldWin = Bool.random()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
