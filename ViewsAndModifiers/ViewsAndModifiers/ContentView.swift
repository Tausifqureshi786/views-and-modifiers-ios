//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Tausif Qureshi on 2023-01-16.
//

import SwiftUI


// Custom modifier:
// It is a struct which has a function that takes in the content send and returns that content with the applied modifiers to be reused in the app

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomLeading) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
                .clipShape(Capsule())
                .padding(5)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

// this struct is used to implement View Composition in the app.
struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}

// It's a smarter way to add an extension to the View struct so that the modifier can be used easily in the app.
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    
    // Defining views as a property
    var greatDojutsus: some View {
        Group {
            Text("Sharingan")
            Text("Rinnagan")
            Text("Byakugan")
        }
    }
    
    var body: some View {
        
        ZStack {
            Color.green
                .ignoresSafeArea()
                .watermarked(with: "Hacking with Tausif")
            VStack {
                
                Spacer()
                Group {
                    Text("Hello Ninja's")
                        .titleStyle()
                }
                VStack(spacing: 40) {
                    Text("The three Great Dōjutsu's in Naruto are:")
                    greatDojutsus
                        .frame(width: 300, height: 10, alignment: .leading)
                }.font(.title)
                    .padding()
                
                Spacer()
                HStack(spacing:10) {
                    // Example of View Composition
                    // Not to worry as this is quite efficient in Swift
                    CapsuleText(text: "First")
                        .foregroundColor(.white)
                    CapsuleText(text: "Second")
                        .foregroundColor(.yellow)
                }
                Spacer()
                Spacer()
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
