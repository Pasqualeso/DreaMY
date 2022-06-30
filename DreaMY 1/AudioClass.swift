//
//  AudioClass.swift
//  DreaMY 1
//
//  Created by Sorrentino Pasquale on 02/12/2020.
//

import Foundation
import UIKit
import Speech

class AudioClass : ObservableObject {
    
    @Published var isRunning = false
    
    var file: AVAudioFile?
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    //Per ricevere input dal microfono:
    private let audioEngine = AVAudioEngine()
    
    var testo : String = ""
    
    var isEnabled = false
    
    func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in

            // Divert to the app's main thread so that the UI
            // can be updated.
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.isEnabled = true
                    
                default:
                    self.isEnabled = false
                }
            }
            
        }
    }
    
    func startRecording() throws {
        
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                // Update the text view with the results.
                self.testo = result.bestTranscription.formattedString
                isFinal = result.isFinal
                print("Text \(result.bestTranscription.formattedString)")
            }
            
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.isEnabled = true
            }
        }

        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    func recordButtonTapped() {
        if audioEngine.isRunning {
            isRunning = false
            audioEngine.stop()
            recognitionRequest?.endAudio()
            isEnabled = false
        } else {
            isRunning = true
            do {
                try startRecording()
                
            } catch {
                
            }
        }
    }
    
    /*
    func URLFor(filename: String) -> NSURL? {
        if let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String] {
            let dir = dirs[0] //documents directory
            let path = dir.stringByAppendingPathComponent(filename)
            return NSURL(fileURLWithPath: path)
        }
        return nil
    }
    */
}
