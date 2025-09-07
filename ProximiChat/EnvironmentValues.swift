//
//  EnvironmentValues.swift
//  ProximiChat
//
//  Created by neon443 on 07/09/2025.
//

import Foundation
import SwiftUI

private struct ChatSessionKey: EnvironmentKey {
	static let defaultValue: ChatSession = ChatSession()
}

extension EnvironmentValues {
	var chatSession: ChatSession {
		get { self[ChatSessionKey.self] }
		set { self[ChatSessionKey.self] = newValue }
	}
}
