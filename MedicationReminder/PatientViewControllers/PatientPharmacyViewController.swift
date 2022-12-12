//
//  PatientPharmacyViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/24/22.
//

import UIKit
import MapKit
class PatientPharmacyViewController: UIViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let hospital: MKPointAnnotation = MKPointAnnotation()//create pin object
        hospital.coordinate = CLLocationCoordinate2DMake(40.3403880865, -74.6246678217)//set location of pin object
        hospital.title = "House MD phychiatry and Pharmaceutical "
        let myReigon: MKCoordinateRegion = MKCoordinateRegion(center: hospital.coordinate,
                                                              latitudinalMeters: 40,
                                                              longitudinalMeters: 40)
        mapPatientMap.setRegion(myReigon, animated: true)

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let locations: [MKPointAnnotation] = [hospital]
        mapPatientMap.addAnnotations(locations)


        // Do any additional setup after loading the view.
    }
    
    var locationManager: CLLocationManager = CLLocationManager()

    @IBOutlet weak var mapPatientMap: MKMapView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
