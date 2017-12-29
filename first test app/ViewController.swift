//
//  ViewController.swift
//  first test app
//
//  Created by Omar Rahman on 28/12/2017.
//  Copyright © 2017 Omar Rahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionOfButtons: Array<UIButton>?
    
    var cross: Bool = true
    let buttonTextPlaceholder = "Play me!"
    var played: [Bool] = [Bool](repeating: false, count: 9)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playTurn(_ sender: UIButton)
    {
        if(!played[sender.tag])
        {
            let img = cross ? UIImage(named: "ic_close_3x.png") : UIImage(named: "ic_radio_button_unchecked_3x.png")
            sender.setImage(img, for: UIControlState.normal)
            sender.setTitle("", for: UIControlState.normal)
            let backgorundColor = cross ? UIColor.red : UIColor.blue
            sender.tintColor = backgorundColor
            cross = !cross
            played[sender.tag] = true
        }
    }
    
    @IBAction func resetGrid(_ sender: Any) {
        collectionOfButtons?.forEach({ (button) in
            button.setTitle(buttonTextPlaceholder, for: UIControlState.normal)
            button.setImage(nil, for: UIControlState.normal)
            button.tintColor = nil
        })
        played = [Bool](repeating: false, count: 9)
        cross = true
    }
}

