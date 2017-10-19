//
//  ScoreViewController.swift
//  Quizzly
//


// LAUNCHSCREEN BACKGROUND ===> #DAFBEE


import UIKit

class ScoreViewController: UIViewController {
    
    var background: UIImage!
    
    var score = 0
    var numberOfQuestions = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionsAskedLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var backgroundView: UIVisualEffectView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: background)
        view.insertSubview(imageView, at: 0)
        
        let hasAchievedMajority = score < numberOfQuestions / 2
        let state = hasAchievedMajority ? "incorrect" : "correct"
        
        scoreLabel.textColor = Resources.getColor(for: state)
        messageLabel.textColor = Resources.getColor(for: state)
        
        scoreLabel.text = "\(score)"
        questionsAskedLabel.text = "out of \(numberOfQuestions)."
        
        if hasAchievedMajority {
            messageLabel.text = score == 0 ? "*facepalm*" : "sigh..."
        } else {
            messageLabel.text = score > numberOfQuestions - 3 ? "damn." : "not bad."
        }
    }

    @IBAction func playAgain(_ sender: UIButton) {
        let gameViewController = storyboard?.instantiateViewController(withIdentifier: "Game") as! GameViewController
        present(gameViewController, animated: true)
    }
}
