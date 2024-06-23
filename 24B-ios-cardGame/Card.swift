import Foundation

enum Symbol: String {
    case hearts, diamonds, clubs, spades
}

enum Rank: Int {
    case two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9, ten = 10, jack = 11, queen = 12, king = 13, ace = 14
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
