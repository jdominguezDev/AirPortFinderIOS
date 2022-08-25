//
//  MainVC.swift
//  AirPortFinder
//
//  Created by Juan Gerardo Dominguez Cañas on 24/08/22.
//

import UIKit
import CoreLocation

class MainVC: UIViewController{
    
    @IBOutlet weak var lblRadius: UILabel!
    @IBOutlet weak var sliderRadius: UISlider!
    private var locationManager = CLLocationManager()
    private var coordenadas: CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid //{ CLLocationCoordinate2D(latitude: 19.376070458679084, longitude: -99.17776752962808) }
    var aRadius = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(coordenadas)
        lblRadius.text = String(Int(sliderRadius.value))
        getCurrentLocation()
    }
    
    @IBAction func changeSlider(_ sender: UISlider) {
        aRadius = Int(sender.value)
        lblRadius.text = String(aRadius)
    }
    
    
    @IBAction func touchUpSearch(_ sender: UIButton) {
        
        if CLLocationCoordinate2DIsValid(coordenadas) {
            searchAirports()
        } else {
            print("Coordinate invalid")
        }
    }
    
    func searchAirports(){
        let apiClient = APIClient()
        apiClient.getAirports(latitud: String(coordenadas.latitude), longitud: String(coordenadas.longitude), radio: lblRadius.text ?? "1") { [weak self] (list) in
            DispatchQueue.main.async {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                vc.coordenadasUser = self?.coordenadas ?? kCLLocationCoordinate2DInvalid
                vc.listAirports = list
                vc.selectKm = self?.aRadius ?? 1
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

extension MainVC: CLLocationManagerDelegate {
    
    func getCurrentLocation(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            print("NO")
            return
        }
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        locationManager.startUpdatingLocation()
        coordenadas = location.coordinate
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager error: ", error, " ", error.localizedDescription)
    }
}
