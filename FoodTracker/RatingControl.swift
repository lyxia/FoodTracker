//
//  RatingControl.swift
//  FoodTracker
//
//  Created by lyxia on 2016/7/24.
//  Copyright © 2016年 lyxia. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    // MARK: Properties
    var rating = 0
        {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        let filledStarImage = UIImage(named:"filledStar")
        let emptyStarImage = UIImage(named:"emptyStar")
        for _ in 0..<starCount {
            let button = UIButton()
            button.setImage(emptyStarImage, for: .normal)
            button.setImage(filledStarImage, for: .selected)
            button.setImage(filledStarImage, for: [.selected, .highlighted])
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchDown)
    
            ratingButtons += [button]
            addSubview(button)
        }
        
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = 44
        let width = (buttonSize + spacing) * starCount
        
        return CGSize(width: width, height: buttonSize)
    }

    override func layoutSubviews() {
        let buttonSize = Int(frame.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        invalidateIntrinsicContentSize()
        
        updateButtonSelectionStates()
    }
    
    // MARK: Button Action
    func ratingButtonTapped(button:UIButton) {
        rating = ratingButtons.index(of: button)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
