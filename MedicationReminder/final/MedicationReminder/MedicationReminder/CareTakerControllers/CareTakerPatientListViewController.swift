//
//  CareTakerPatientViewViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/24/22.
//

import UIKit
var currCTPatient = Patient() //current patient care taker is viewing

class CareTakerPatientListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let tableviewWebsiteview: UITableView = UITableView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

            view.addSubview(tableviewWebsiteview)
            tableviewWebsiteview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            tableviewWebsiteview.delegate = self
            tableviewWebsiteview.dataSource = self
            tableviewWebsiteview.reloadData()
        //tableviewWebsiteview.backgroundView = UIImageView(image: UIImage(named: "iPhone-13-Pro-matching-gradient-wallpaper-AR72014-iDownloadBlog-Sierra-Blue-768x1662"))
        
        //tableviewWebsiteview.backgroundColor = UIColor.clear

        self.tableviewWebsiteview.backgroundColor = UIColor.clear

        


    }
    
    var patientCollection: [Patient] = []
    var PatientUserNames: [String] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //print(websiteNames.count)
        return patientCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = patientCollection[indexPath.row].username

        cell.layer.backgroundColor = UIColor.clear.cgColor

        cell.contentView.backgroundColor = UIColor.clear
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated:true)
        currCTPatient = patientCollection[indexPath.row]
        performSegue(withIdentifier: "patientListToPatientMedication", sender: currCTPatient)
        
    }
   
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        if segue.identifier == "nothingimportant"
//        {
//            let myWebsiteInfoPageViewController = segue.destination as? websiteInfoPageViewController
//            myWebsiteInfoPageViewController?.labelURL.text! = newWebsiteInfo.url!
//            myWebsiteInfoPageViewController?.labelPassword.text = newWebsiteInfo.password
//            myWebsiteInfoPageViewController?.labelUserName.text = newWebsiteInfo.username
//            myWebsiteInfoPageViewController?.labelWebsiteName.text = newWebsiteInfo.mycellname
//        }
//        if segue.identifier == "name”OfSegue {
//                let VC = segue.destination as! NameofViewControllerDestination
//                    VC.nameOfWhatYouAreSending   = sender as! TypeOfTheObjectSent
//                }
        
//    }
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        tableviewWebsiteview.frame = CGRect(x: 0, y: 150, width: 1000, height: 200)
        
        tableviewWebsiteview.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        do
        {
            patientCollection =  try coreDataContext.fetch(Patient.fetchRequest())
            
        }
        catch{
            print("could not fetch core data :(")
        }
        
//        for website in websiteCollection
//        {
//            if let safeWebsiteName = website.mycellname
//            {
//                websiteNames.append(safeWebsiteName)
//            }
//        }
        tableviewWebsiteview.reloadData()
    
    }

    
//PUT DELETE FUNCTION
    //Swipe left to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
         
        if editingStyle == .delete
        {
                let patient = patientCollection[indexPath.row]
                coreDataContext.delete(patient)
                patientCollection.remove(at: indexPath.row)
                tableviewWebsiteview.deleteRows(at: [indexPath], with: .fade)
                appDelegate.saveContext()
            }

        }
    
   

}
