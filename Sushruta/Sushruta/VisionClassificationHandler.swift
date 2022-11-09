//
//  VisionClassificationFrameHandler.swift
//  Sushruta
//
//  Created by 劉鈺祥 on 2022/10/5.
//

import Vision
import AVFoundation
import UIKit

class VisionObjectClassificationFrameHandler : FrameHandler {
    
    private var flag: Bool = false
    private var requests = [VNRequest]()
    
    override init(){
        super.init()
        setupVision()
//        session.startRunning()
    }
    
    func startRunning(){
        session.startRunning()
    }
    
    func endRunning(){
        session.stopRunning()
    }

    
    @discardableResult
    func setupVision() -> NSError? {
        let error: NSError! = nil
        
        guard let modelURL = Bundle.main.url(forResource: "Resnet50FP16", withExtension: "mlmodelc") else{
            return NSError(domain: "VisionObjectDetectionViewController", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model file is missing"])
        }
        guard let detectionModelURL = Bundle.main.url(forResource: "yolov5s", withExtension: "mlmodelc") else{
            return NSError(domain: "VisionObjectDetectionViewController", code: -1, userInfo: [NSLocalizedDescriptionKey: "Detection file is missing"])
        }
        do {
            let classificationModel = try VNCoreMLModel(for: MLModel(contentsOf:  modelURL))
            let detectionModel = try VNCoreMLModel(for: MLModel(contentsOf: detectionModelURL))
            let objectClassification = VNCoreMLRequest(model: classificationModel, completionHandler: { (request, error) in
                DispatchQueue.main.async(execute: {
                    // perform all the UI updates on the main queue
                    if let results = request.results {
                        self.drawVisionRequestResults(results)
                    }
                })
            })
            let objectDetection = VNCoreMLRequest(model: detectionModel, completionHandler: { (request, error) in
                DispatchQueue.main.async(execute: {
                    // perform all the UI updates on the main queue
                    if let results = request.results {
                        self.drawVisionDetectionResults(results)
                    }
                })
            })
            objectClassification.imageCropAndScaleOption = .scaleFill
            objectDetection.imageCropAndScaleOption = .scaleFill
            self.requests = [objectClassification, objectDetection]

        } catch let error as NSError{
            print("Model loading went wrong: \(error)")
        }
        
        return error
    }
    
    func drawVisionRequestResults(_ results: [Any]){
        var result = ""
        let threshold: Float  = 0.3
        for observation in results where observation is VNClassificationObservation{
            guard let clsObservation = observation as? VNClassificationObservation else {
                continue
            }
            if(clsObservation.confidence > threshold){
                result += "\(clsObservation.identifier),"
            }
        }
        updatePredictionLabel(result)
    }
    
    func drawVisionDetectionResults(_ results: [Any]){
        let threshold: Float = 0.5
        for observation in results where observation is VNRecognizedObjectObservation {
            guard let detectObservation = observation as? VNRecognizedObjectObservation else {
                continue
            }
            
            let topLabelObservation = detectObservation.labels[0]
            print(detectObservation.boundingBox)
            let objectBounds = VNImageRectForNormalizedRect(detectObservation.boundingBox, Int(500), Int(300))
            if(topLabelObservation.confidence > threshold){
                updateBoundingBox(objectBounds)
                updateDetectionLabel(topLabelObservation.identifier)
            }
            else{
                updateBoundingBox(nil)
            }
        }
    }
    

    
    func updatePredictionLabel(_ message: String) {
        DispatchQueue.main.async {
            [unowned self] in
            self.label = message
        }
    }
    
    func updateBoundingBox(_ rect: CGRect?){
        DispatchQueue.main.async{
            [unowned self] in
            self.bbox = rect
        }
    }
    
    func updateDetectionLabel(_ message: String) {
        DispatchQueue.main.async {
            [unowned self] in
            self.detectionlabel = message
        }
    }
}


extension VisionObjectClassificationFrameHandler {
    override func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection){
        
        guard let cgImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else {return}
        
        DispatchQueue.main.async {
            [unowned self] in
            self.frame = cgImage
        }
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
    
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
}

