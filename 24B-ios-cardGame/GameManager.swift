import Foundation

class GameManager {
    
    var player1: Player
    var player2: Player
    
    var player1Score: Int = 0
    var player2Score: Int = 0
    
    
    init(){
        let gameDeck = Deck().cards
        let halfSize = gameDeck.count / 2
        self.player1 = Player()
        self.player1.cards = Array(gameDeck[0..<halfSize])
        self.player2 = Player()
        self.player2.cards = Array(gameDeck[halfSize..<gameDeck.count])
    }
    
    func flipCards() -> (player1Card: Card?, player2Card: Card?) {
        guard !self.player1.cards.isEmpty, !self.player2.cards.isEmpty else {
            return (nil, nil)
        }
        
        let player1Card = self.player1.cards.removeLast()
        let player2Card = self.player2.cards.removeLast()
        
        if player1Card.rank.rawValue > player2Card.rank.rawValue {
            player1Score += 1
            self.player1.cards.append(player1Card)
            self.player1.cards.append(player2Card)
        } else if player1Card.rank.rawValue < player2Card.rank.rawValue {
            player2Score += 1
            self.player2.cards.append(player1Card)
            self.player2.cards.append(player2Card)
        }
        return (player1Card,player2Card)
    }
    
    func resetGame() {
        let gameDeck = Deck().cards
        let halfSize = gameDeck.count / 2
        self.player1.cards = Array(gameDeck[0..<halfSize])
        self.player2.cards = Array(gameDeck[halfSize..<gameDeck.count])
        self.player1Score = 0
        self.player2Score = 0
    }
}
