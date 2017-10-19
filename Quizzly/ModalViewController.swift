//
//  ModalViewController.swift
//  Quizzly
//

import UIKit
import AudioToolbox

class ModalViewController: UIViewController {
    
    var duration: Double!
    var isAnswerCorrect: Bool!
    var isAnswerGiven: Bool!
    
    @IBOutlet weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        displayModal(for: duration, when: isAnswerCorrect)
    }
    
    /// Displays the "modal" for a mentioned duration
    func displayModal(for seconds: Double, when result: Bool) {
        if isAnswerCorrect {
            messageLabel.text = "Correct!"
        } else { 
            if isAnswerGiven {
                messageLabel.text = "Sorry, that's not it."
            } else {
                messageLabel.text = "You've run out of time!"
            }
        }

        let state = result ? "correct" : "incorrect"
        
        messageLabel.backgroundColor = Resources.getColor(for: state)
        AudioServicesPlaySystemSound(Resources.getSound(for: state))
        
        Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(dismissModal), userInfo: nil, repeats: false)
    }
    
    /// Dismisses the modal view controller
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
}
