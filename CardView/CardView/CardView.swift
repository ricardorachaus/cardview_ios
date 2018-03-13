//
//  CardView.swift
//  CardView
//
//  Created by Ricardo Rachaus on 12/03/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

/**
 Implementation of a customized UIImageView to have
 a flip animation like a card.
 */
class CardView: UIImageView {

    // MARK: - Properties
    
    /// Duration of the flip animation.
    var flipDuration: TimeInterval = 0.5
    
    /// If is showing the front of the card.
    @IBInspectable var isShowing: Bool = false
    /// Image that represents the back of the card.
    @IBInspectable var back: UIImage?
    /// Image that represents the front of the card.
    @IBInspectable var front: UIImage?
    
    
    // MARK: - Initilization Methods
    
    
    /**
     Initialize with back image, front and duration of the flip.
     
     - parameters:
         - back: Image that represents the back of the card.
         - front: Image that represents the front of the card.
         - duration: Duration of the flip animation.
     - Returns: self : CardView
     */
    init(back: UIImage, front: UIImage, duration: TimeInterval) {
        self.flipDuration = duration
        self.back = back
        self.front = front
        super.init(image: back)
        addTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTapGesture()
    }
    
    
    // MARK: - Flip Methods
    
    
    /**
     Flip the image view like a card flip.
     
     - parameters:
         - sender: Tap gesture.
     */
    @objc private func flip(_ sender: UITapGestureRecognizer) {
        if let back = back,
           let front = front {
        
            if isShowing {
                self.image = back
                UIView.transition(with: self, duration: flipDuration,
                                  options: .transitionFlipFromLeft,
                                  animations: nil, completion: nil)
            }
            else {
                self.image = front
                UIView.transition(with: self, duration: flipDuration,
                                  options: .transitionFlipFromRight,
                                  animations: nil, completion: nil)
            }
         
            isShowing = !isShowing
        }
    }
    
    
    // MARK: - Gesture Methods
    
    
    /**
     Add the tap gesture to the view.
     */
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(flip))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        isUserInteractionEnabled = true
        
        addGestureRecognizer(tap)
    }
    
}
