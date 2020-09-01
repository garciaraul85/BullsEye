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
// 1x old devices 9 or older
// 2x retina screens
// 3x super HD retina, plus, ten, ten s
//

import SwiftUI

struct ContentView: View {
    // property that when changed, will refresh the ui
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var currentRound = 1
    @State var target = Int.random(in: 1...100)// random int from 1 to 100
    @State var score = 0
    
    // Colors
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    ///////////////////// Syles
    // Custom view?: ViewModifier receives view, modifies it and returns it back
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(Color.white)
                .modifier(ShadowStyle())
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .foregroundColor(Color.yellow)
                .modifier(ShadowStyle())
        }
    }
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .foregroundColor(Color.black)
        }
    }

    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
                .foregroundColor(Color.black)
        }
    }
    ////////////// end of styles

    
    var body: some View {
        VStack {
            
            Spacer()
            // Target row
            HStack {
                Text("Put the bulls eye as close as possible:").modifier(LabelStyle())
                Text("\(self.target)").modifier(ValueStyle())
            }
            Spacer()
            
            // Slider row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            
            // Button row
            HStack {
                Button(action: {
                    // print function
                    print("Button pressed!")
                    self.alertIsVisible = true
                }) {
                    Text("Hit me!").modifier(ButtonLargeTextStyle())
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
                }.background(Image("Button")).modifier(ShadowStyle())
            }
            
            Spacer()
            
            // Score row
            HStack {
                // Button column
                Button(action: {
                    resetGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                                 .renderingMode(.template)
                                 .foregroundColor(.white)
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(ShadowStyle())
                
                Spacer()
                // score columns
                Text("Score").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round").modifier(LabelStyle())
                Text("\(currentRound)").modifier(ValueStyle())
                Spacer()
                // Button column
                Button(action: {
                }) {
                    HStack {
                        Image("InfoIcon").accentColor(midnightBlue)
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(ShadowStyle())
                
                // bottom padding 20 points
                .padding(.bottom, 20)
            }
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(Color.white)
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
