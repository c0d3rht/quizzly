//
//  Question.swift
//  Quizzly
//

import GameKit

class Question {
    let title: String
    let options: [String]
    let answer: String
    
    init(title: String, _ options: [String], _ answerIndex: Int) {
        self.title = title
        self.options = options
        self.answer = options[answerIndex - 1]
    }
    
    func getOptions() -> [String] {
        var scrambledOptions = options

        if GKRandomSource.sharedRandom().nextInt(upperBound: 2) == 0 {
            var removedOption: String
            
            repeat {
                let randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: options.count - 1)
                removedOption = scrambledOptions.remove(at: randomIndex)
                
                if removedOption == answer {
                    scrambledOptions.append(removedOption)
                }
            } while removedOption == answer && scrambledOptions.count == options.count
        }
        
        return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: scrambledOptions) as! [String]
    }
}
