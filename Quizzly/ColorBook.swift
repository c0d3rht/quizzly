import UIKit

struct ColorBook {
    let colors = [
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
        UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 178.0/255.0, alpha: 1.0),
        UIColor(red: 218.0/255.0, green: 13.0/255.0, blue: 110.0/255.0, alpha: 1.0),
        UIColor(red: 5.0/255.0, green: 210.0/255.0, blue: 177.0/255.0, alpha: 1.0)
    ]
    
    func getGradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        let startColor = colors[Generator.randomNumber(upperBound: colors.count)]
        var endColor: UIColor
        
        repeat {
            endColor = colors[Generator.randomNumber(upperBound: colors.count)]
        } while endColor == startColor
        
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        return gradientLayer
    }
    
}
