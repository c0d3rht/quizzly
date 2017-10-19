//
//  ColorProvider.swift
//  Quizzly
//

import UIKit
import GameKit

struct Resources {
    
    // The list of gradients generated already
    static var gradientsUsed = [CAGradientLayer]()
    
    // The list of colors set to the backgrounds of the options and the continue button
    static let colors = [
        "option": UIColor.black.withAlphaComponent(0.2),
        "option_disabled": UIColor.black.withAlphaComponent(0.3),
        "correct": UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1),
        "incorrect": UIColor(red: 1, green: 59/255, blue: 48/255, alpha: 1),
        "timer": UIColor.white.withAlphaComponent(0.8),
        "timer_late": UIColor(red: 1, green: 59/255, blue: 48/255, alpha: 1).withAlphaComponent(0.75)
    ]
    
    // The list of colors randomly chosen from, to create a gradient to be set as the background of the view
    static let gradientColors = [
        UIColor(red: 5/255, green: 223/255, blue: 235/255, alpha: 1),
        UIColor(red: 10/255, green: 140/255, blue: 189/255, alpha: 1),
        UIColor(red: 36/255, green: 208/255, blue: 244/255, alpha: 1),
        UIColor(red: 38/255, green: 99/255, blue: 226/255, alpha: 1),
        UIColor(red: 75/255, green: 203/255, blue: 170/255, alpha: 1),
        UIColor(red: 114/255, green: 55/255, blue: 184/255, alpha: 1),
        UIColor(red: 210/255, green: 111/255, blue: 253/255, alpha: 1),
        UIColor(red: 246/255, green: 130/255, blue: 19/255, alpha: 1),
        UIColor(red: 247/255, green: 106/255, blue: 35/255, alpha: 1),
        UIColor(red: 247/255, green: 185/255, blue: 12/255, alpha: 1),
        UIColor(red: 254/255, green: 116/255, blue: 178/255, alpha: 1)
    ]
    
    static let images = [
        "play": UIImage(named: "PlayIcon")!,
        "pause":  UIImage(named: "PauseIcon")!
    ]
    
    /// Returns the color for the needed use
    static func getColor(for usage: String) -> UIColor {
        return colors[usage]!
    }
    
    /// Returns a random gradient
    static func getRandomGradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        repeat {
            let topIndex = GKRandomSource.sharedRandom().nextInt(upperBound: gradientColors.count)
            var bottomIndex: Int
            
            repeat {
                bottomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: gradientColors.count)
            } while topIndex == bottomIndex
            
            gradientLayer.colors = [gradientColors[topIndex].cgColor, gradientColors[bottomIndex].cgColor]
            gradientLayer.locations = [0.0, 1.0]
        } while gradientsUsed.contains(gradientLayer)
        
        gradientsUsed.append(gradientLayer)
        return gradientLayer
    }
    
    /// Returns an image
    static func getImage(for icon: String) -> UIImage {
        return images[icon]!.withRenderingMode(.alwaysTemplate)
    }
    
    static func getSound(for result: String) -> SystemSoundID {
        var sound: SystemSoundID = 0
        let pathToSoundFile = Bundle.main.path(forResource: result, ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &sound)
        return sound
    }
}
