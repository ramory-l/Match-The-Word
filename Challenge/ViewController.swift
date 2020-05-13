//
//  ViewController.swift
//  Challenge
//
//  Created by Mikhail Strizhenov on 11.05.2020.
//  Copyright © 2020 Mikhail Strizhenov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var level = 1
    var cards = [Card]()
    var answerToAnswer = [String]()
    var titlesForButtons = [String]()
    var stackView = GridComponent(rowCapacity: 4, rowWidth: 90, rowHeight: 150)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
        view.addSubview(stackView)
        addButtonsToStackView()
        setupStackView()
        for card in cards {
            card.setTitle("", for: .normal)
            card.setBackgroundImage(Card.image, for: .normal)
        }
    }
    
    func addButtonsToStackView() {
        Card.loadImage()
        for i in 0..<titlesForButtons.count {
            let button = Card()
            button.setTitle(self.titlesForButtons[i], for: .normal)
            button.setBackgroundImage(nil, for: .normal)
            button.addTarget(self, action: #selector(flipCard), for: .touchUpInside)
            button.tag = i
            cards.append(button)
            stackView.addCell(view: button)
        }
    }
    
    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    @objc func flipCard(sender: Card) {
        if sender.currentTitle == "" {
            sender.setTitle(titlesForButtons[sender.tag], for: .normal)
            sender.setBackgroundImage(nil, for: .normal)
            sender.isChosen = true
            cards[sender.tag].isChosen = true
            for card in cards {
                if card.isChosen && card.tag != sender.tag {
                    print(sender.currentTitle!)
                    print(answerToAnswer)
                    if let index = answerToAnswer.firstIndex(where: { (str) -> Bool in
                        str.contains(sender.currentTitle!)
                    }) {
                        let parts = answerToAnswer[index].components(separatedBy: "|")
                        if (card.currentTitle! == parts[0] && sender.currentTitle! == parts[1]) || (card.currentTitle! == parts[1] && sender.currentTitle! == parts[0]) {
                            card.isMatch = true
                            sender.isMatch = true
                            cards[card.tag].isMatch = true
                            cards[sender.tag].isMatch = true
                        } else if card.isMatch != true {
                            sender.setTitle("", for: .normal)
                            sender.setBackgroundImage(Card.image, for: .normal)
                            card.setTitle("", for: .normal)
                            card.setBackgroundImage(Card.image, for: .normal)
                            sender.isChosen = false
                            card.isChosen = false
                        }
                    }
                }
            }
        } else if sender.isMatch != true {
            sender.setTitle("", for: .normal)
            sender.setBackgroundImage(Card.image, for: .normal)
            sender.isChosen = false
        }
    }
    
    func loadLevel() {
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: levelFileURL) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                for line in lines {
                    if line != "" {
                        let parts = line.components(separatedBy: "|")
                        let first = parts[0]
                        let second = parts[1]
                        
                        titlesForButtons.append(contentsOf: [first, second])
                        answerToAnswer.append(line)
                    }
                }
                titlesForButtons.shuffle()
            }
        }
    }
    
}

