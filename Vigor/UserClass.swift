//
//  UserClass.swift
//  Vigor
//
//  Created by pratham on 7/25/16.
//  Copyright © 2016 MPRJ. All rights reserved.
//

import Foundation

class User{
    private var nm : String
    private var eml : String
    private var imgURL : String
    
    var Name : String {
        get{
            return nm
        }
        set{
            nm = newValue
        }
        
    }
    
    var Email : String {
        get{
            return eml
        }
        set{
            eml = newValue
        }
        
    }
    var imageUrl : String {
        get{
            return imgURL        }
        set{
            imgURL = newValue
        }    }
    
    
    init(){
        
        self.nm = "Richard Hendricks"
        self.eml = "Richard.Hendricks@gmail.com"
        self.imgURL = "sample.png"
    }
    
    func userPrint()
    {
        print("\(Name),\(Email),\(imageUrl)")
    }
    
//    init(Name:String,Email:String){
//        self.nm = HP
//        self.attckPwr = attackPower
//        self.nm = name
//
    
    
}