import Foundation
import GameKit

struct Generator {
    static func randomNumber(upperBound: Int) -> Int {
        return GKRandomSource.sharedRandom().nextInt(upperBound: upperBound)
    }
    
    static func shuffledArray(from array: [Any]) -> [Any] {
        return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: array)
    }
}

class Question: Equatable {
    let title: String
    let options: [String]
    let answer: String
    
    init(title: String, options: [String], answer: String) {
        self.title = title
        self.options = options
        self.answer = answer
    }
    
    func scrambledOptions() -> [String] {
        var options = Generator.shuffledArray(from: self.options) as! [String]
        
        if Generator.randomNumber(upperBound: 2) == 0 {
            var index: Int
            var option: String
            
            repeat {
                index = Generator.randomNumber(upperBound: options.count)
                option = options.remove(at: index)
                
                if option == answer {
                    options.append(option)
                }
            } while option == answer && options.count == self.options.count
        }
        
        return options
    }
    
    static func ==(lhs: Question, rhs: Question) -> Bool {
        return lhs.title == rhs.title
    }
    
}

enum AnswerType {
    case correct, incorrect, none
}

class Game {
    let questions: [Question]
    var questionsAsked: [Question] = []
    
    var currentQuestion: Question?
    var currentOptions: [String]?
    var correctAnswers = 0
    
    var timer = Timer()
    var secondsLeft: Double
    let secondsPerQuestion = 15.0
    
    var isFinished: Bool {
        return questionsAsked.count == questions.count
    }
    
    var action: (() -> Void)?
    
    init(consistingOf questions: [Question]) {
        self.questions = questions
        secondsLeft = secondsPerQuestion
    }
    
    func generateQuestion() -> Question {
        var index: Int
        
        repeat {
            index = Generator.randomNumber(upperBound: questions.count)
        } while questionsAsked.contains(questions[index])
        
        let question = questions[index]
        questionsAsked.append(question)
        
        return question
    }
    
    func evaluate(_ answer: String) -> Bool {
        return answer == currentQuestion?.answer
    }
    
    func startTimer(for seconds: Double? = nil) {
        secondsLeft = seconds ?? secondsPerQuestion
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in
            if self.secondsLeft > 0 {
                self.secondsLeft -= 1
                self.action?()
            } else {
                self.pause()
            }
        })
    }
    
    func play() {
        currentQuestion = generateQuestion()
        currentOptions = currentQuestion?.scrambledOptions()
        
        startTimer()
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func doAction(_ block: (() -> Void)?) {
        self.action = block
    }
    
}
