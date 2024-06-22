import Foundation

enum Symbol: String {
    case hearts, diamonds, clubs, spades
}

enum Rank: Int {
    case two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
}

struct Card {
    let symbol: Symbol
    let rank: Rank
    
    var imageName: String {
        return "\(rank.rawValue)_of_\(symbol.rawValue)"
    }
}
