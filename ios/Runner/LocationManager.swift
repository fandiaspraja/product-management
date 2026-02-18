//
//  LocationManager.swift
//  Runner
//
//  Created by fikry andias praja on 29/03/25.
//

import Foundation
import CoreLocation
import Flutter

class LocationManager: NSObject, FlutterPlugin, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    var result: FlutterResult?
    
    @objc(registerWithRegistrar:) static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "location_channel", binaryMessenger: registrar.messenger())
        let instance = LocationManager()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "checkLocationPermission" {
            self.result = result
            checkLocationPermission()
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    func checkLocationPermission() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                result?("denied")
            case .authorizedAlways, .authorizedWhenInUse:
                result?("granted")
            @unknown default:
                break
            }
        } else {
            result?("Location services are not enabled")
        }
    }
    
    // Implement CLLocationManagerDelegate methods if needed
    
    // For example:
    // func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //     // Handle location updates
    // }
    
    // func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    //     // Handle location error
    // }
}
