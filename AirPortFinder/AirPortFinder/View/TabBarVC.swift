//
//  TabBarVC.swift
//  AirPortFinder
//
//  Created by Juan Gerardo Dominguez Cañas on 24/08/22.
//

import UIKit
import CoreLocation

class TabBarVC: UITabBarController {
    
    public var coordenadasUser: CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid
    public var listAirports: [ItemAirportElement] = []
    public var selectKm = 1
    
    deinit {
        print("Destruido TabBarVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1  = storyboard.instantiateViewController(withIdentifier: "MapaVC") as! MapaVC
        vc1.selectKM = selectKm
        vc1.coordenadasUser = coordenadasUser
        vc1.listAirports = listAirports
        let vc2 = storyboard.instantiateViewController(withIdentifier: "ListaVC") as! ListaVC
        vc2.listAirports = listAirports
        self.viewControllers = [vc1, vc2]
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
