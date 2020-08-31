//
//  ContentView.swift
//  BullsEye
//
//  Created by Saulo Garcia on 8/31/20.
// Bindings: ui is tied to state of a variable
// String interpolation example : "The slider value is \(self.sliderValue)"
// var -> mutable
// let -> inmutable
//

import SwiftUI

struct ContentView: View {
    // property that when changed, will refresh the ui
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bulls eye as close as possible:")
                Text("100")
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
                    let roundedValue = Int(self.sliderValue.rounded()) // cast to int
                    return Alert(title:   Text("Hello there!"),
                                 message: Text("The slider value is \(roundedValue)"),
                                 dismissButton: .default(Text("Awesome")))
                }
            }
            Spacer()
            
            // Score row
            HStack {
                // Button column
                Button(action: {
                }) {
                    Text("Start over")
                }
                Spacer()
                // score columns
                Text("Score")
                Text("999999")
                Spacer()
                Text("Round")
                Text("999")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
