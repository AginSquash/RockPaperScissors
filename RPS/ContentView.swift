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

struct CircleImage: View {
    var width: CGFloat
    var image: Image
    
    var body: some View
    {
            image
                .renderingMode(.original)
                .resizable()
                .frame(width: width, height: width, alignment: .center)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Capsule().stroke(Color.white, lineWidth: 3))
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
        var term = 0
        switch userChoice {
            case 0 where appChoice == 2:
                term = 1
            case 1 where appChoice == 0:
                term = 1
            case 2 where appChoice == 1:
                term = 1
            default:
                term = -1
        }
        let multiplier = shouldWin ? 1 * term : -1 * term
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
                
                CircleImage(width: 200, image: Image(availableChose[appChoice]) )
                
                Spacer()
                
                HStack(spacing: 30) {
                    ForEach(0..<3) { chose in
                        Button(action:
                        {
                            self.movement(userChoice: chose)
                        }) {
                            CircleImage(width: 100, image: Image(self.availableChose[chose]))
                        }
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $endMove) {
            Alert(title: Text(self.endMoveTitle), message: Text("Your new score: \(score)"), dismissButton: .default(Text("Ok")) {
                let oldChose = self.appChoice
                while (self.appChoice == oldChose)
                {
                    self.appChoice = Int.random(in: 0...2)
                }
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
