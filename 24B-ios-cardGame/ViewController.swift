import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var Card1: UIImageView!
    @IBOutlet weak var Card2: UIImageView!
    
    @IBOutlet weak var westernPlayer: UILabel!
    @IBOutlet weak var easternPlayer: UILabel!
    
    @IBOutlet weak var ScoreW: UILabel!
    @IBOutlet weak var ScoreE: UILabel!
    
    let gameManager = GameManager()
    var roundCounter = 0
    var isFront = true
    var gameTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupPlayers()
        startGame()
        
    }
    
    private func setupPlayers() {
        if let name = UserDefaults.standard.string(forKey: "name"),
           let side = UserDefaults.standard.string(forKey: "side") {
            if side == "west" {
                westernPlayer.text = name
                easternPlayer.text = "PC"
            } else {
                westernPlayer.text = "PC"
                easternPlayer.text = name
            }
        }
    }
    
    private func startGame() {
        updateUI()
        roundCounter = 0
        gameTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(playRound), userInfo: nil, repeats: true)
    }
    
    @objc private func playRound() {
                
        if roundCounter >= 10 {
            endGame()
            return
        }
        
        let result = gameManager.flipCards()
        uiFlipAndCompare(c1: result.player1Card, c2: result.player2Card)
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
            self.roundCounter += 1
            updateUI()
        }
        
        
    }
    
    private func whoWon(){
        guard let namewW = westernPlayer.text, let nameE = easternPlayer.text else {
            return
        }
        var winningScore = ""
        var winner : String = ""
        if gameManager.playerWestScore > gameManager.playerEastScore {
            winner = namewW
            winningScore = String(gameManager.playerWestScore)
        } else if gameManager.playerWestScore < gameManager.playerEastScore {
            winner = nameE
            winningScore = String(gameManager.playerEastScore)
        } else {
            winner = "Tie"
        }
        if winningScore != "" {
            UserDefaults.standard.set(winningScore, forKey: "score")
        }
        UserDefaults.standard.set(winner, forKey: "winner")
    }
    
    private func endGame() {
        gameTimer?.invalidate()
        gameTimer = nil
        updateUI()
        Card1.isHidden = true
        Card2.isHidden = true
        whoWon()
        if let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "winnerController") as? WinnerControllerViewController {
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    @objc private func updateUI() {
        guard let Score1 = ScoreW, let Score2 = ScoreE else {
            return
        }
                
        Score1.text = "\(gameManager.playerWestScore)"
        Score2.text = "\(gameManager.playerEastScore)"
    }
    
    deinit {
        gameTimer?.invalidate()
    }
}

