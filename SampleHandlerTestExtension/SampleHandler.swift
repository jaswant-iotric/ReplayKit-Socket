//
//  SampleHandler.swift
//  SampleHandlerTestExtension
//
//  Created by Jaswant Singh on 25/07/22.
//

import ReplayKit

class SampleHandler: RPBroadcastSampleHandler {
    
    private var clientSocket: RongRTCClientSocket?
    
    
    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
        clientSocket = RongRTCClientSocket()
        clientSocket?.createCliectSocket()
    }
    
    override func broadcastPaused() {
        // User has requested to pause the broadcast. Samples will stop being delivered.
    }
    
    override func broadcastResumed() {
        // User has requested to resume the broadcast. Samples delivery will resume.
    }
    
    override func broadcastFinished() {
        clientSocket?.close()
        clientSocket = nil
        // User has requested to finish the broadcast.
    }
    
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        switch sampleBufferType {
        case RPSampleBufferType.video:
            // Handle video sample buffer
            sendData(sampleBuffer)
            break
        case RPSampleBufferType.audioApp:
            // Handle audio sample buffer for app audio
            break
        case RPSampleBufferType.audioMic:
            // Handle audio sample buffer for mic audio
            break
        @unknown default:
            // Handle other sample buffer types
            fatalError("Unknown type of sample buffer")
        }
    }
    
    func sendData(_ sampleBuffer: CMSampleBuffer) {
        self.clientSocket?.encode(sampleBuffer)
    }
}
