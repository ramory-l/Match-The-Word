//
//  Card.swift
//  Challenge
//
//  Created by Mikhail Strizhenov on 12.05.2020.
//  Copyright © 2020 Mikhail Strizhenov. All rights reserved.
//

import UIKit

class Card: UIButton {
    
    static var image: UIImage!
    var isMatch = false
    var isChosen = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        clipsToBounds = true
        setTitleColor(.white, for: .normal)
        setBackgroundImage(Card.image, for: .normal)
        backgroundColor = .gray
        titleLabel?.font = UIFont(name: "AvenirNext-DemiBoldItalic", size: 18)
        layer.cornerRadius = 10
    }
    
    static func loadImage() {
        let renderRect = CGRect(origin: .zero, size: CGSize(width: 90, height: 150))
        let renderer = UIGraphicsImageRenderer(size: renderRect.size)
        let rendImage = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 45, y: 75)

            let rotations = 16
            let amount = Double.pi / Double(rotations)

            for _ in 0..<rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: 22.5, y: 37.5, width: 45, height: 75))
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        Card.image = rendImage
    }
}
