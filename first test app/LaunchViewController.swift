//
//  LaunchViewController.swift
//  first test app
//
//  Created by Omar Rahman on 29/12/2017.
//  Copyright © 2017 Omar Rahman. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController{
    @IBOutlet weak var playerOneName: UITextField!
    @IBOutlet weak var playerTwoName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC: ViewController = segue.destination as! ViewController
        nextVC.playerCross.name = playerOneName.text!
        nextVC.playerNought.name = playerTwoName.text!
    }
}
