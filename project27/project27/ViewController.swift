//
//  ViewController.swift
//  project27
//
//  Created by user on 26/09/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var currentDrawType = 0
    
    func drawRectangle() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.purple.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 5 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
            
        default:
            break
        }
    }
    
}

