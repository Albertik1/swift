    //
    //  ViewController.swift
    //  Guess The Number
    //
    //  Created by Amangeldiev Kutman on 15/11/21.
    //

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var numOfTriesLabel: UILabel!
    
    @IBOutlet weak var newGame: UIButton!
    
    var counter = 0
    
    private var randomNumber = 0
    

    var numOfTries = 1
    let CORRECT = "Correct"
    let Game_Over = "Game Over!!!"
    let TOO_LOW = "Greater than "
    let TOO_HIGH = "Lower than "
    let NUM_OF_TRIES_PREFIX = "# of Tries: "
    let PLAY_AGAIN_TITLE = "PLAY AGAIN"
    let SUBMIT_TITLE = "SUBMIT"
    let MESSAGE_SUFFIX = "!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRandomNumber()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        newGame.isHidden = true
        guessTextField.becomeFirstResponder()
    }
    
    @IBAction func submitAction(_ sender: Any) {
        
        if(submitButton.titleLabel?.text == PLAY_AGAIN_TITLE){
            playAgain()
        } else{
            submit()
        }
        
    }
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        playAgain()
    }
    
    func submit(){
        let guessString = guessTextField.text!
        
        if guessString.isEmpty {
            return
        }
        
        let currentNum = Int(guessString)!
        var message: String!
        
        
        if counter < 4 {
            submitButton.isUserInteractionEnabled = true
            newGame.isHidden = true
            if currentNum == randomNumber {
                message = CORRECT
                newGame.isHidden = false
//                submitButton.setTitle(PLAY_AGAIN_TITLE, for: .normal)
                numOfTriesLabel.text = ""
            }
            else{
                counter += 1
                numOfTriesLabel.text = NUM_OF_TRIES_PREFIX + String(counter)
                let prefix = currentNum < randomNumber ? TOO_LOW : TOO_HIGH
                message = prefix + guessString + MESSAGE_SUFFIX
                guessTextField.text?.removeAll()
                
            }
        } else {
            newGame.isHidden = false
            submitButton.isUserInteractionEnabled = false
            counter = 0
            message = Game_Over
            numOfTriesLabel.text = ""
            
        }
        
        infoLabel.text = message
    }
    
    func playAgain(){
        submitButton.isUserInteractionEnabled = true
        generateRandomNumber()
        submitButton.setTitle(SUBMIT_TITLE, for: .normal)
        counter = 0
        guessTextField.text?.removeAll()
        infoLabel.text?.removeAll()
        newGame.isHidden = true
        
    }
    
    func generateRandomNumber(){
        randomNumber = Int.random(in: 1 ... 10)
    }
    
}

