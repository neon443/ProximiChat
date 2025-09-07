//
//  ContentView.swift
//  ProximiChat
//
//  Created by neon443 on 06/09/2025.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.chatSession) private var chatSession
	
    var body: some View {
        VStack {
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
