//
//  AddLocationVC.swift
//  WeatherAppDemo
//
//  Created by vivek G on 12/09/21.
//

import UIKit
import MapKit
import CoreLocation

class AddLocationVC: UIViewController, MKMapViewDelegate ,CLLocationManagerDelegate,UIGestureRecognizerDelegate
{
    @IBOutlet weak var mapView: MKMapView!
     var locationManager: CLLocationManager!
     let regionRadius: CLLocationDistance = 1000
    
    var dictParam = [String:Any]()
    
    @IBOutlet weak var lblLocation:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Add Location"
        mapView.delegate = self

        let gestureRecognizer = UITapGestureRecognizer(
                                      target: self, action:#selector(handleTap))
            gestureRecognizer.delegate = self
            mapView.addGestureRecognizer(gestureRecognizer)
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
      
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        mapView.removeAnnotations(mapView.annotations)
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        self.setCityFor(strLocation: coordinate)
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last
        {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
            
            mapView.removeAnnotations(mapView.annotations)
            
            self.setCityFor(strLocation: center)
            
            let annotation = MKPointAnnotation()
            let centerCoordinate = location.coordinate
            annotation.coordinate = centerCoordinate
            annotation.title = "Title"
    
            mapView.addAnnotation(annotation)
        }
    }
    func setCityFor(strLocation:CLLocationCoordinate2D)
    {
        // Add below code to get address for touch coordinates.
              let geoCoder = CLGeocoder()
              let location = CLLocation(latitude: strLocation.latitude, longitude: strLocation.longitude)
              geoCoder.reverseGeocodeLocation(location, completionHandler:
                                                { [self]
                      placemarks, error -> Void in

                      // Place details
                      guard let placeMark = placemarks?.first else { return }
                    
                    self.dictParam.removeAll()
                    self.dictParam[VGConstants.shared.lat] = "\(strLocation.latitude)"
                    self.dictParam[VGConstants.shared.long] = "\(strLocation.longitude)"
                                                    
                      // Location name
                    var strPlace = ""
                      if let locationName = placeMark.location {
                        //strPlace = "Location : \(locationName)"
                        print(locationName)
                      }
                      // Street address
                      if let street = placeMark.thoroughfare {
                          print(street)
                      }
                      // City
                      if let city = placeMark.subAdministrativeArea {
                          print(city)
                        strPlace = " city :\(city)"
                        self.dictParam[VGConstants.shared.cityName] = "\(city)"
                      }
                      // Zip code
                      if let zip = placeMark.postalCode {
                          print(zip)
                        strPlace = "\(strPlace) , zip :\(zip)"
                        self.dictParam[VGConstants.shared.postalCode] = "\(zip)"
                      }
                      // Country
                      if let country = placeMark.country {
                          print(country)
                        strPlace = "\(strPlace) , country :\(country)"
                        self.dictParam[VGConstants.shared.country] = "\(country)"
                      }
                    // Place Name
                    if let name = placeMark.subLocality {
                        
                        strPlace = "\(strPlace) , name :\(name)"
                        self.dictParam[VGConstants.shared.locality] = "\(name)"
                        self.lblLocation.text = strPlace
                    }
              })
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.isDraggable = true
        }
        else {
            pinView?.annotation = annotation
        }

        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if newState == MKAnnotationView.DragState.ending {
            let droppedAt = view.annotation?.coordinate
            print(droppedAt)
            
            mapView.removeAnnotations(mapView.annotations)
            
//            let location = gestureRecognizer.location(in: mapView)
//            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
            
            // Add annotation:
            let annotation = MKPointAnnotation()
            annotation.coordinate = droppedAt!
            mapView.addAnnotation(annotation)
            
        }
    }

    //MARK: - button delegate method
    @IBAction func btnAddLocation(sender:UIButton)
    {
        coreDataStructure().saveCityList(data: dictParam) { (isSuccess) in
            if isSuccess
            {
                VGUtility.shared.showAlertWith(Title: "", Message: "Data saved successfully", onVC: self)
            }
            else
            {
                VGUtility.shared.showAlertWith(Title: "", Message: "Data Not saved", onVC: self)
            }
        }
    }
}
