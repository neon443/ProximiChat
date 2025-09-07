//
//  ChatSession.swift
//  ProximiChat
//
//  Created by neon443 on 07/09/2025.
//

import Foundation
import MultipeerConnectivity
import OSLog

class ChatSession: NSObject, ObservableObject {
	private let serviceType: String = "ProximiChatSession"
	private let myPeerID: MCPeerID = MCPeerID(displayName: UIDevice.current.name)
	private let serviceAdvertiser: MCNearbyServiceAdvertiser
	private let serviceBrowser: MCNearbyServiceBrowser
	private let session: MCSession
	private let log = Logger()
	
	override init() {
		self.session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .none)
		self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: serviceType)
		self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
		
		super.init()
		
		session.delegate = self
		serviceAdvertiser.delegate = self
		serviceAdvertiser.startAdvertisingPeer()
		serviceBrowser.startBrowsingForPeers()
	}
	
	deinit {
		serviceBrowser.stopBrowsingForPeers()
		serviceAdvertiser.stopAdvertisingPeer()
	}
}

extension ChatSession: MCNearbyServiceAdvertiserDelegate {
	func advertiser(
		_ advertiser: MCNearbyServiceAdvertiser,
		didNotStartAdvertisingPeer error: any Error
	) {
		log.error("serviceAdvertiser: didNotStartAdvertisingPeer: \(String(describing: error))")
	}
	
	func advertiser(
		_ advertiser: MCNearbyServiceAdvertiser,
		didReceiveInvitationFromPeer peerID: MCPeerID,
		withContext context: Data?,
		invitationHandler: @escaping (Bool, MCSession?) -> Void
	) {
		log.info("serviceAdvertiser: didReceiveInvitationFromPeer: \(peerID)")
	}
}

extension ChatSession: MCNearbyServiceBrowserDelegate {
	func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: any Error) {
		log.error("serviceBrowser: didNotStartAdvertisingPeer: \(String(describing: error))")
	}
	
	func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
		log.info("serviceBrowser: didNotStartAdvertisingPeer: \(peerID)")
	}
	
	func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
		log.info("serviceBrowser: foundPeer: \(peerID)")
	}
}

extension ChatSession: MCSessionDelegate {
	func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
		log.info("session: peer \(peerID) didChangeState \(state.rawValue)")
	}
	
	func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
		log.info("session: peer \(peerID) sent \(data.count) bytes")
	}
	
	func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
		log.info("session: didRecieveStream named \(streamName) from \(peerID)")
	}
	
	func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
		guard certificate != nil else { return }
		log.info("session: didRecieveCert from \(peerID)")
	}
	
	func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
		log.info("session: started recieving \(resourceName) from \(peerID) at \(progress.fractionCompleted)")
	}
	
	func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: (any Error)?) {
		log.info("session: finished recieving \(resourceName) from \(peerID) at \(String(describing: localURL))")
		if let error {
			log.error("session: didFinishRecieve error \(String(describing: error))")
		}
	}
}
