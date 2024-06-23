import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var Card1: UIImageView!
    @IBOutlet weak var Card2: UIImageView!
    
    @IBOutlet weak var Score1: UILabel!
    @IBOutlet weak var Score2: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    let gameManager : GameManager = GameManager()
    var gameTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


    @IBAction func startClicked(_ sender: UIButton) {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(playRound), userInfo: nil, repeats: true)
        startButton.isEnabled = false
        
    }
    
    @objc private func playRound() {
        updateUI()
        
        for _ in 1...26 {
            let result = gameManager.flipCards()
            Card1.image = UIImage(named: result.player1Card.imageName)
            Card2.image = UIImage(named: result.player2Card.imageName)
            
            let res = gameManager.compareCards(card1: result.player1Card, card2: result.player2Card)

            if res.compare(o2:result.player1Card){
                gameManager.player1Score += 1
            } else if res.compare(o2: result.player2Card){
                gameManager.player2Score += 1
            }
            updateUI()
        }
        
        endGame()
    }
    
    private func endGame() {
        gameTimer?.invalidate()
        gameTimer = nil
        startButton.isEnabled = true
        updateUI()
    }
    
    private func updateUI() {
        guard let Score1 = Score1, let Score2 = Score2 else {
            return
        }
                
        Score1.text = "\(gameManager.player1Score)"
        Score2.text = "\(gameManager.player2Score)"
    }
}

