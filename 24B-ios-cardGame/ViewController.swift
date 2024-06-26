import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var Card1: UIImageView!
    @IBOutlet weak var Card2: UIImageView!
    
    @IBOutlet weak var Score1: UILabel!
    @IBOutlet weak var Score2: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    let gameManager : GameManager = GameManager()
    var gameTimer: Timer?
    var roundCounter = 0
    var isFront = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        roundCounter += 1
        
        gameTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(playRound), userInfo: nil, repeats: false)
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
                gameManager.player1Score += 1
            } else if res.compare(o2: c2){
                gameManager.player2Score += 1
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
    
    private func endGame() {
        gameTimer?.invalidate()
        gameTimer = nil
        startButton.isEnabled = true
        updateUI()
    }
    
    @objc private func updateUI() {
        guard let Score1 = Score1, let Score2 = Score2 else {
            return
        }
                
        Score1.text = "\(gameManager.player1Score)"
        Score2.text = "\(gameManager.player2Score)"
    }
}

