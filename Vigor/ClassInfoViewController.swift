//
//  ClassInfoViewController.swift
//  Vigor
//
//  Created by pratham on 8/3/16.
//  Copyright © 2016 MPRJ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import MapKit


class ClassInfoViewController: UIViewController,UINavigationControllerDelegate{
    
    @IBOutlet weak var ClassProfilePic: UIImageView!
    @IBOutlet weak var ClassLabel: UILabel!
    @IBOutlet weak var ClassButton: UIButton!
    @IBOutlet weak var ClassDesc: UITextView!
    @IBOutlet weak var ClassAddress: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
   // @IBOutlet weak var ClassInstructorProfilePicture: UIImageView!
    
    
    var refHandle: UInt!
    var base64String: NSString!
    let imageCache = NSCache()
    var imageURL = classInfoVar.classProfileImageURL
    
    let regionRadius: CLLocationDistance = 1000

    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        
    //ClassInstructorProfilePicture.layer.cornerRadius = self.ClassInstructorProfilePicture.frame.size.width / 2
    
    //makeImageRounder()
        
    scrollView.contentSize.height = 200
    
    ClassLabel.text = classInfoVar.classProfileTitle
    ClassDesc.text = classInfoVar.classProfileDescription
    ClassAddress.text = classInfoVar.classProfileAddress
    ClassButton.setTitle("$\(classInfoVar.classProfilePrice) - BOOK CLASS", forState: .Normal)
    
    print(classInfoVar.locationLatitude)
    print(classInfoVar.locationLongitude)
        
    let initialLocation = CLLocation(latitude: classInfoVar.locationLatitude, longitude: classInfoVar.locationLongitude)
    let dropPin = MKPointAnnotation()
    let locationPin = CLLocationCoordinate2D(latitude: classInfoVar.locationLatitude,longitude: classInfoVar.locationLongitude)
    dropPin.coordinate = locationPin
    dropPin.title = classInfoVar.classProfileTitle
        
    mapView.addAnnotation(dropPin)
    centerMapOnLocation(initialLocation)
        
  
//        ClassInstructorProfilePicture.layer.borderWidth = 3
//        ClassInstructorProfilePicture.layer.masksToBounds = true
//        ClassInstructorProfilePicture.layer.borderColor = UIColor.whiteColor().CGColor
//        ClassInstructorProfilePicture.layer.cornerRadius = 36
//     //   ClassInstructorProfilePicture.layer.cornerRadius = self.ClassInstructorProfilePicture.frame.size.width / 2
//        ClassInstructorProfilePicture.clipsToBounds = true
//
    
        
        let storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL("gs://vigor-eaf6d.appspot.com")
        let imageRef = storageRef.child(imageURL)
        
        
        
        
        if let cachedImage = self.imageCache.objectForKey(imageURL) as? UIImage{
            
            self.ClassProfilePic.image = cachedImage
            return
            
            
            
        }
        
        
        imageRef.dataWithMaxSize(6144*6144*6144*6144*6144) { (data, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                if let profileImage = UIImage(data: data!){
                    self.imageCache.setObject(profileImage, forKey: self.imageURL)
                    //self.ClassProfilePic.image = profileImage
                }
            }
        }
    
    
    }
    
    func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func BackButtonPressed(sender: AnyObject) {
        
       self.performSegueWithIdentifier("ClassInfoToHome", sender: self)
        
    }
//    func makeImageRounder(){
//        ClassInstructorProfilePicture.layer.borderWidth = 3
//        ClassInstructorProfilePicture.layer.masksToBounds = true
//        ClassInstructorProfilePicture.layer.borderColor = UIColor.whiteColor().CGColor
//        ClassInstructorProfilePicture.layer.cornerRadius = self.ClassInstructorProfilePicture.frame.size.width / 2
//        ClassInstructorProfilePicture.clipsToBounds = true
//    }
}