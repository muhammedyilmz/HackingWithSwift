//
//  ViewController.swift
//  Project2
//
//  Created by Muhammed Yılmaz on 28.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var question = 1
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var questionNumber: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "us", "uk"]
        
       
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
    }
    
   
    func askQuestion(action : UIAlertAction! = nil) {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0])?.withRenderingMode(.alwaysOriginal), for: .normal)
        button2.setImage(UIImage(named: countries[1])?.withRenderingMode(.alwaysOriginal), for: .normal)
        button3.setImage(UIImage(named: countries[2])?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        title = countries[correctAnswer].uppercased()
        
        questionNumber.text = "Question = \(question)"
        
        if question == 11 {
            questionNumber.text = "Game Over!"
            let ac = UIAlertController(title: "Game Over!", message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play Again", style: .default, handler: askQuestion))
            present(ac, animated: true)
            score = 0
            question = 1
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
            scoreLabel.text = "Score: \(score)"
            question += 1
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag].uppercased())."
            score -= 1
            scoreLabel.text = "Score: \(score)"
            question += 1
        }    

        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}
