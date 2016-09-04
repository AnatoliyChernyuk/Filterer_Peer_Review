//
//  ImageProcessor.swift
//  Filterer
//
//  Created by Anatoliy Chernyuk on 7/30/16.
//  Copyright © 2016 UofT. All rights reserved.
//

import Foundation
import UIKit

// Process the image!

protocol ImageFilter {
    func modifyPixel(inout pixel:Pixel)
}

struct AmplifyBlue:ImageFilter {
    var blueModifier : Double
    
    init(intensity:Double) {
        blueModifier  = 1 + (intensity / 100)
    }
    
    func modifyPixel(inout pixel:Pixel) {
        blueModifier
        let currentBlue = Double(pixel.blue)
        pixel.blue = UInt8 ( min(255, currentBlue * blueModifier))
    }
}

struct AmplifyGreen:ImageFilter {
    var greenModifier : Double
    
    init(intensity:Double) {
        greenModifier  = 1 + (intensity / 100)
    }
    
    func modifyPixel(inout pixel:Pixel) {
        greenModifier
        let currentGreen = Double(pixel.green)
        pixel.green = UInt8 ( min(255, currentGreen * greenModifier))
    }
}

struct AmplifyRed:ImageFilter {
    var redModifier : Double
    
    init(intensity:Double) {
        redModifier  = 1 + (intensity / 100)
    }
    
    func modifyPixel(inout pixel:Pixel) {
        redModifier
        let currentRed = Double(pixel.red)
        pixel.red = UInt8 ( min(255, currentRed * redModifier))
    }
}

struct AmplifyYellow:ImageFilter {
    var greenModifier : Double
    var redModifier: Double
    
    init(intensity:Double) {
        greenModifier  = 1 + (intensity / 100)
        redModifier = 1 + (intensity / 100)
    }
    
    func modifyPixel(inout pixel:Pixel) {
        greenModifier
        let currentGreen = Double(pixel.green)
        pixel.green = UInt8 ( min(255, currentGreen * greenModifier))
        redModifier
        let currentRed = Double(pixel.red)
        pixel.red = UInt8 ( min(255, currentRed * redModifier))
    }
}

struct AmplifyPurple:ImageFilter {
    var blueModifier : Double
    var redModifier: Double
    
    init(intensity:Double) {
        blueModifier  = 1 + (intensity / 100)
        redModifier = 1 + (intensity / 100)
    }
    
    func modifyPixel(inout pixel:Pixel) {
        blueModifier
        let currentBlue = Double(pixel.blue)
        pixel.blue = UInt8 ( min(255, currentBlue * blueModifier))
        redModifier
        let currentRed = Double(pixel.red)
        pixel.red = UInt8 ( min(255, currentRed * redModifier))
    }
}



struct ImageProcessor {
    
    var filters : [ImageFilter]
    var defaultFilters :[String: ImageFilter] = ["Increase Red"    : AmplifyRed(intensity: 100),
                                                 "Increase Green"  : AmplifyGreen(intensity: 100),
                                                 "Increase Blue"   : AmplifyBlue(intensity: 100),
                                                 "Increase Yellow" : AmplifyYellow(intensity: 100),
                                                 "Increase Purple" : AmplifyPurple(intensity: 100)]
    
    init() {
        filters = []
    }
    
    mutating func queueFilter(filter:ImageFilter) {
        filters.append(filter)
    }
    
    func applyFilters(image: UIImage) {
        
        for filter in filters {
            self.applySingleFilter(image, filter: filter)
        }
    }
    
    func applySingleFilter(image :UIImage, filter :ImageFilter) -> UIImage {
        var filteredImage = RGBAImage(image: image)
        
        for y in 0..<filteredImage!.height {
            for x in 0..<filteredImage!.width {
                
                let index = y * (filteredImage?.width)! + x
                filter.modifyPixel(&filteredImage!.pixels[index])
            }
        }
        
        let imageResult = filteredImage!.toUIImage()!
        return imageResult
    }
    
}

var imageProcessor = ImageProcessor()



