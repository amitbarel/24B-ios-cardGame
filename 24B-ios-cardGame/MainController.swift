import UIKit
import CoreLocation

class DataManager {
    static let shared = DataManager()
    var myName : String = ""
}

class MainController : UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var nameTXT: UITextView!
    @IBOutlet weak var etName: UITextField!
    
    @IBOutlet weak var enterBTN: UIButton!
    @IBOutlet weak var westernIMG: UIImageView!
    @IBOutlet weak var easternIMG: UIImageView!
    
    
    @IBOutlet weak var startBTN: UIButton!
    
    private var locationManager: CLLocationManager?
    
    var side = 2
    var currentLoc = 0.0
    var comparedLoc = 0.0
    var savedName = DataManager.shared.myName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
            
    }
        
        @IBAction func start(_ sender: UIButton) {
            sender.isHidden = true
            performSegue(withIdentifier: "toTheGame", sender: self)
        }
        
        @IBAction func clickToSave(_ sender: UIButton) {
            savedName = (etName.text ?? "")
            nameTXT.text = "Hi " + (savedName)
            DataManager.shared.myName = savedName
            etName.isHidden = true
            sender.isHidden = true
            startBTN.isHidden = false
            
            if currentLoc > 34.81801612783521{
                easternIMG.isHidden = true
            } else {
                westernIMG.isHidden = true
                side = 1
            }
        }
        
        func getUserLocation(){
            locationManager =  CLLocationManager()
            locationManager?.requestAlwaysAuthorization()
            locationManager?.startUpdatingLocation()
            locationManager?.stopUpdatingLocation()
            locationManager?.delegate = self
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLoctaions locations : [CLLocation]) {
            if let location = locations.last {
                currentLoc = location.coordinate.longitude
            }
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toTheGame" {
                if let viewController = segue.destination as? ViewController {
                    viewController.previousController = self
                }
            }
        }
    
    }
