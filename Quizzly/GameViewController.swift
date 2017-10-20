//
//  GameViewController.swift
//  Quizzly
//

import UIKit
import GameKit

class GameViewController: UIViewController {
    
    var game = Game()
    
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var optionsView: UIView!
    
    @IBOutlet var spacingAboveFourthOption: NSLayoutConstraint!
    
    var originalNumberOfSublayersInView: Int!
    var spacingBelowThirdOptionToView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalNumberOfSublayersInView = view.layer.sublayers?.count
        spacingBelowThirdOptionToView = NSLayoutConstraint(item: optionsView.subviews[2], attribute: .bottom, relatedBy: .equal, toItem: optionsView, attribute: .bottom, multiplier: 1, constant: 0)
        
        displayQuestion()
    }
    
    /// Displays a random question to the user
    func displayQuestion() {
        setGradientBackground()
        
        timerLabel.textColor = Resources.getColor(for: "timer")
        timerLabel.text = "\(Int(game.secondsPerQuestion))"
        
        game.continue()
        
        questionField.text = game.currentQuestion.title
        enableOptions(true)
        
        let areThreeOptionsExisting = game.currentOptions.count == 3
        
        view.addConstraint(spacingBelowThirdOptionToView)
        optionsView.subviews[2].translatesAutoresizingMaskIntoConstraints = false
        optionsView.subviews[3].translatesAutoresizingMaskIntoConstraints = false
        
        optionsView.subviews[3].isHidden = areThreeOptionsExisting
        spacingAboveFourthOption.isActive = !areThreeOptionsExisting
        spacingBelowThirdOptionToView.isActive = areThreeOptionsExisting
        
        for i in 0..<game.currentOptions.count {
            (optionsView.subviews[i] as! UIButton).setTitle(game.currentOptions[i], for: .normal)
        }
        
        game.startTimer(for: game.secondsPerQuestion, and: updateTimer)
    }
    
    /// Displays the score in the form of an alert
    func displayScore() {
        // Instantiate the modal view controller
        let scoreViewController = storyboard?.instantiateViewController(withIdentifier: "Score") as! ScoreViewController
        
        // Tell the modal view controller stuff
        scoreViewController.score = game.correctAnswers
        scoreViewController.numberOfQuestions = game.numberOfQuestionsAsked
        
        // Take a screenshot
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        scoreViewController.background = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show the modal view controller
        present(scoreViewController, animated: true)
    }
    
    @IBAction func changeTimerStatus() {
        game.isTimerRunning = !game.isTimerRunning
        enableOptions(game.isTimerRunning)
        
        if game.isTimerRunning {
            questionField.text = game.currentQuestion.title
            game.currentOptions = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: game.currentOptions) as! [String]
            timerButton.setImage(Resources.getImage(for: "Pause"), for: .normal)
            
            for i in 0..<game.currentOptions.count {
                (optionsView.subviews[i] as! UIButton).setTitle(game.currentOptions[i], for: .normal)
            }
            
            game.startTimer(for: game.secondsLeft, and: updateTimer)
        } else {
            game.stopTimer()
            questionField.text = "I'll just be waiting."
            timerButton.setImage(Resources.getImage(for: "Play"), for: .normal)
            
            for button in optionsView.subviews as! [UIButton] {
                button.setTitle("...", for: .normal)
            }
        }
    }
    
    /// Checks if the button tapped is the correct answer
    @IBAction func checkAnswer(_ sender: UIButton?) {
        game.stopTimer()
        enableOptions(false)
        
        let isAnswerCorrect = sender?.currentTitle == game.currentQuestion.answer
        if isAnswerCorrect { game.correctAnswers += 1 }
        
        displayModal(if: isAnswerCorrect, and: sender != nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.game.numberOfQuestionsAsked < self.game.questions.count {
                self.displayQuestion()
            } else {
                self.displayScore()
            }
        }
    }
    
    
    // HELPER METHODS ==========================================>
    
    
    /// Set a random gradient as the background
    func setGradientBackground() {
        let gradientLayer = Resources.getGradient()
        
        // Size the gradient layer to the bounds of the superview
        gradientLayer.frame = view.bounds
        
        // If the number of the sublayers in the main superview is more than its original,
        if (view.layer.sublayers?.count)! > originalNumberOfSublayersInView {
            // ...remove the previous gradient
            view.layer.sublayers?[0].removeFromSuperlayer()
        }
        
        // Set the layer as the first layer
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// Enable the options
    func enableOptions(_ isEnabled: Bool) {
        for button in optionsView.subviews as! [UIButton] {
            button.isEnabled = isEnabled
            button.isUserInteractionEnabled = isEnabled
            button.backgroundColor = Resources.getColor(for: isEnabled ? "option" : "option_disabled")
        }
    }
    
    /// Displays the modal view controller and shows the outcome of the question answered
    func displayModal(if isCorrect: Bool, and isGiven: Bool) {
        // Instantiate the modal view controller
        let modalViewController = storyboard?.instantiateViewController(withIdentifier: "Modal") as! ModalViewController
        
        // Tell the modal view controller stuff
        modalViewController.isAnswerCorrect = isCorrect
        modalViewController.isAnswerGiven = isGiven
        
        // Show the modal view controller
        present(modalViewController, animated: true)
    }
    
    /// Updates the timer and the label
    func updateTimer() {
        // Display the time left via the timer label
        if game.secondsLeft >= 0 {
            timerLabel.text = "\(Int(game.secondsLeft))"
            
            if game.secondsLeft <= 5 {
                timerLabel.textColor = Resources.getColor(for: "timer_late")
            }
        } else {
            checkAnswer(nil)
        }
    }
}
