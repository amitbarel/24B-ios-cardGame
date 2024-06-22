import Foundation

class Deck {
    var cards: [Card] = []
    
    init() {
        for symbol in [Symbol.clubs, .diamonds, .hearts, .spades] {
            for val in 2...14 {
                if let rank = Rank(rawValue: val) {
                    cards.append(Card(symbol: symbol, rank: rank))
                }
            }
        }
        cards.shuffle()
    }
}
