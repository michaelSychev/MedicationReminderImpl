//
//  CareTakerMedicationInfoViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/26/22.
//

import UIKit

class CareTakerMedicationInfoViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        do
        {
           let medicationCollection =  try coreDataContext.fetch(Medication.fetchRequest())
            
        }
        catch{
            print("could not fetch core data :(")
        }
    
        //set new label name
        labelNameandStrength.text = "\(currMedication.name!) \(currMedication.strength!)"
        //set imprint
        labelImprint.text = "\(currMedication.imprint!)"
        //set image
        imageMedicationImage.image = UIImage(data: currMedication.image!)
        
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var labelNameandStrength: UILabel!
    @IBOutlet weak var labelImprint: UILabel!
    @IBOutlet weak var imageMedicationImage: UIImageView!
    
}
