import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var Card1: UIImageView!
    @IBOutlet weak var Card2: UIImageView!
    
    
    @IBOutlet weak var Score1: UILabel!
    @IBOutlet weak var Score2: UILabel!
    
    
    @IBOutlet weak var startButton: UIButton!
    
    var gameManager : GameManager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameManager.resetGame()
    }


    @IBAction func startClicked(_ sender: UIButton) {
        self.gameManager.resetGame()
    }
}

