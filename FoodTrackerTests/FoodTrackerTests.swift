//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by lyxia on 2016/7/23.
//  Copyright © 2016年 lyxia. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: FoodTracker Tests
    
    //Tests to confirm that Meal Intatializer returns when no name or a nagetive rating is provided.
    func testMealIntailzation() {
        //Success case.
        let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        //Failure cases
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative ratings are invalid, be positive")
    }
    
}
