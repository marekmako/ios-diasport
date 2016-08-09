//
//  Social.swift
//  DiaSport
//
//  Created by Marek Mako on 08/08/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit


class SocialViewController: UIViewController, SocialViewDelegate {
    
    // MARK: IBAction
    
    @IBAction func onCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: IBOutlet
    
    @IBOutlet weak var socialView: SocialView! {
        didSet {
            socialView.delegate = self
        }
    }
    
    // MARK: SocialViewDelegate
    
    func onTwitterShare() {
        print("onTwitterShare")
    }
}



@objc protocol SocialViewDelegate {
    optional func onTwitterShare()
    optional func onFacebookShare()
    optional func onGoogleShare()
    optional func onPinterestShare()
}



class SocialView: UIView {
    
    var delegate: SocialViewDelegate?
    
    let buttonWidth: CGFloat = 80
    let buttonHeight: CGFloat = 80
    
    let twitterButton = UIButton()
    let facebookButton = UIButton()
    let googleButton = UIButton()
    let pinterestButton = UIButton()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        twitterButton.setBackgroundImage(UIImage(named: "twitter"), forState: .Normal)
        twitterButton.addTarget(self, action: #selector(onTwitterShare), forControlEvents: .TouchUpInside)
        addSubview(twitterButton)
        
        facebookButton.setBackgroundImage(UIImage(named: "facebook"), forState: .Normal)
        facebookButton.addTarget(self, action: #selector(onFacebookShare), forControlEvents: .TouchUpInside)
        addSubview(facebookButton)
        
        googleButton.setBackgroundImage(UIImage(named: "google"), forState: .Normal)
        googleButton.addTarget(self, action: #selector(onGoogleShare), forControlEvents: .TouchUpInside)
        addSubview(googleButton)
        
        pinterestButton.setBackgroundImage(UIImage(named: "pinterest"), forState: .Normal)
        pinterestButton.addTarget(self, action: #selector(onPinterestShare), forControlEvents: .TouchUpInside)
        addSubview(pinterestButton)
    }
    
    override func layoutSubviews() {
        twitterButton.frame = CGRectMake(bounds.width / 14, bounds.height / 5, buttonWidth, buttonHeight)
        facebookButton.frame = CGRectMake(bounds.width / 4, bounds.height / 2.5, buttonWidth, buttonHeight)
        googleButton.frame = CGRectMake(bounds.width / 2, bounds.height / 1.8, buttonWidth, buttonHeight)
        pinterestButton.frame = CGRectMake(bounds.width / 1.5, bounds.height / 3.5, buttonWidth, buttonHeight)
    }
    
    // MARK: Support SocialViewDelegate
    
    func onTwitterShare() {
        delegate?.onTwitterShare?()
    }
    
    func onFacebookShare() {
        delegate?.onFacebookShare?()
    }
    
    func onGoogleShare() {
        delegate?.onGoogleShare?()
    }
    
    func onPinterestShare() {
        delegate?.onPinterestShare?()
    }
}
