import UIKit

class ScoreController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var totalQuestionsLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    var correctAnswers = 0
    var totalQuestions = 0
    
    var backgroundImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.image = backgroundImage
        scoreLabel.text = "\(correctAnswers)"
        totalQuestionsLabel.text = "\(totalQuestions)"
    }
    
}
