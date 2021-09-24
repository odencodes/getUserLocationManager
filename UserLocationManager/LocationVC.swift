//
//  LocationVC.swift
//  UserLocationManager
//
//  Created by ODENZA on 14/8/2564 BE.
//

import UIKit
import CoreLocation

class LocationVC: UIViewController {

    private let notificationCenter = NotificationCenter.default
    private var observer: NSObjectProtocol?
    
    deinit {
        print("deinit...location view controller")
    }
    
    var alertView: UIAlertController {
        let alert = UIAlertController(title: "Locarion Service off", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        let action = UIAlertAction(title: "Turn on in Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        return alert
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.shared.checkLocationService()
        observerNotification()
        
        observer = notificationCenter.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main, using: { notification in
            print("willEnterForegroundNotification")
            //LocationManager.shared.checkLocationService()
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("--- viewWillDisappear ---")
        notificationCenter.removeObserver(self)
        
        if let observer = observer {
            notificationCenter.removeObserver(observer)
        }
    }
    
    func observerNotification() {
        notificationCenter.addObserver(forName: .sharedLocation, object: nil, queue: .main) { notification in
            
            guard let object = notification.object as? [String: Any] else { return }
            guard let error = object["error"] as? Bool else { return }
            
            if error {
                print("error to access location service.")
                
                
            } else {
                guard let location = object["location"] as? CLLocation else { return }
                print(location.coordinate.latitude)
            }
            
            
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

struct Alert {
    static func showActionAlert(_ title: String, message: String, actionTitle: String, vc: UIViewController,
                                   actionHandler: ((UIAlertAction) -> Void)? = nil,
                                   dismissHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Locarion Service off", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: dismissHandler)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: actionHandler)
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    
}
