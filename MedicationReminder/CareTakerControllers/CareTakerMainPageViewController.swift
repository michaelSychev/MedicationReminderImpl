//
//  CareTakerMainPageViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/26/22.
//

import UIKit

class CareTakerMainPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func buttonLogOut(_ sender: UIButton)
    {
        performSegue(withIdentifier: "CareTakerToLogin", sender: .none)
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
