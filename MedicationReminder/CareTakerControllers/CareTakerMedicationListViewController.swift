//
//  CareTakerMedicationViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/26/22.
//

import UIKit
var currMedication: Medication = Medication()
class CareTakerMedicationViewController: UIViewController , UITableViewDelegate, UITableViewDataSource
{
    let tableviewMedicationList: UITableView = UITableView()
    var medicationCollection: [Medication] = []
    var medicationImprintList: [String] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

            view.addSubview(tableviewMedicationList)
            tableviewMedicationList.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            tableviewMedicationList.delegate = self
            tableviewMedicationList.dataSource = self
            tableviewMedicationList.reloadData()
        tableviewMedicationList.backgroundView = UIImageView(image: UIImage(named: "iPhone-13-Pro-matching-gradient-wallpaper-AR72014-iDownloadBlog-Sierra-Blue-768x1662"))

        tableviewMedicationList.backgroundColor = UIColor.clear





    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //print(websiteNames.count)
        return medicationCollection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(medicationCollection[indexPath.row].name!)(\(medicationCollection[indexPath.row].imprint!))"

        cell.layer.backgroundColor = UIColor.clear.cgColor

      //  cell.contentView.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated:true)
        currMedication = medicationCollection[indexPath.row]
        performSegue(withIdentifier: "medicationListToMedicationInfo", sender: currMedication)
        //perform segueway to new viewcontroller wth necesary infp
       // newPatientInfo = patientCollection[indexPath.row]
       // performSegue(withIdentifier: "nothingimportant", sender: newWebsiteInfo)

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
        tableviewMedicationList.frame = CGRect(x: 0, y: 150, width: 1000, height: 200)
        tableviewMedicationList.reloadData()
    }

    override func viewDidAppear(_ animated: Bool)
    {
        do
        {
            medicationCollection =  try coreDataContext.fetch(Medication.fetchRequest())

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
        tableviewMedicationList.reloadData()

    }


//PUT DELETE FUNCTION
    //Swipe left to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {

        if editingStyle == .delete
        {
                let patient = medicationCollection[indexPath.row]
                coreDataContext.delete(patient)
                medicationCollection.remove(at: indexPath.row)
                tableviewMedicationList.deleteRows(at: [indexPath], with: .fade)
                appDelegate.saveContext()
            }

        }

   

}
