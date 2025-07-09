//
//  ContentView.swift
//  DemoApp
//
//  Created by Patrick Dinger on 09.07.2025.
//

import SwiftUI
import SwiftUIIntrospect

struct ContentView: View {
    @State var selection: String? = nil // Change this to "One" and things will be called correctly
    @State var called = false
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Text("One").tag("One")
                Text("Two").tag("Two")
            }

            Text(called ? "Called" : "Not called")
                .fontWeight(.bold)
                .foregroundStyle(called ? .green : .red)
        } detail: {
            if let selection {
                // I think the issue is relate with conditionally showing a ScrollView
                ScrollView {
                    VStack {
                        ForEach(0 ..< 50, id: \.self) { index in
                            Text("\(selection) \(index + 1)")
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .introspect(
                    .scrollView,
                    on: .macOS(.v14, .v15, .v26),
                    customize: { _ in
                        print("Called")
                        called = true
                    }
                )
            } else {
                Text("Nothing")
            }
        }
    }
}

#Preview {
    ContentView()
}
