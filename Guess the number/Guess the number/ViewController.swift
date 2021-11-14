//
//  ViewController.swift
//  Guess the number
//
//  Created by Amangeldiev Kutman on 15/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var guessNumberLabel: UILabel!
    @IBOutlet weak var inputNumberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func inputNumber(_ sender: UITextField) {
    }
    
    @IBAction func confirmButton(_ sender: UIButton) {
        print("hello world")
    }
    
    var randomNumber = Int.random(in: 10 ... 1)
    var numOfTries = 5
    let CORRECT = "Congrats! You guessed the right number!"
    let TOO_LOW = "Try again. Guess a number higher than "
    let TOO_HIGH = "Try again. Guess a number lower than "
    let NUM_OF_TRIES_PREFIX = "# of Tries: "
    let PLAY_AGAIN_TITLE = "PLAY AGAIN"
    let SUBMIT_TITLE = "CONFIRM"
    
    
    
    func submit(){
        if (submitButton.titleLabel?.text == PLAY_AGAIN_TITLE){
                playAgain()
            }
            
        else {
            submit()
            }
    }
    
    
   
    

let MESSAGE_SUFFIX = "!"
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guessTextField.becomeFirstResponder()
    }
    
    func submit(){
     
        //get the guessed number string from the text input
        let guessString = guessTextField.text!
        
        //check to skip guess attempt when this string is empty
        if(guessString.isEmpty){
            return
        }
        
        //convert string into an integer
        let currentNum = Int(guessString)!
        
        //message to display result of the guess
        var message: String!
        
        //check if the guessed number is the random number
        if(currentNum == randomNumber){
            
            //set correct result message
            message = CORRECT
            
            //change the submit button accordingly to allow playing again
            submitButton.setTitle(PLAY_AGAIN_TITLE, for: .normal)
        }
        
        //else the guessed number is not correct
        else{
            
            //increment the number of tries by 1
            setNumOfTries(number: numOfTries + 1)
            
            //check if guessed number is less than random number
            //and set a prefix message as too low or high accordingly
            let prefix = currentNum < randomNumber ? TOO_LOW : TOO_HIGH
            
            //concatenate the prefix message, guessed number and message suffix
            //to display a clean final message to the user
            message = prefix + guessString + MESSAGE_SUFFIX
            
            //clear out the text input for another guess
            guessTextField.text?.removeAll()
        }
        
        //display the result of the guess on the info label
        infoLabel.text = message
        
    }
    
    func setNumOfTries(number: Int){
        
        //set number of tries to new value
        numOfTries = number
        
        //convert the integer parameter to a string
        let numberString = String(describing: number)
        
        //set the number of tries label to display the new number of tries
        numOfTriesLabel.text = NUM_OF_TRIES_PREFIX + numberString
    }
    

    func playAgain(){
        
        generateRandomNumber()
        
        //change the submit button accordingly to allow submitting guesses again
        submitButton.setTitle(SUBMIT_TITLE, for: .normal)
        
        //reset the number of tries
        setNumOfTries(number: 0)
        
        //clear out the input text
        guessTextField.text?.removeAll()
        
        //clear out the info label
        infoLabel.text?.removeAll()
        
    }
    
    /// Generate a random number
    func generateRandomNumber(){
        
        //the random number set is between and including the min and max limits
        randomNumber =
    }

}
}

