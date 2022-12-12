//
//  PatientRegistrationViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/19/22.
//

import UIKit
import CoreData
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let coreDataContext = appDelegate.persistentContainer.viewContext
class PatientRegistrationViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
      

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var textfieldPatientFullName: UITextField!
    @IBOutlet weak var textfieldPatientUserName: UITextField!
    @IBOutlet weak var textfieldPatientPassword: UITextField!
    @IBOutlet weak var textfieldPatientAdress: UITextField!


    @IBAction func buttonRegisterPatient(_ sender: UIButton)
    {
        let alertController = UIAlertController(title: "Success",
                                                message:"welcome \(textfieldPatientFullName.text!)",
                                                        preferredStyle:UIAlertController.Style.alert);
                
                alertController.addAction(UIAlertAction(title: "OK",
                                                        style:UIAlertAction.Style.default,
                                                        handler:nil));
                
                present(alertController,animated:true,completion:nil);
        addNewUser(username: textfieldPatientUserName.text!, password: textfieldPatientPassword.text!, name: textfieldPatientFullName.text!, adress: textfieldPatientAdress.text!)
        textfieldPatientFullName.text = ""
        textfieldPatientUserName.text = ""
        textfieldPatientPassword.text = ""
        textfieldPatientAdress.text = ""
        
    }
    func addNewUser(username: String, password: String , name: String, adress: String) -> Void
    {
        let newPatient: Patient = Patient(context: coreDataContext)//creates new instance of Accounts object
        //username,password, name,adress
        newPatient.username = username//id of user
        newPatient.password = password
        newPatient.name = name
        newPatient.adress = adress
        appDelegate.saveContext()
    }
    //array to hold user objects
    var allPatients: [Patient] = []

    override func viewDidAppear(_ animated: Bool)
    {
        
        
//        for patient in allPatients
//        {
//            if let safePatientAttrubute = patient.Attribute
//            {
//                allPatients.append(safePatientAttrubute)
//            }
//        }
    
    }
    //pre:None
    //post: fetches core data
    func fetchCoreData()-> Void
    {
        do
        {
            allPatients =  try coreDataContext.fetch(Patient.fetchRequest())//fetch patients from core data
            
        }
        catch{
            print("could not access patients fetch core data  :(")
        }
//        for patient in allPatients
//        {
//            print(patient.username!)
//
//        }
    }
}
