//
//  Meal.swift
//  FoodTracker
//
//  Created by lyxia on 2016/7/26.
//  Copyright © 2016年 lyxia. All rights reserved.
//

import UIKit

class Meal:NSObject, NSCoding {
    //MAEK: Properties
    
    var name:String
    var photo:UIImage?
    var rating:Int
    static var FilePath:String {
        let documentDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let fileDir = documentDir.appending("/meals")
        print(fileDir)
        return fileDir
    }
    
    init?(name:String, photo:UIImage?, rating:Int) {
        //Initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        //Initialize should fialed if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    //MARK : Coding
    enum PropertyKey: String{
        case name
        case photo
        case rating
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name.rawValue)
        aCoder.encode(photo, forKey: PropertyKey.photo.rawValue)
        aCoder.encode(rating, forKey: PropertyKey.rating.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.name.rawValue) as! String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo.rawValue) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating.rawValue)
        self.init(name:name, photo:photo, rating:rating)
    }

}
