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
    var crossPlay: [Bool?] = [Bool?](repeating: nil, count: 9)
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playTurn(_ sender: UIButton)
    {
        if(crossPlay[sender.tag] == nil)
        {
            let img = cross ? UIImage(named: "ic_close_3x.png") : UIImage(named: "ic_radio_button_unchecked_3x.png")
            sender.setImage(img, for: UIControlState.normal)
            sender.setTitle("", for: UIControlState.normal)
            let backgorundColor = cross ? UIColor.white : UIColor.gray
            sender.tintColor = backgorundColor
            
            crossPlay[sender.tag] = cross ? true : false
            winningCombinations.forEach({ (combination) in
                if crossPlay[combination[0]] != nil && crossPlay[combination[0]] == crossPlay[combination[1]] && crossPlay[combination[1]] == crossPlay[combination[2]]
                {
                    let winner = cross ? "Crosses" : "Noughts"
                    let alert = UIAlertController(title: "Congratulations", message: "\(winner) wins!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Restart", style: UIAlertActionStyle.default, handler:
                        {(alert: UIAlertAction!) in self.reset()}
                    ))
                    self.present(alert, animated: true, completion: nil)
                }
            })
            
            cross = !cross
            
        }
    }
    
    @IBAction func resetGrid(_ sender: Any) {
        reset()
    }
    
    func reset(){
        collectionOfButtons?.forEach({ (button) in
            button.setTitle(buttonTextPlaceholder, for: UIControlState.normal)
            button.setImage(nil, for: UIControlState.normal)
            button.tintColor = nil
        })
        crossPlay = [Bool?](repeating: nil, count: 9)
        cross = true
    }
    
}

extension UIView {
    func addBackground() {
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "background.png")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        self.addSubview(imageViewBackground)
        self.sendSubview(toBack: imageViewBackground)
    }
    
}
