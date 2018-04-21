import UIKit

class ScoreController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var totalQuestionsLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    var correctAnswers = 0
    var totalQuestions = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "\(correctAnswers)"
        totalQuestionsLabel.text = "\(totalQuestions)"
    }
    
}
