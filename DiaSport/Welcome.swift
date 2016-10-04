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
    
    fileprivate enum RealDeviceOrientation {
        case landscape, portrait
    }
    
    fileprivate func setBackgroundImageForOrientation() {
        var realDeviceOrientation: RealDeviceOrientation!
        
        if UIDevice.current.orientation.rawValue == 0 {
            // ak nemam device orientation pouzijem ako indikator status bar
            switch UIApplication.shared.statusBarOrientation {
            case .landscapeLeft, .landscapeRight:
                realDeviceOrientation = RealDeviceOrientation.landscape
                break
            default:
                realDeviceOrientation = RealDeviceOrientation.portrait
            }
            
        } else {
            switch UIDevice.current.orientation {
            case .landscapeLeft, .landscapeRight:
                realDeviceOrientation = RealDeviceOrientation.landscape
                break
            default:
                realDeviceOrientation = RealDeviceOrientation.portrait
            }
        }

        if realDeviceOrientation == RealDeviceOrientation.landscape {
            backgroundImage.image = UIImage(named: "welcome_back_land")
            
        } else {
            backgroundImage.image = UIImage(named: "welcome_back")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackgroundImageForOrientation()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setBackgroundImageForOrientation()
    }
    
}
