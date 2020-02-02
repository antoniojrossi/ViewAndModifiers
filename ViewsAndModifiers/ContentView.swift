//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Antonio J Rossi on 02/02/2020.
//  Copyright © 2020 Antonio J Rossi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack(spacing: 10) {
//            CapsuleText(text: "First")
//                .foregroundColor(.white)
//            CapsuleText(text: "Second")
//                .foregroundColor(.green)
//            Text("Hello World")
//                .titleStyle()
//            Color.blue
//                .frame(width: 300, height: 200)
//                .watermarked(with: "Hacking with Swift")
//        }
        
        GridStack(rows: 4, columns: 4) {row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
//        Color.blue
//            .frame(width: 200, height: 200)
//            .titleized(with: "Blue color")
    }
}

struct CapsuleText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(text)
                .font(.largeTitle)
                .foregroundColor(.blue)
            content
        }
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping(Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func titleized(with text: String) -> some View {
        self.modifier(Title(text: text))
    }
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}
