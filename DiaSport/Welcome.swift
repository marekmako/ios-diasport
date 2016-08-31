//
//  Welcome.swift
//  Diactive
//
//  Created by Marek Mako on 31/08/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit


class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    private func setBackgroundImageForOrientation() {
        if UIDevice.currentDevice().orientation.isLandscape {
            backgroundImage.image = UIImage(named: "welcome_back_land")
            
        } else {
            backgroundImage.image = UIImage(named: "welcome_back")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        setBackgroundImageForOrientation()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        setBackgroundImageForOrientation()
    }
    
}