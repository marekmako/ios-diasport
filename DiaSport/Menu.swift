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
        guard let ctrl = storyboard?.instantiateViewController(withIdentifier: CALC_STORYBOARD_ID) else {
            return
        }
        presentViewControllerModaly(ctrl)
    }
    
    func downButtonDidTouch() {
        let activityVC = UIActivityViewController(activityItems: [SHARE_MESSAGE], applicationActivities: nil)
        
        // TODO: fix pre ipad
        if activityVC.responds(to: #selector(getter: popoverPresentationController)) {
            activityVC.popoverPresentationController?.sourceView = view
        }
        
        present(activityVC, animated: true, completion: nil)
    }
    
    func leftButtonDidTouch() { // go to knowhow
        guard let ctrl = storyboard?.instantiateViewController(withIdentifier: KNOWHOW_STORYBOARD_ID) else {
            return
        }
        presentViewControllerModaly(ctrl)
    }
    
    func rightButtonDidTouch() { // go to settings
        guard let ctrl = storyboard?.instantiateViewController(withIdentifier: SETTINGS_STORYBOARD_ID) else {
            return
        }
        presentViewControllerModaly(ctrl)
    }
    
    fileprivate func presentViewControllerModaly(_ viewControllerToPresent: UIViewController) {
        viewControllerToPresent.modalPresentationStyle = .overCurrentContext
        present(viewControllerToPresent, animated: true, completion: nil)
    }
}


protocol MenuViewDelegate {
    func upButtonDidTouch()
    func downButtonDidTouch()
    func leftButtonDidTouch()
    func rightButtonDidTouch()
}


enum MenuViewButtonTypes {
    case up, down, left, right
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
        
        upButton.setBackgroundImage(UIImage(named: "menu_runner"), for: UIControlState())
        addTargetToButton(.up)
        addSubview(upButton)
        
        downButton.setBackgroundImage(UIImage(named: "menu_social"), for: UIControlState())
        addTargetToButton(.down)
        addSubview(downButton)
        
        leftButton.setBackgroundImage(UIImage(named: "menu_help"), for: UIControlState())
        addTargetToButton(.left)
        addSubview(leftButton)
        
        rightButton.setBackgroundImage(UIImage(named: "menu_setting"), for: UIControlState())
        addTargetToButton(.right)
        addSubview(rightButton)
    }
    
    override func layoutSubviews() {
        // SETTINGS
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // Button Setting
        let buttonWidth: CGFloat = 80
        let buttonHeight: CGFloat = 65
        let buttonCenterXPos: CGFloat = ((screenWidth / 2) - (buttonWidth / 2))
        let buttonCenterYPos: CGFloat = ((screenHeight / 2) - (buttonHeight / 2))
        
        
        // Buttons
        
        // up
        let upButtonXPos: CGFloat = buttonCenterXPos
        let upButtonYPos: CGFloat = (buttonCenterYPos / 2)
        upButton.frame = CGRect(x: upButtonXPos, y: upButtonYPos, width: buttonWidth, height: buttonHeight)
        upButton.layer.cornerRadius = upButton.frame.width / 2.35
        
        // down
        let downButtonXPos: CGFloat = buttonCenterXPos
        let downButtonYPos: CGFloat = (buttonCenterYPos / 2) + buttonCenterYPos
        downButton.frame = CGRect(x: downButtonXPos, y: downButtonYPos, width: buttonWidth, height: buttonHeight)
        downButton.layer.cornerRadius = downButton.frame.width / 2.35
        

        // left
        let leftButtonXPos: CGFloat = buttonCenterXPos / 15
        let leftButtonYPos: CGFloat = buttonCenterYPos
        leftButton.frame = CGRect(x: leftButtonXPos, y: leftButtonYPos, width: buttonWidth, height: buttonHeight)
        leftButton.layer.cornerRadius = leftButton.frame.width / 2.35
        
        
        // right
        let rightButtonXPos: CGFloat = ((buttonCenterXPos / 15) * 14) + buttonCenterXPos
        let rightButtonYPos: CGFloat = buttonCenterYPos
        rightButton.frame = CGRect(x: rightButtonXPos, y: rightButtonYPos, width: buttonWidth, height: buttonHeight)
        rightButton.layer.cornerRadius = rightButton.frame.width / 2.35
        
        
        // Round Position
        
        // 1.
        let round1Width: CGFloat = (rightButtonXPos - leftButtonXPos) + (buttonWidth / 3)
        let round1Height: CGFloat = (downButtonYPos - upButtonYPos) - (buttonHeight / 4)
        let round1XPos: CGFloat = (screenWidth / 2) - (round1Width / 2)
        let round1YPos: CGFloat = (screenHeight / 2) - (round1Height / 2)
        round1Rect = CGRect(x: round1XPos, y: round1YPos, width: round1Width, height: round1Height)
        // 2.
        let round2Width: CGFloat = (rightButtonXPos - leftButtonXPos)
        let round2Height: CGFloat = (downButtonYPos - upButtonYPos) + (buttonHeight / 3)
        let round2XPos: CGFloat = (screenWidth / 2) - (round2Width / 2)
        let round2YPos: CGFloat = (screenHeight / 2) - (round2Height / 2)
        round2Rect = CGRect(x: round2XPos, y: round2YPos, width: round2Width, height: round2Height)
    }

    override func draw(_ rect: CGRect) {
        // Draw Round
        
        // 1.
        let round1 = UIBezierPath(ovalIn: round1Rect)
        round1.lineWidth = 2
        UIColor.white.setStroke()
        round1.stroke()
        
        // 2.
        let round2 = UIBezierPath(ovalIn: round2Rect)
        round2.lineWidth = 2
        UIColor.white.setStroke()
        round2.stroke()
    }
    
    // MARK: support for MenuViewDelegate protocol
    
    func addTargetToButton(_ buttonType: MenuViewButtonTypes) {
        switch buttonType {
        case .up:
            upButton.addTarget(self, action: #selector(MenuView.upButtonDidTouch), for: .touchUpInside)
            break
        case .down:
            downButton.addTarget(self, action: #selector(MenuView.downButtonDidTouch), for: .touchUpInside)
            break
        case .left:
            leftButton.addTarget(self, action: #selector(MenuView.leftButtonDidTouch), for: .touchUpInside)
            break
        case .right:
            rightButton.addTarget(self, action: #selector(MenuView.rightButtonDidTouch), for: .touchUpInside)
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
        
        button.layer.backgroundColor = UIColor(red: 92/255, green: 182/255, blue: 214/255, alpha: 1).cgColor
//        button.layer.borderWidth = 2.5
//        button.layer.borderColor = UIColor.whiteColor().CGColor
        
        return button
    }
}
