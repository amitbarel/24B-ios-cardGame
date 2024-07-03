import Foundation

class GameManager {
    
    var playerWest: Player
    var playerEast: Player
    
    var playerWestScore: Int = 0
    var playerEastScore: Int = 0
    
    
    init(){
        let gameDeck = Deck().cards
        let halfSize = gameDeck.count / 2
        self.playerWest = Player()
        self.playerWest.cards = Array(gameDeck[0..<halfSize])
        self.playerEast = Player()
        self.playerEast.cards = Array(gameDeck[halfSize..<gameDeck.count])
    }
    
    func flipCards() -> (player1Card: Card, player2Card: Card) {
        
        let player1Card = self.playerWest.cards.removeLast()
        let player2Card = self.playerEast.cards.removeLast()
        
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
        self.playerWest.cards = Array(gameDeck[0..<halfSize])
        self.playerEast.cards = Array(gameDeck[halfSize..<gameDeck.count])
        self.playerWestScore = 0
        self.playerEastScore = 0
    }
}
