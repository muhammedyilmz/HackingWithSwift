//
//  ViewController.swift
//  Project5
//
//  Created by Muhammed Yılmaz on 6.11.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWards = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(newGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWards = startWords.components(separatedBy: "\n")
            }
            if allWards.isEmpty {
                allWards = ["silkworn"]
            }
        }
        startGame()
    }
    
    func startGame() {
        title = allWards.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return usedWords.count
       }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func newGame() {
        startGame()
    }
    
    func submit(_ answer: String) {
        
        let lowerAnswer = answer.lowercased()
        
        var errorTitle: String
        var errorMessage: String
        
        if sameWord(word: lowerAnswer) {
        
        if threeLetters(word: lowerAnswer) {
            
            if isPossible(word: lowerAnswer) {
                
                if isOriginal(word: lowerAnswer) {
                    
                    if isReal(word: lowerAnswer) {
                        
                        usedWords.insert(answer, at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        return
                    } else {
                        errorTitle = "Word not recognized"
                        errorMessage = "You can't just make them up, you know!"
                    }
                } else {
                    errorTitle = "Word already used"
                    errorMessage = "Be more original!"
                }
            } else {
                guard let title = title else { return }
                errorTitle = "Word not possible"
                errorMessage = "You can't spell that word from \(title.lowercased())."
            }
            
        } else {
            errorTitle = "Word too short"
            errorMessage = "Words must be at least four letters long."
        }
            
        } else {
            print("error")
            errorTitle = "You can't write the same word"
            errorMessage = "Please enter a different word."
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible (word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func threeLetters(word: String) -> Bool {
        if word.count <= 3 { return false } else { return true }
    }
    
    func sameWord(word: String) -> Bool {
        if word == title { return false } else { return true }
    }
}


