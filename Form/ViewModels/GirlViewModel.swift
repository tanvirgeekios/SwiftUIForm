//
//  GirlViewModel.swift
//  Form
//
//  Created by MD Tanvir Alam on 15/1/21.
//

import Foundation
import SwiftUI
import CoreLocation

class GirlViewModel:NSObject,ObservableObject,CLLocationManagerDelegate{
    @Published var fullname = ""
    @Published var age = ""
    @Published var isHot = true
    @Published var sexualOrientation = ""
    @Published var showActionSheet = false
    @Published var showImagePicker = false
    @Published var sourceType : UIImagePickerController.SourceType = .camera
    @Published var image:UIImage?
    var sexualOrientationArray = ["Straight", "Lesbian", "BiSexual", "TransGender"]
    
    //Location
    @Published var locationManager = CLLocationManager()
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Authorized")
            locationManager.startUpdatingLocation()
        case .denied:
            print("Denied")
        default:
            print("Unknown")
          
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        self.extractLocation()
    }
    
    func extractLocation(){
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { res, err in
            guard let safeData = res else {return}
            var address = ""
            
            address += safeData.first?.name ?? ""
            address += ","
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
    
}
