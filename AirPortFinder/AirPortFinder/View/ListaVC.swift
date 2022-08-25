//
//  ListaVC.swift
//  AirPortFinder
//
//  Created by Juan Gerardo Dominguez Cañas on 24/08/22.
//

import UIKit

class ListaVC: UIViewController {
    
    @IBOutlet weak var collectionAirports: UICollectionView!
    public var listAirports: [ItemAirportElement] = []
    
    deinit {
        print("Destruido ListaVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionAirports.reloadData()
    }
}

extension ListaVC : UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAirports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AirportCell", for: indexPath) as? AirportCell else {
            return UICollectionViewCell()
        }
        let item = listAirports[indexPath.row]
        cell.lblName.text = item.name
        cell.lblIataCode.text = item.iataCode
        cell.lblIcaoCode.text = item.icaoCode
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AirportCell
    }
}

class AirportCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblIataCode: UILabel!
    @IBOutlet weak var lblIcaoCode: UILabel!
}
