//
//  ProximiChatApp.swift
//  ProximiChat
//
//  Created by neon443 on 06/09/2025.
//

import SwiftUI

@main
struct ProximiChatApp: App {
	@StateObject var chatSession: ChatSession = ChatSession()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(\.chatSession, chatSession)
        }
    }
}
