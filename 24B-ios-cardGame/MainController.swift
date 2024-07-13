import UIKit
import CoreLocation

class MainController : UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var etName: UITextField!
    
    @IBOutlet weak var enterBTN: UIButton!
    @IBOutlet weak var westernIMG: UIImageView!
    @IBOutlet weak var easternIMG: UIImageView!
    
    @IBOutlet weak var nameLBL: UILabel!
    
    @IBOutlet weak var startBTN: UIButton!
    
    var locationManager: CLLocationManager!
    
    var side : String = ""
    var savedName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if let playername = UserDefaults.standard.string(forKey: "name") {
            etName.isHidden = true
            enterBTN.isHidden = true
            nameLBL.text = "Hi " + (playername)
            nameLBL.isHidden = false
            if let playerSide = UserDefaults.standard.string(forKey: "side"){
                if playerSide == "east" {
                    westernIMG.isHidden = true
                } else {
                    easternIMG.isHidden = true
                }
            }
        }
    }
        
    @IBAction func start(_ sender: UIButton) {
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "viewController") as? ViewController{
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    @IBAction func clickToSave(_ sender: UIButton) {
        savedName = (etName.text ?? "")
        nameLBL.isHidden = false
        nameLBL.text = "Hi " + (savedName)
        UserDefaults.standard.set(savedName, forKey: "name")
        etName.isHidden = true
        sender.isHidden = true
        startBTN.isHidden = false
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            if lon > 34.81801612783521 {
                self.westernIMG.isHidden = true
                self.side = "east"
            } else {
                self.easternIMG.isHidden = true
                self.side = "west"
            }
            UserDefaults.standard.set(self.side, forKey: "side")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager Error: \(error)")
    }
}
