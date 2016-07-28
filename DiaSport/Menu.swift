//
//  Menu.swift
//  DiaSport
//
//  Created by Marek Mako on 28/07/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController, MenuViewDelegate {
    
    override func viewDidLoad() {
        if let menuView = view as? MenuView {
            menuView.delegate = self
        }
    }
    
    // MARK: MenuViewDelegate
    
    func upButtonDidTouch() { // go to calc
        guard let ctrl = storyboard?.instantiateViewControllerWithIdentifier(CALC_STORYBOARD_ID) else {
            return
        }
        presentViewControllerModaly(ctrl)
    }
    
    func downButtonDidTouch() { // go to social
        guard let ctrl = storyboard?.instantiateViewControllerWithIdentifier(SOCIAL_STORYBOARD_ID) else {
            return
        }
        presentViewControllerModaly(ctrl)
    }
    
    func leftButtonDidTouch() { // go to hnowhow
        guard let ctrl = storyboard?.instantiateViewControllerWithIdentifier(KNOWHOW_STORYBOARD_ID) else {
            return
        }
        presentViewControllerModaly(ctrl)
    }
    
    func rightButtonDidTouch() { // go to settings
        guard let ctrl = storyboard?.instantiateViewControllerWithIdentifier(SETTINGS_STORYBOARD_ID) else {
            return
        }
        presentViewControllerModaly(ctrl)
    }
    
    private func presentViewControllerModaly(viewControllerToPresent: UIViewController) {
        viewControllerToPresent.modalPresentationStyle = .OverCurrentContext
        presentViewController(viewControllerToPresent, animated: true, completion: nil)
    }
}


protocol MenuViewDelegate {
    func upButtonDidTouch()
    func downButtonDidTouch()
    func leftButtonDidTouch()
    func rightButtonDidTouch()
}


enum MenuViewButtonTypes {
    case Up, Down, Left, Right
}



class MenuView: UIView {
    
    var delegate: MenuViewDelegate?
    
    var upButton: UIButton!
    var downButton: UIButton!
    var leftButton: UIButton!
    var rightButton: UIButton!
    
    var round1Rect: CGRect!
    var round2Rect: CGRect!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor(red: 92/255, green: 182/255, blue: 214/255, alpha: 1)
        
        // SETTINGS
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        // Button Setting
        let buttonWidth: CGFloat = 75
        let buttonHeight: CGFloat = 55
        let buttonCenterXPos: CGFloat = ((screenWidth / 2) - (buttonWidth / 2))
        let buttonCenterYPos: CGFloat = ((screenHeight / 2) - (buttonHeight / 2))
        
        
        // Buttons
        
        // up
        let upButtonXPos: CGFloat = buttonCenterXPos
        let upButtonYPos: CGFloat = (buttonCenterYPos / 5) * 3
        upButton = createButton(CGRectMake(upButtonXPos, upButtonYPos, buttonWidth, buttonHeight), type: .Up)
        addSubview(upButton)
        // down
        let downButtonXPos: CGFloat = buttonCenterXPos
        let downButtonYPos: CGFloat = ((buttonCenterYPos / 5) * 2) + buttonCenterYPos
        downButton = createButton(CGRectMake(downButtonXPos, downButtonYPos, buttonWidth, buttonHeight), type: .Down)
        addSubview(downButton)
        
        // left
        let leftButtonXPos: CGFloat = buttonCenterXPos / 10
        let leftButtonYPos: CGFloat = buttonCenterYPos
        leftButton = createButton(CGRectMake(leftButtonXPos, leftButtonYPos, buttonWidth, buttonHeight), type: .Left)
        addSubview(leftButton)
        // right
        let rightButtonXPos: CGFloat = ((buttonCenterXPos / 10) * 9) + buttonCenterXPos
        let rightButtonYPos: CGFloat = buttonCenterYPos
        rightButton = createButton(CGRectMake(rightButtonXPos, rightButtonYPos, buttonWidth, buttonHeight), type: .Right)
        addSubview(rightButton)
        
        // Round Position
        
        // 1.
        let round1Width: CGFloat = (rightButtonXPos - leftButtonXPos) + (buttonWidth / 10)
        let round1Height: CGFloat = (downButtonYPos - upButtonYPos) - (buttonHeight / 4)
        let round1XPos: CGFloat = (screenWidth / 2) - (round1Width / 2)
        let round1YPos: CGFloat = (screenHeight / 2) - (round1Height / 2)
        round1Rect = CGRectMake(round1XPos, round1YPos, round1Width, round1Height)
        // 2.
        let round2Width: CGFloat = (rightButtonXPos - leftButtonXPos) - (buttonWidth / 10)
        let round2Height: CGFloat = (downButtonYPos - upButtonYPos) + (buttonHeight / 5)
        let round2XPos: CGFloat = (screenWidth / 2) - (round2Width / 2)
        let round2YPos: CGFloat = (screenHeight / 2) - (round2Height / 2)
        round2Rect = CGRectMake(round2XPos, round2YPos, round2Width, round2Height)
    }

    override func drawRect(rect: CGRect) {
        // Draw Round
        
        // 1.
        let round1 = UIBezierPath(ovalInRect: round1Rect)
        round1.lineWidth = 3.0
        UIColor.whiteColor().setStroke()
        round1.stroke()
        
        // 2.
        let round2 = UIBezierPath(ovalInRect: round2Rect)
        round2.lineWidth = 3.0
        UIColor.whiteColor().setStroke()
        round2.stroke()
    }
    
    // MARK: support for MenuViewDelegate protocol
    
    func upButtonDidTouch() {
        delegate?.upButtonDidTouch()
    }
    
    func downButtonDidTouch() {
        delegate?.downButtonDidTouch()
    }
    
    func leftButtonDidTouch() {
        delegate?.leftButtonDidTouch()
    }
    
    func rightButtonDidTouch() {
        delegate?.rightButtonDidTouch()
    }
    
    // MARK: Button Factory
    
    func createButton(frame: CGRect, type: MenuViewButtonTypes) -> MenuViewButton {
        let button = MenuViewButton(frame: frame)
        
        switch type {
        case .Up:
            button.addTarget(self, action: #selector(upButtonDidTouch), forControlEvents: .TouchUpInside)
            break
        case .Down:
            button.addTarget(self, action: #selector(downButtonDidTouch), forControlEvents: .TouchUpInside)
            break
        case .Left:
            button.addTarget(self, action: #selector(leftButtonDidTouch), forControlEvents: .TouchUpInside)
            break
        case .Right:
            button.addTarget(self, action: #selector(rightButtonDidTouch), forControlEvents: .TouchUpInside)
        }
        
        return button
    }
}



class MenuViewButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        path.lineWidth = 3.0
        UIColor.whiteColor().setFill()
        path.fill()
    }
}