//
//  MapaVC.swift
//  AirPortFinder
//
//  Created by Juan Gerardo Dominguez Cañas on 24/08/22.
//

import UIKit
import MapKit

class MapaVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    public var selectKM = 1
    public var listAirports: [ItemAirportElement] = []
    public var coordenadasUser: CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid
    
    deinit {
        print("Destruido MapaVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.showsUserLocation = true
        if CLLocationCoordinate2DIsValid(coordenadasUser) {
            let span = MKCoordinateSpan(latitudeDelta: Double(selectKM) * 0.02, longitudeDelta: Double(selectKM) * 0.02)
            let region = MKCoordinateRegion(center: coordenadasUser, span: span)
            //let rangoZoomMapa = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 5800000)
            mapView.setRegion(region, animated: true)
            //mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
            //mapView.setCameraZoomRange(rangoZoomMapa, animated: false)
            
                if self.listAirports.count != 0 {
                    let anotations = self.listAirports.map{ (item) -> MKPointAnnotation in
                        let addAnotation = MKPointAnnotation()
                        addAnotation.title = item.name
                        addAnotation.coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
                        return addAnotation
                    }
                    self.mapView.addAnnotations(anotations)
                }
        }
    }
}

extension MapaVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
}
