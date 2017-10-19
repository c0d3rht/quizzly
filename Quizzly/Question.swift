//
//  Question.swift
//  Quizzly
//

import GameKit

class Question {
    
    let title: String
    private let options: [String]
    let answer: String
    
    init(title: String, _ options: [String], _ answerIndex: Int) {
        self.title = title
        self.options = options
        self.answer = options[answerIndex - 1]
    }
    
    func getOptions() -> [String] {
        var modifiedOptions = options

        if GKRandomSource.sharedRandom().nextInt(upperBound: 2) == 0 {
            var removedOption = ""
            
            repeat {
                let randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: options.count - 1)
                removedOption = modifiedOptions.remove(at: randomIndex)
                
                if removedOption == answer {
                    modifiedOptions.append(removedOption)
                }
            } while removedOption == answer && modifiedOptions.count == options.count
        }
        
        return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: modifiedOptions) as! [String]
    }
}
