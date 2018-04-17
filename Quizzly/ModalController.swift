import UIKit
import AudioToolbox

class SoundEffectsPlayer {
    var sound: SystemSoundID = 0
    var soundEffectName = ""
    var soundEffectURL: URL {
        let path = Bundle.main.path(forResource: soundEffectName, ofType: "wav")!
        return URL(fileURLWithPath: path)
    }
    
    func playSound(for type: AnswerType) {
        soundEffectName = type == .correct ? "correct" : "incorrect"
        
        let soundURL = soundEffectURL as CFURL
        AudioServicesCreateSystemSoundID(soundURL, &sound)
        AudioServicesPlaySystemSound(sound)
    }
    
}

class ModalController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var type: AnswerType?
    var message = "You will never see this."
    var backgroundColor = UIColor(red: 1.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0)
    let soundEffectsPlayer = SoundEffectsPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let type = type {
            switch type {
            case .correct:
                message = "Correct!"
                backgroundColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
            case .incorrect:
                message = "Sorry, that's not it."
            case .none:
                message = "You've run out of time!"
            }
            
            messageLabel.text = message
            messageLabel.backgroundColor = backgroundColor
            soundEffectsPlayer.playSound(for: type)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {_ in
            self.dismiss(animated: true)
        }
    }
    
}
