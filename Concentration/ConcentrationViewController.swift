//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Ilya Semerukhin on 08.04.2018.
//  Copyright © 2018 Ilya Semerukhin. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
   
   private lazy var game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
   private(set) var flipCount = 0 { didSet { updateFlipCountLabel() } }
   
   @IBOutlet private weak var flipCountLabel: UILabel! { didSet { updateFlipCountLabel() } }
   @IBOutlet private var cardButtons: [UIButton]!
   
   @IBAction private func touchCard(_ sender: UIButton) {
      flipCount += 1
      if let cardNumber = cardButtons.index(of: sender) {
         game.chooseCard(at: cardNumber)
         updateViewFromModel()
      } else {
         print("nil!")
      }
   }
   
   private func updateViewFromModel() {
      for index in cardButtons.indices {
         let button = cardButtons[index]
         let card = game.cards[index]
         if card.isFaceUp {
            button.setTitle(emoji(for: card), for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
         } else {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
         }
      }
   }
   
   var theme: String? {
      didSet {
         emojiChoices = theme ?? ""
         emoji = [:]
         updateViewFromModel()
      }
   }
   private var emojiChoices = "🎃👻🍭🦇🍎😈😱"
   private var emoji = [Card: String]()
   
   private func emoji(for card: Card) -> String {
      if emoji[card] == nil {
         let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
         emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
      }
      return emoji[card] ?? "?"
   }
   
   private func updateFlipCountLabel() {
      // flipCountLabel.text = "Flips: \(flipCount)"
      let attributes: [NSAttributedStringKey: Any] = [
         .strokeWidth: 5.0,
         .strokeColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
      ]
      let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
      flipCountLabel.attributedText = attributedString
   }
   
}

extension Int {
   var arc4random: Int {
      if self == 0 {
         return 0
      } else if self > 0 {
         return Int(arc4random_uniform(UInt32(self)))
      } else {
         return -Int(arc4random_uniform(UInt32(abs(self))))
      }
   }
}





