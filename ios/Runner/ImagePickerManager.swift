//
//  ImagePickerManager.swift
//  Runner
//
//  Created by fikry andias praja on 29/03/25.
//

import UIKit

class ImagePickerManager: NSObject, FlutterPlugin, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker: UIImagePickerController!
    var result: FlutterResult?
    
    @objc(registerWithRegistrar:) static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "image_picker_channel", binaryMessenger: registrar.messenger())
        let instance = ImagePickerManager()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "pickGalleryImage" || call.method == "pickCameraImage" {
            self.result = result
            
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = call.method == "pickCameraImage" ? .camera : .photoLibrary
            
            // Set any additional properties of the imagePicker if needed
            
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    func pickImage(result: @escaping FlutterResult, source: UIImagePickerController.SourceType) {
        self.result = result
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        
        // Set any additional properties of the imagePicker if needed
        
        UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        let imageData = image?.jpegData(compressionQuality: 0.25)
        
        // Call the Flutter result with the picked image data
        result?(FlutterStandardTypedData(bytes: imageData!))
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Call the Flutter result with null to indicate cancellation
        result?(nil)
        
        picker.dismiss(animated: true, completion: nil)
    }
}
