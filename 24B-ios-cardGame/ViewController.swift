import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var Card1: UIImageView!
    @IBOutlet weak var Card2: UIImageView!
    
    
    @IBOutlet weak var Score1: UILabel!
    @IBOutlet weak var Score2: UILabel!
    
    var gameManager : GameManager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameManager.resetGame()
    }


}

