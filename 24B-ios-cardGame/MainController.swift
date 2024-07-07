import UIKit
import CoreLocation

class MainController : UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var nameTXT: UITextView!
    @IBOutlet weak var etName: UITextField!
    
    @IBOutlet weak var enterBTN: UIButton!
    @IBOutlet weak var westernIMG: UIImageView!
    @IBOutlet weak var easternIMG: UIImageView!
    
    
    @IBOutlet weak var startBTN: UIButton!
    
    private var locationManager: CLLocationManager?
    
    var side : String = ""
    var currentLoc = 0.0
    var savedName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLocation()
    }
        
        @IBAction func start(_ sender: UIButton) {
            sender.isHidden = true
            self.performSegue(withIdentifier: "toTheGame", sender: self)
        }
        
        @IBAction func clickToSave(_ sender: UIButton) {
            savedName = (etName.text ?? "")
            nameTXT.text = "Hi " + (savedName)
            UserDefaults.standard.set(savedName, forKey: "name")
            etName.isHidden = true
            sender.isHidden = true
            startBTN.isHidden = false
            
            if currentLoc > 34.81801612783521{
                westernIMG.isHidden = true
                side = "east"
            } else {
                easternIMG.isHidden = true
                side = "west"
            }
            UserDefaults.standard.set(side, forKey: "side")
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
        
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "toTheGame" {
//                if let viewController = segue.destination as? ViewController {
//                    viewController.previousController = self
//                }
//            }
//        }
    
    }
