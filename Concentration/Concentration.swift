//
//  Concentration.swift
//  Concentration
//
//  Created by MacBook Air on 11.04.2018.
//  Copyright © 2018 Ilya Semerukhin. All rights reserved.
//

import Foundation

class Concentration {
	
	private(set) var cards = [Card]()
	
	private var indexOfOneAndOnlyFaceUpCard: Int? {
		get {
			return cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly
			
//			let faceUpCardIndices = cards.indices.filter({ cards[$0].isFaceUp })
//			return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
			
//			var foundIndex: Int?
//			for index in cards.indices {
//				if cards[index].isFaceUp {
//					if foundIndex == nil {
//						foundIndex = index
//					} else {
//						return nil
//					}
//				}
//			}
//			return foundIndex
		}
		set {
			for index in cards.indices {
				cards[index].isFaceUp = (index == newValue)
			}
		}
	}
	
	func chooseCard(at index: Int) {
		assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index is not in the cards")
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				if cards[matchIndex] == cards[index] {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
				}
				cards[index].isFaceUp = true
			} else {
				indexOfOneAndOnlyFaceUpCard = index
			}
		}
	}
	
	init(numberOfPairOfCards: Int) {
		assert(numberOfPairOfCards > 0, "Concentration.init(\(numberOfPairOfCards)): you must have at least one pair of cards")
		for _ in 0..<numberOfPairOfCards {
			let card = Card()
			cards += [card, card]
		}
		// TODO: Shuffle the cards
	}

}

extension Collection {
	var oneAndOnly: Element? {
		return count == 1 ? first : nil
	}
}





