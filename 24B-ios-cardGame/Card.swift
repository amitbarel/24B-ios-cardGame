import Foundation

enum Symbol: String {
    case hearts, diamonds, clubs, spades
}

enum Rank: Int {
    case two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
}

class Card {
    
    let symbol: Symbol
    let rank: Rank
    var imageName: String
    
    init(symbol:Symbol, rank: Rank){
        self.symbol = symbol
        self.rank = rank
        self.imageName = "\(rank.rawValue)_of_\(symbol.rawValue)"
    }
    
    
    func compare (o2: Card) -> Bool{
        if self.symbol == o2.symbol && self.rank == o2.rank {
            return true
        }
        return false
    }
}
