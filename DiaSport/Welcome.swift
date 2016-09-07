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
    
    private enum RealDeviceOrientation {
        case Landscape, Portrait
    }
    
    private func setBackgroundImageForOrientation() {
        var realDeviceOrientation: RealDeviceOrientation!
        
        if UIDevice.currentDevice().orientation.rawValue == 0 {
            // ak nemam device orientation pouzijem ako indikator status bar
            switch UIApplication.sharedApplication().statusBarOrientation {
            case .LandscapeLeft, .LandscapeRight:
                realDeviceOrientation = RealDeviceOrientation.Landscape
                break
            default:
                realDeviceOrientation = RealDeviceOrientation.Portrait
            }
            
        } else {
            switch UIDevice.currentDevice().orientation {
            case .LandscapeLeft, .LandscapeRight:
                realDeviceOrientation = RealDeviceOrientation.Landscape
                break
            default:
                realDeviceOrientation = RealDeviceOrientation.Portrait
            }
        }

        if realDeviceOrientation == RealDeviceOrientation.Landscape {
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