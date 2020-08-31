//
//  ContentView.swift
//  BullsEye
//
//  Created by Saulo Garcia on 8/31/20.
//

import SwiftUI

struct ContentView: View {
    // property that when changed, will refresh the ui
    @State var alertIsVisible: Bool = false
    
    // some object behaves like a view but its not a view
    var body: some View {
        VStack { // Arrange objects vertically
            // Text object
            Text("Hola mundo")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.blue)
                .padding()
            // Button object1
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
                return Alert(title:   Text("Hello there!"),
                             message: Text("This is my first pop-up"),
                             dismissButton: .default(Text("Awesome")))
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
