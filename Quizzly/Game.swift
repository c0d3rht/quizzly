//
//  Game.swift
//  Quizzly
//

import GameKit

class Game {
    var correctAnswers = 0
    
    var currentQuestion: Question!
    var currentOptions: [String]!
    
    static let secondsPerQuestion = 15.0
    var secondsLeft = 0.0
    
    var timer = Timer()
    var isTimerRunning = true
    
    var indicesOfQuestionsAsked: [Int] = []
    
    let questions = [
        Question(title: "This was the only US President to serve more than two consecutive terms.",
                 ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], 2),
        Question(title: "Which of the following countries has the most residents?",
                 ["Nigeria", "Russia", "Iran", "Vietnam"], 1),
        Question(title: "In what year was the United Nations founded?",
                 ["1918", "1919", "1945", "1954"], 3),
        Question(title: "The Titanic departed from the United Kingdom, where was it supposed to arrive?",
                 ["Paris", "Washington D.C.", "New York City", "Boston"], 3),
        Question(title: "Which nation produces the most oil?",
                 ["Iran", "Iraq", "Brazil", "Canada"], 4),
        Question(title: "Which country has most recently won consecutive World Cups in Soccer?",
                 ["Italy", "Brazil", "Argentina", "Spain"], 2),
        Question(title: "Which of the following rivers is longest?",
                 ["Yangtze", "Mississippi", "Congo", "Mekong"], 2),
        Question(title: "Which city is the oldest?",
                 ["Mexico City", "Cape Town", "San Juan", "Sydney"], 1),
        Question(title: "Which country was the first to allow women to vote in national elections?",
                 ["Poland", "United States", "Sweden", "Senegal"], 1),
        Question(title: "Which of these countries won the most medals in the 2012 Summer Games?",
                 ["France", "Germany", "Japan", "Great Britian"], 4)
    ]
    
    init() {
        secondsLeft = Game.secondsPerQuestion
    }
    
    /// Returns a random question that hasn't been asked yet
    func `continue`() {
        var randomIndex: Int
        
        repeat {
            randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        } while indicesOfQuestionsAsked.contains(randomIndex)
        
        indicesOfQuestionsAsked.append(randomIndex)
        currentQuestion = questions[randomIndex]
        currentOptions = currentQuestion.getOptions() 
    }
    
    /// Starts the timer
    func startTimer(for seconds: Double, and block: @escaping () -> ()) {
        secondsLeft = seconds
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in
            self.secondsLeft -= 1
            block()
        })
    }
    
    // Stops the timer
    func stopTimer() {
        timer.invalidate()
    }
}
