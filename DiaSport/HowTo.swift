//
//  HowTo.swift
//  Diactive
//
//  Created by Marek Mako on 06/09/16.
//  Copyright © 2016 Marek Mako. All rights reserved.
//

import UIKit


class HowToViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func onCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        textView.setContentOffset(CGPointZero, animated: false)
    }
}
