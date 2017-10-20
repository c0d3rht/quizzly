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
        "correct": UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0),
        "incorrect": UIColor(red: 1.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0),
        "timer": UIColor.white.withAlphaComponent(0.8),
        "timer_late": UIColor(red: 1, green: 59.0/255.0, blue: 48.0/255.0, alpha: 0.75)
    ]
    
    // The list of colors randomly chosen from, to create a gradient to be set as the background of the view
    static let gradientColors = [
        UIColor(red: 5.0/255.0, green: 223.0/255.0, blue: 235.0/255.0, alpha: 1.0),
        UIColor(red: 10.0/255.0, green: 140.0/255.0, blue: 189.0/255.0, alpha: 1.0),
        UIColor(red: 36.0/255.0, green: 208.0/255.0, blue: 244.0/255.0, alpha: 1.0),
        UIColor(red: 38.0/255.0, green: 99.0/255.0, blue: 226.0/255.0, alpha: 1.0),
        UIColor(red: 75.0/255.0, green: 203.0/255.0, blue: 170.0/255.0, alpha: 1.0),
        UIColor(red: 114.0/255.0, green: 55.0/255.0, blue: 184.0/255.0, alpha: 1.0),
        UIColor(red: 210.0/255.0, green: 111.0/255.0, blue: 253.0/255.0, alpha: 1.0),
        UIColor(red: 246.0/255.0, green: 130.0/255.0, blue: 19.0/255.0, alpha: 1.0),
        UIColor(red: 247.0/255.0, green: 106.0/255.0, blue: 35.0/255.0, alpha: 1.0),
        UIColor(red: 247.0/255.0, green: 185.0/255.0, blue: 12.0/255.0, alpha: 1.0),
        UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 178.0/255.0, alpha: 1.0)
    ]
    
    /// Returns the color for the needed use
    static func getColor(for usage: String) -> UIColor {
        return colors[usage]!
    }
    
    /// Returns a random gradient
    static func getGradient() -> CAGradientLayer {
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
    static func getImage(for iconName: String) -> UIImage {
        return UIImage(named: "\(iconName)")!.withRenderingMode(.alwaysTemplate)
    }
    
    /// Returns a sound
    static func getSound(for result: String) -> SystemSoundID {
        var sound: SystemSoundID = 0
        let pathToSoundFile = Bundle.main.path(forResource: result, ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &sound)
        return sound
    }
}
