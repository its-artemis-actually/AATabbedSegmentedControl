//
//  ViewController.swift
//  AATabbedSegmentedControl
//
//  Created by Samantha Todd on 11/26/17.
//  Copyright © 2017 self. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customSegmentedControl: AATabbedSegmentedControl!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customSegmentedControl.items = ["ITEM 1", "ITEM 2", "ITEM 3"]
        customSegmentedControl.font = UIFont.boldSystemFont(ofSize: 15)
        customSegmentedControl.onItemSelected = { (selectedIndex) in
            self.label.text = "Item \(selectedIndex + 1) selected."
        }
    }

}

