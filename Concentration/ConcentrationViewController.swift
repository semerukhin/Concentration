//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Ilya Semerukhin on 08.04.2018.
//

import UIKit

class ConcentrationViewController: UIViewController {
   
//   override var vclLoggingName: String {
//      return "Game"
//   }
   
   private lazy var game = Concentration(numberOfPairOfCards: (visibleCardButtons.count + 1) / 2)
   private(set) var flipCount = 0 { didSet { updateFlipCountLabel() } }
   
   @IBOutlet private weak var flipCountLabel: UILabel! { didSet { updateFlipCountLabel() } }
   
   @IBOutlet private var cardButtons: [UIButton]!
   
   private var visibleCardButtons: [UIButton]! {
      return cardButtons?.filter { !$0.superview!.isHidden }
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      updateViewFromModel()
   }
   
   @IBAction private func touchCard(_ sender: UIButton) {
      flipCount += 1
      if let cardNumber = visibleCardButtons.index(of: sender) {
         game.chooseCard(at: cardNumber)
         updateViewFromModel()
      } else {
         print("nil!")
      }
   }
   
   private func updateViewFromModel() {
      if visibleCardButtons != nil {
         for index in visibleCardButtons.indices {
            let button = visibleCardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
               button.setTitle(emoji(for: card), for: UIControlState.normal)
               button.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            } else {
               button.setTitle("", for: UIControlState.normal)
               button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
            }
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
      flipCountLabel.text = traitCollection.verticalSizeClass == .compact ? "Flips\n\(flipCount)" : "Flips: \(flipCount)"
      
//      flipCountLabel.text = "Flips: \(flipCount)"
      
//      let attributes: [NSAttributedStringKey: Any] = [
//         .strokeWidth: 2.0,
//         .strokeColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//      ]
//      let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
//      flipCountLabel.attributedText = attributedString
   }
   
   override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      super.traitCollectionDidChange(previousTraitCollection)
      updateFlipCountLabel()
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





