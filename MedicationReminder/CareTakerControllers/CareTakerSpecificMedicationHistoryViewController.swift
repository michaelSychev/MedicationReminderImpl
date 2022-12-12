//
//  CareTakerSpecificMedicationHistoryViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/30/22.
//

import UIKit

//  MedicationReminder
//
//  Created by Michael Sychev on 11/26/22.

class CareTakerSpecificMedicationHistoryViewController: UIViewController , UITableViewDelegate, UITableViewDataSource
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


        labelPatientName.text = currCTPatient.username!
        labelMedicationName.text = currCTMedicationGlobal.imprint!
        

    }


    @IBOutlet var labelPatientName: UILabel!
    @IBOutlet var labelMedicationName: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //print(websiteNames.count)
        return currCTRecordGlobal.timeTaken!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "taken at:\(currCTRecordGlobal.timeTaken![indexPath.row])"

        cell.layer.backgroundColor = UIColor.clear.cgColor

      //  cell.contentView.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated:true)
//        currMedication = medicationCollection[indexPath.row]
//        performSegue(withIdentifier: "medicationListToMedicationInfo", sender: currMedication)
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
        tableviewMedicationList.frame = CGRect(x: 0, y: 330, width: 1000, height: 200)
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
//
//  CareTakerSpecificMedicationHistoryViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/30/22.
//
//
//import UIKit
//
//class CareTakerSpecificMedicationHistoryViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
//    let tableviewWebsiteview: UITableView = UITableView()
//
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        //labelPatientName.text = currCTPatient.username!
//        //find name of medication
//
//        for k in currCTRecordGlobal.timeTaken!
//        {
//            timeRecord.append(k)
//            print(k)
//        }
//
//    }
//
//
//
//
//
//
//
//
//    @IBOutlet weak var labelPatientName: UILabel!
//
//    @IBOutlet weak var labelMedicationName: UILabel!
//    var medicationCollection : [Medication] = []
//    var patientCollection : [Patient] = []
//    var timeRecord : [String] = []
//
////    override func viewDidLoad()
////    {
////        super.viewDidLoad()
////
////            view.addSubview(tableviewWebsiteview)
////            tableviewWebsiteview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
////            tableviewWebsiteview.delegate = self
////            tableviewWebsiteview.dataSource = self
////            //\tableviewWebsiteview.reloadData()
////        //tableviewWebsiteview.backgroundView = UIImageView(image: UIImage(named: "iPhone-13-Pro-matching-gradient-wallpaper-AR72014-iDownloadBlog-Sierra-Blue-768x1662"))
////
////        //tableviewWebsiteview.backgroundColor = UIColor.clear
////        labelPatientName.text = currCTPatient.name!
////        self.tableviewWebsiteview.backgroundColor = UIColor.clear
////
////
////        do
////        {
////            prescribeRecordCollection =  try coreDataContext.fetch(PrescribeRecord.fetchRequest())
////            //add current prescription to user
////
////        }
////        catch{
////            print("could not fetch core data :(")
////        }
////        for record in prescribeRecordCollection
////        {
////            if(record.username! == currCTPatient.username!)
////            {
////                currCTPatientRecords.append(record)
////            }
////        }
////
////    }
//
//    var activePatientPrescriptionCollection : [Prescribe] = []
//    var prescriptionMedicationNames: [String] = []
//    var patientMedicationCollection : [Medication] = []
//    var prescribeRecordCollection : [PrescribeRecord] = []
//    var currCTPatientRecords : [PrescribeRecord] = []
//
//
//
//
//
//
//
//
//
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        //print(websiteNames.count)
//        print("timeRecord.count")
//        return timeRecord.count
//    }
//    //creates table cell content
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//
//        //cell creation stuff
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let cellContent:String = timeRecord[indexPath.row]
//       //check if medication has been taken
//
//
//        cell.textLabel?.text = cellContent
//        cell.contentView.backgroundColor = UIColor.clear
//        print(cellContent)
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    { //search for Prescribe for patient
//        tableView.deselectRow(at: indexPath, animated:true)
//        //
//    }
//
//    override func viewDidLayoutSubviews()
//    {
//        super.viewDidLayoutSubviews()
//        tableviewWebsiteview.frame = CGRect(x: 0, y: 250, width: 1000, height: 300)
//
//    }
//
//    override func viewDidAppear(_ animated: Bool)
//    {
//
//        do
//        {
//            medicationCollection = try coreDataContext.fetch(Medication.fetchRequest())
//            patientCollection = try coreDataContext.fetch(Patient.fetchRequest())
//
//            for medication in medicationCollection
//            {
//                if(medication.imprint! == currCTRecordGlobal.imprint)
//                {
//                    labelMedicationName.text = medication.name!
//                    break
//                }
//            }
//            for patient in patientCollection
//            {
//                if(patient.username! == currCTRecordGlobal.username!)
//                {
//                    labelPatientName.text = patient.username
//                    break
//                }
//            }
//        }
//        catch
//        {
//                print("Couldnt acess core date")
//        }
//        tableviewWebsiteview.reloadData()
//
//    }
//
//
//
//
//}
//
//
//
