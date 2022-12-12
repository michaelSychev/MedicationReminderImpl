//
//  CareTakerLoginViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/24/22.
//

import UIKit

class CareTakerLoginViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    let username = "test"
    let password = "test"
    @IBOutlet weak var textfieldCTUserName: UITextField!
    @IBOutlet weak var textfieldCTPassword: UITextField!
    
    @IBAction func buttonCTSignIn(_ sender: UIButton)
    {
        if(textfieldCTPassword.text! == password && textfieldCTUserName.text! == username)
        {
            
            performSegue(withIdentifier: "CTLoginToCTMenu", sender: activePatient)
        }
        else
        {
            let alertController = UIAlertController(title: "invalid login",
                                                            message:"You are not care taker, stay away  😡",
                                                            preferredStyle:UIAlertController.Style.alert);
                    
                    alertController.addAction(UIAlertAction(title: "I will not login to care taker",
                                                            style:UIAlertAction.Style.default,
                                                            handler:nil));
                    
                    present(alertController,animated:true,completion:nil);
        }
        textfieldCTPassword.text = ""
        textfieldCTUserName.text = ""
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
