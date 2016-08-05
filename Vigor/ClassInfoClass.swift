//
//  ClassInfo.swift
//  Vigor
//
//  Created by pratham on 8/3/16.
//  Copyright © 2016 MPRJ. All rights reserved.
//

import Foundation

class ClassInfo{
    private var clssPrflID : String!
    private var clssPrfleImgURL : String!
    private var clssPrflTtl : String!
    private var clssPrflDscrptn : String!
    private var clssPrflPrc : String!
    private var clssPrflAddrss : String!
    
    var classProfileImageURL : String {
        get{
            return clssPrfleImgURL
        }
        set{
            clssPrfleImgURL = newValue
        }
        
    }
    var classProfileTitle : String {
        get{
            return clssPrflTtl
        }
        set{
            clssPrflTtl = newValue
        }
        
    }
    var classProfileDescription : String {
        get{
            return clssPrflDscrptn
        }
        set{
            clssPrflDscrptn = newValue
        }
        
    }
    var classProfilePrice : String {
        get{
            return clssPrflPrc
        }
        set{
            clssPrflPrc = newValue
        }
        
    }
    var classProfileID : String {
        get{
            return clssPrflID
        }
        set{
            clssPrflID = newValue
        }
        
    }
    var classProfileAddress : String {
        get{
            return clssPrflAddrss
        }
        set{
            clssPrflAddrss = newValue
        }
        
    }
    
    
    init(){
        self.classProfileImageURL = "sample.png"
        self.classProfileTitle = "Class Title "
        self.classProfileDescription = "Brief Description Brief Description Brief Description Brief Description Brief Description Brief Description Brief Description Brief Description Brief DescriptionBrief Description Brief Description Brief DescriptionBrief DescriptionBrief DescriptionBrief"
        self.clssPrflPrc = "0"
        self.classProfileID = "00000000"
        self.classProfileAddress = "000 sample st , San Jose  Ca 95139"
    }
    
    
}