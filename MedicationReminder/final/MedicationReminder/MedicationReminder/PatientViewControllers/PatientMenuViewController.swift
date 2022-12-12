//
//  PatientMedicationViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/9/22.
//

import UIKit

class PatientMenuViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let currentDate:Date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        //labelDate.text = "\(formatter.string(from: currentDate))"
        labelActivePatientName.text = activePatient.name!
    }
    
    let medicationTable: UITableView = UITableView()

    //@IBOutlet weak var labelDate: UILabel!

    @IBOutlet weak var labelActivePatientName: UILabel!
    
}
