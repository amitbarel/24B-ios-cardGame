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
    
    func flipCards() -> (player1Card: Card, player2Card: Card) {
        
        let player1Card = self.player1.cards.removeLast()
        let player2Card = self.player2.cards.removeLast()
        
        return (player1Card,player2Card)
    }
    
    func compareCards(card1:Card, card2: Card) -> Card {
        if card1.rank.rawValue >= card2.rank.rawValue {
            return card1
        }
        return card2
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
