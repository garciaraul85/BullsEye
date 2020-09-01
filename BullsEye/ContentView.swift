//
//  ContentView.swift
//  BullsEye
//
//  Created by Saulo Garcia on 8/31/20.
// Bindings: ui is tied to state of a variable
// String interpolation example : "The slider value is \(self.sliderValue)"
// var -> mutable
// let -> inmutable
// global scope -> visible everywhere
// instance scope -> visible in class
// local scope -> visible only in func
//

import SwiftUI

struct ContentView: View {
    // property that when changed, will refresh the ui
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var currentRound = 1
    @State var target = Int.random(in: 1...100)// random int from 1 to 100
    @State var score = 0
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bulls eye as close as possible:")
                Text("\(self.target)")
            }
            Spacer()
            
            // Slider row
            HStack {
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            
            // Button row
            HStack {
                Button(action: {
                    // print function
                    print("Button pressed!")
                    self.alertIsVisible = true
                }) {
                    Text("Hit me!")
                }
                // state variables use $
                .alert(isPresented: $alertIsVisible) { () ->
                    Alert in
                    return Alert(title:   Text(alertTitle()),
                                 message: Text("The slider value is \(sliderValueRounded()) \n" +
                                                "You scored points \(self.pointsForCurrentRound()) this round "),
                                 dismissButton: .default(Text("Awesome")) {
                                    self.score += self.pointsForCurrentRound()
                                    self.target = Int.random(in: 1...100)
                                    self.currentRound += 1
                                 })
                }
            }
            Spacer()
            
            // Score row
            HStack {
                // Button column
                Button(action: {
                    resetGame()
                }) {
                    Text("Start over")
                }
                Spacer()
                // score columns
                Text("Score")
                Text("\(score)")
                Spacer()
                Text("Round")
                Text("\(currentRound)")
                Spacer()
                // Button column
                Button(action: {
                }) {
                    Text("Info")
                }
                // bottom padding 20 points
                .padding(.bottom, 20)
            }
        }
    }
    
    func amountOff() -> Int {
        return abs(self.target - sliderValueRounded())
    }
    
    func sliderValueRounded() -> Int {
        Int(self.sliderValue.rounded())// same as return Int(self.sliderValue.rounded()) if you have 1 line only
    }
    
    func pointsForCurrentRound() -> Int {
        let maxScore = 100
        let difference = amountOff()
        let bonus: Int
        if (difference == 0) {
            bonus = 100
        } else if (difference == 1) {
            bonus = 50
        } else {
            bonus = 0
        }
        return maxScore - difference + bonus
    }
    
    func resetGame() {
        self.score = 0
        self.currentRound = 1
        self.sliderValue = 50.0
        self.target = Int.random(in: 1...100)
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if (difference == 0) {
            title = "Perfect!"
        } else if (difference < 5) {
            title = "You almost had it!"
        } else if (difference <= 10) {
            title = "Not bad"
        } else {
            title = "Are you even trying?"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
