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
//        guard let ctrl = storyboard?.instantiateViewControllerWithIdentifier(SOCIAL_STORYBOARD_ID) else {
//            return
//        }
//        presentViewControllerModaly(ctrl)
        
        let activityVC = UIActivityViewController(activityItems: [SHARE_MESSAGE], applicationActivities: nil)
        
        presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func leftButtonDidTouch() { // go to knowhow
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
    
    var upButton = MenuView.CreateButton()
    var downButton = MenuView.CreateButton()
    var leftButton = MenuView.CreateButton()
    var rightButton = MenuView.CreateButton()
    
    var round1Rect: CGRect!
    var round2Rect: CGRect!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        upButton.setImage(UIImage(named: "intensity"), forState: .Normal)
        addTargetToButton(.Up)
        addSubview(upButton)
        
        downButton.setImage(UIImage(named: "social"), forState: .Normal)
        addTargetToButton(.Down)
        addSubview(downButton)
        
//        leftButton.setImage(UIImage(named: "knowhow"), forState: .Normal)
        addTargetToButton(.Left)
        addSubview(leftButton)
        
        rightButton.setImage(UIImage(named: "setting"), forState: .Normal)
        addTargetToButton(.Right)
        addSubview(rightButton)
    }
    
    override func layoutSubviews() {
        // SETTINGS
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        // Button Setting
        let buttonWidth: CGFloat = 75
        let buttonHeight: CGFloat = 60
        let buttonCenterXPos: CGFloat = ((screenWidth / 2) - (buttonWidth / 2))
        let buttonCenterYPos: CGFloat = ((screenHeight / 2) - (buttonHeight / 2))
        
        
        // Buttons
        
        // up
        let upButtonXPos: CGFloat = buttonCenterXPos
        let upButtonYPos: CGFloat = (buttonCenterYPos / 2)
        upButton.frame = CGRectMake(upButtonXPos, upButtonYPos, buttonWidth, buttonHeight)
        upButton.layer.cornerRadius = upButton.frame.width / 2.35
        
        // down
        let downButtonXPos: CGFloat = buttonCenterXPos
        let downButtonYPos: CGFloat = (buttonCenterYPos / 2) + buttonCenterYPos
        downButton.frame = CGRectMake(downButtonXPos, downButtonYPos, buttonWidth, buttonHeight)
        downButton.layer.cornerRadius = downButton.frame.width / 2.35
        

        // left
        let leftButtonXPos: CGFloat = buttonCenterXPos / 15
        let leftButtonYPos: CGFloat = buttonCenterYPos
        leftButton.frame = CGRectMake(leftButtonXPos, leftButtonYPos, buttonWidth, buttonHeight)
        leftButton.layer.cornerRadius = leftButton.frame.width / 2.35
        
        
        // right
        let rightButtonXPos: CGFloat = ((buttonCenterXPos / 15) * 14) + buttonCenterXPos
        let rightButtonYPos: CGFloat = buttonCenterYPos
        rightButton.frame = CGRectMake(rightButtonXPos, rightButtonYPos, buttonWidth, buttonHeight)
        rightButton.layer.cornerRadius = rightButton.frame.width / 2.35
        
        
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
        round1.lineWidth = 2.0
        UIColor.whiteColor().setStroke()
        round1.stroke()
        
        // 2.
        let round2 = UIBezierPath(ovalInRect: round2Rect)
        round2.lineWidth = 2.0
        UIColor.whiteColor().setStroke()
        round2.stroke()
    }
    
    // MARK: support for MenuViewDelegate protocol
    
    func addTargetToButton(buttonType: MenuViewButtonTypes) {
        switch buttonType {
        case .Up:
            upButton.addTarget(self, action: #selector(MenuView.upButtonDidTouch), forControlEvents: .TouchUpInside)
            break
        case .Down:
            downButton.addTarget(self, action: #selector(MenuView.downButtonDidTouch), forControlEvents: .TouchUpInside)
            break
        case .Left:
            leftButton.addTarget(self, action: #selector(MenuView.leftButtonDidTouch), forControlEvents: .TouchUpInside)
            break
        case .Right:
            rightButton.addTarget(self, action: #selector(MenuView.rightButtonDidTouch), forControlEvents: .TouchUpInside)
        }
    }
    
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
    
    class func CreateButton() -> UIButton {
        let button = UIButton()
        
        button.layer.backgroundColor = UIColor(red: 92/255, green: 182/255, blue: 214/255, alpha: 1).CGColor
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.whiteColor().CGColor
        
        return button
    }
}