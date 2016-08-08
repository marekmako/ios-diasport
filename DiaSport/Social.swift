//
//  Social.swift
//  DiaSport
//
//  Created by Marek Mako on 08/08/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit


class SocialViewController: UIViewController {
    
    // MARK: IBAction
    
    @IBAction func onCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: IBOutlet
}


class SocialView: UIView {
    
    let buttonWidth: CGFloat = 80
    let buttonHeight: CGFloat = 80
    
    let twitterButton = UIButton()
    let facebookButton = UIButton()
    let googleButton = UIButton()
    let pinterestButton = UIButton()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        twitterButton.setBackgroundImage(UIImage(named: "twitter"), forState: .Normal)
        addSubview(twitterButton)
        
        facebookButton.setBackgroundImage(UIImage(named: "facebook"), forState: .Normal)
        addSubview(facebookButton)
        
        googleButton.setBackgroundImage(UIImage(named: "google"), forState: .Normal)
        addSubview(googleButton)
        
        pinterestButton.setBackgroundImage(UIImage(named: "pinterest"), forState: .Normal)
        addSubview(pinterestButton)
    }
    
    override func layoutSubviews() {
        twitterButton.frame = CGRectMake(bounds.width / 14, bounds.height / 5, buttonWidth, buttonHeight)
        facebookButton.frame = CGRectMake(bounds.width / 4, bounds.height / 2.5, buttonWidth, buttonHeight)
        googleButton.frame = CGRectMake(bounds.width / 2, bounds.height / 1.8, buttonWidth, buttonHeight)
        pinterestButton.frame = CGRectMake(bounds.width / 1.5, bounds.height / 3.5, buttonWidth, buttonHeight)
    }
}
