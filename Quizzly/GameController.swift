import UIKit
import GameKit

class GameController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var optionStackView: UIStackView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    let game = Game(consistingOf: QuestionBook.questions)
    let colorBook = ColorBook()
    
    var isPlaying: Bool { return game.timer.isValid }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.doAction(timerDidUpdate)
        startRound()
    }
    
    @IBAction func assessAnswer(_ sender: UIButton? = nil) {
        game.pause()
        toggleState()
        
        let isCorrect: Bool
        let answerType: AnswerType
        
        if let answer = sender?.currentTitle {
            isCorrect = game.evaluate(answer)
            
            if isCorrect {
                game.correctAnswers += 1
                answerType = .correct
            } else {
                answerType = .incorrect
            }
        } else {
            answerType = .none
        }
        
        displayModal(for: answerType)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.advance()
        }
    }
    
    func startRound() {
        game.play()
        toggleState()
        
        if let currentQuestion = game.currentQuestion, let currentOptions = game.currentOptions {
            setBackground()
            
            questionLabel.text = currentQuestion.title
            timerLabel.text = "\(Int(game.secondsLeft))"
            
            for i in 0..<currentOptions.count {
                (optionStackView.subviews[i] as! UIButton).setTitle(currentOptions[i], for: .normal)
            }
            
            if let lastButton = optionStackView.subviews.last as? UIButton  {
                lastButton.isHidden = currentOptions.count == 3
            }
        }
    }
    
    func displayModal(for type: AnswerType) {
        let modalController = storyboard?.instantiateViewController(withIdentifier: "Modal") as! ModalController
        modalController.type = type
        
        present(modalController, animated: true)
    }
    
    func advance() {
        if game.isFinished {
            displayScore()
        } else {
            startRound()
        }
    }
    
    func displayScore() {
        let scoreController = storyboard?.instantiateViewController(withIdentifier: "Score") as! ScoreController
        
        scoreController.correctAnswers = game.correctAnswers
        scoreController.totalQuestions = game.questions.count
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        scoreController.backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        present(scoreController, animated: true)
    }
    
    func setBackground() {
        let gradientLayer = colorBook.getGradient()
        gradientLayer.frame = view.bounds
        
        if let sublayers = backgroundView.layer.sublayers, sublayers.count > 0 {
            sublayers[0].removeFromSuperlayer()
        }
        
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func toggleState() {
        for button in optionStackView.subviews as! [UIButton] {
            button.isEnabled = isPlaying
            button.isUserInteractionEnabled = isPlaying
            button.isExclusiveTouch = true
        }
    }
    
    func timerDidUpdate() {
        if game.secondsLeft > 0 {
            timerLabel.text = "\(Int(game.secondsLeft))"
        } else {
            assessAnswer()
        }
    }
    
}
