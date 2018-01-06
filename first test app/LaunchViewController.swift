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
    var singlePlayer = false
    var boolToColor = [true: UIColor.black, false: UIColor.white]
    var boolToImage = [true: UIImage(named: "ic_check_circle_3x.png"), false: UIImage(named:"ic_radio_button_unchecked_3x.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func toggleSinglePlayer(_ sender: UIButton) {
        singlePlayer = !singlePlayer
        playerTwoName.isUserInteractionEnabled = !singlePlayer
        playerTwoName.backgroundColor = boolToColor[singlePlayer]
        sender.setImage(boolToImage[singlePlayer]!, for: UIControlState.normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC: ViewController = segue.destination as! ViewController
        nextVC.playerCross.name = playerOneName.text!
        if(singlePlayer){
            nextVC.playerNought.name = "Computer"
            nextVC.playerNought.auto = true
            nextVC.singlePlayer = true
        }else{
            nextVC.playerNought.name = playerTwoName.text!
        }
    }
}
