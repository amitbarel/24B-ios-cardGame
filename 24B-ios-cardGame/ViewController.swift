import UIKit
import Foundation

class ViewController: UIViewController {
    
    var previousController: MainController?
    
    @IBOutlet weak var winner: UITextField!
    
    @IBOutlet weak var Card1: UIImageView!
    @IBOutlet weak var Card2: UIImageView!
    
    @IBOutlet weak var westernPlayer: UILabel!
    @IBOutlet weak var easternPlayer: UILabel!
    
    @IBOutlet weak var ScoreW: UILabel!
    @IBOutlet weak var ScoreE: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    let gameManager : GameManager = GameManager()
    var gameTimer: Timer?
    var roundCounter = 0
    var isFront = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = previousController?.savedName {
            if var side = previousController?.side {
                if side == 1 {
                    westernPlayer.text = name
                    easternPlayer.text = "PC"
                } else {
                    westernPlayer.text = "PC"
                    easternPlayer.text = name
                }
            }
        }
        startButton.isEnabled = true
        updateUI()
    }
    
    
    @IBAction func startClicked(_ sender: UIButton) {
        gameTimer?.invalidate()
        roundCounter = 0
        startButton.isEnabled = false
        playRound()
        
    }
    
    @objc private func playRound() {
        guard roundCounter < 26 else {
            endGame()
            return
        }
        
        let result = gameManager.flipCards()
        
        uiFlipAndCompare(c1: result.player1Card, c2: result.player2Card)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        roundCounter += 1
        
        gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(playRound), userInfo: nil, repeats: false)
    }
    
    private func uiFlipAndCompare(c1: Card, c2: Card){
        if isFront {
            self.isFront = false
            let img1 = UIImage(named: c1.imageName)
            Card1.image = img1
            let img2 = UIImage(named: c2.imageName)
            Card2.image = img2
            UIView.transition(with: Card1, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            UIView.transition(with: Card2, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            let res = gameManager.compareCards(card1: c1, card2: c2)
            
            if res.compare(o2:c1){
                gameManager.playerWestScore += 1
            } else if res.compare(o2: c2){
                gameManager.playerEastScore += 1
            }
        } else {
            self.isFront = true
            let img = UIImage(named: "back_of_deck")
            Card1.image = img
            Card2.image = img
            UIView.transition(with: Card1, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            UIView.transition(with: Card2, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
    
    private func whoWon(){
        guard let namewW = westernPlayer.text, let nameE = easternPlayer.text else {
            return
        }
        winner.isHidden = false
        let const = " is the winner"
        if gameManager.playerWestScore > gameManager.playerEastScore {
            winner.text = namewW + const
        } else if gameManager.playerWestScore < gameManager.playerEastScore {
            winner.text = nameE + const
        } else {
            winner.text = "It was a tie"
        }
    }
    
    private func endGame() {
        gameTimer?.invalidate()
        gameTimer = nil
        updateUI()
        Card1.isHidden = true
        Card2.isHidden = true
        whoWon()
    }
    
    @objc private func updateUI() {
        guard let Score1 = ScoreW, let Score2 = ScoreE else {
            return
        }
                
        Score1.text = "\(gameManager.playerWestScore)"
        Score2.text = "\(gameManager.playerEastScore)"
    }
}

