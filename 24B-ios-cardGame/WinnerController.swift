import UIKit

class WinnerControllerViewController: UIViewController {

    @IBOutlet weak var winnerLBL: UILabel!
    
    @IBOutlet weak var scoreLBL: UILabel!
    @IBOutlet weak var resetBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        if let winner = UserDefaults.standard.string(forKey: "winner"){
            winnerLBL.text = "Winner: " + winner
        }
        if let score  = UserDefaults.standard.string(forKey: "score") {
            scoreLBL.text = "Score: " + String(score)
        } else {
            scoreLBL.isHidden = true
        }
    }

    
    @IBAction func backToStart(_ sender: Any) {
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "mainController") as? MainController {
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
