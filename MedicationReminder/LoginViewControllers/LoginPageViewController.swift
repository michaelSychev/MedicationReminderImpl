//
//  LoginPageViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/19/22.
//

import UIKit
var activePatient: Patient = Patient()
class LoginPageViewController: UIViewController
{
    var patientListLogin : [Patient] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    //login page text fields
    @IBOutlet weak var textfieldUserName: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    
    var isLoggedIn : Bool = false

    @IBAction func buttonSignIn(_ sender: UIButton!)
    {
        //grab core data
        //check if user name matches any of the users
        do
        {
            patientListLogin = try coreDataContext.fetch(Patient.fetchRequest())
        }
        catch
        {
            print("could not fetch core data :(")

        }
        //USERNAMES CANNOT BE THE SAME
        for patient in patientListLogin
        {
            if(patient.username! == textfieldUserName.text! && patient.password! == textfieldPassword.text!)
            {
                //if logged in correctly
                //set active patient to user
                activePatient = patient
                //segue way user to patientMenu
                performSegue(withIdentifier: "loginToPatient", sender: activePatient)
                //set user to be logged in
                isLoggedIn = true
                textfieldPassword.text = ""
                textfieldUserName.text = ""
                
            }
           
        }
        if(isLoggedIn == false)
        {
            let alertController = UIAlertController(title: "invalid login",
                                                            message:"could not find username or password",
                                                            preferredStyle:UIAlertController.Style.alert);
                    
                    alertController.addAction(UIAlertAction(title: "OK",
                                                            style:UIAlertAction.Style.default,
                                                            handler:nil));
                    
                    present(alertController,animated:true,completion:nil);
        }
        textfieldPassword.text = ""
        textfieldUserName.text = ""
        
        for k in patientListLogin
        {
            print("\(k.username!) \(k.password)" )
        }
        //check if the password is correct for that username
        //navigationController?.isToolbarHidden = true
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
