//
//  ViewController.swift
//  first test app
//
//  Created by Omar Rahman on 28/12/2017.
//  Copyright © 2017 Omar Rahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet var collectionOfButtons: Array<UIButton>?
    @IBOutlet weak var scoreOneLabel: UILabel!
    @IBOutlet weak var scoreTwoLabel: UILabel!
    @IBOutlet weak var scoreFieldOne: UITextField!
    @IBOutlet weak var scoreFieldTwo: UITextField!
    
    var cross: Bool = true
    var crossPlay: [Bool?] = [Bool?](repeating: nil, count: 9)
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    let playerCross = Player("", UIColor.white, true, UIImage(named: "ic_close_3x.png")!, 0)
    let playerNought = Player("", UIColor.gray, false, UIImage(named: "ic_radio_button_unchecked_3x.png")!, 0)
    var currentPlayer: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        turnLabel.tintColor = nil
        
        scoreOneLabel.text = "\(playerCross)'s score"
        scoreFieldOne.allowsEditingTextAttributes = false
        scoreFieldOne.text = String(playerCross.score)
        
        scoreTwoLabel.text = "\(playerNought)'s score"
        scoreFieldTwo.allowsEditingTextAttributes = false
        scoreFieldTwo.text = String(playerNought.score)
        
        currentPlayer = playerCross
        nextTurn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playTurn(_ sender: UIButton)
    {
        if(crossPlay[sender.tag] == nil)
        {
            sender.setImage(currentPlayer?.img, for: UIControlState.normal)
            sender.setTitle("", for: UIControlState.normal)
            sender.tintColor = currentPlayer?.color
            
            crossPlay[sender.tag] = currentPlayer?.tag
            winningCombinations.forEach({ (combination) in
                if crossPlay[combination[0]] != nil && crossPlay[combination[0]] == crossPlay[combination[1]] && crossPlay[combination[1]] == crossPlay[combination[2]]
                {
                    currentPlayer?.score+=1
                    scoreFieldOne.text = String(playerCross.score)
                    scoreFieldTwo.text = String(playerNought.score)
                    resetPopUp("Congratulations", "\(currentPlayer!) wins!")
                }
                else if(noMovesLeft()){
                    resetPopUp("Oops", "Looks like its a tie!")
//                    newGame()
                }
            })
            
            //            let triggerTime = (Int64(NSEC_PER_SEC) * 120)
            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            //                self.functionToCall()
            //            })
            cross = !cross
            nextTurn()
        }
    }
    
    @IBAction func resetGrid(_ sender: Any) {
        reset()
    }
    
    func reset(){
//        cross = !cross
        nextTurn()
        collectionOfButtons?.forEach({ (button) in
            button.setImage(nil, for: UIControlState.normal)
            button.tintColor = nil
        })
        crossPlay = [Bool?](repeating: nil, count: 9)
    }
    
    fileprivate func resetPopUp(_ header: String, _ body: String) {
        let alert = UIAlertController(title: header, message: body, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Restart", style: UIAlertActionStyle.default, handler:
            {(alert: UIAlertAction!) in self.reset()}
        ))
        self.present(alert, animated: true, completion: nil)
    }
    
    func noMovesLeft() -> Bool {
        var returnVal = true
        crossPlay.forEach({ (val) in
            returnVal = val==nil ? false : returnVal
        })
        return returnVal
    }
    
    func nextTurn(){
        currentPlayer = cross ? playerCross : playerNought
        turnLabel.text = "Player \(currentPlayer!)'s turn"
    }
}

class Player: CustomStringConvertible{
    var name: String
    var color: UIColor
    var tag: Bool
    var img: UIImage
    var score: Int
    
    init(_ name: String, _ color: UIColor, _ tag: Bool, _ img: UIImage, _ score: Int){
        self.name = name
        self.color = color
        self.tag = tag
        self.img = img
        self.score = score
    }
    
    public var description: String { return name }
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
