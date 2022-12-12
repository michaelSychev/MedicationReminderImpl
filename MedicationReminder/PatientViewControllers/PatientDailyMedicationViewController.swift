//
//  PatientDailyMedicationViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/28/22.
//

import UIKit

class PatientDailyMedicationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
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
        
        labelPatientName.text = activePatient.name!
    }
    
    var prescriptionCollection: [Prescribe] = []
    var activePatientPrescriptionCollection : [Prescribe] = []
    var prescriptionMedicationNames: [String] = []
    var medicationCollection : [Medication] = []
    var prescribeRecordCollection : [PrescribeRecord] = []
    var requestedImprintsFromPrescribe: [String] = []
    var requestedPrescibeRecord: PrescribeRecord = PrescribeRecord()

    @IBOutlet weak var labelPatientName: UILabel!
    
    //time stuff
    //time stuff
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //print(websiteNames.count)
        return activePatientPrescriptionCollection.count
    }
    //creates table cell content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //core data stuff
        var requestedMedication = Medication() //need to grab reqested medication
        do
        {
            medicationCollection =  try coreDataContext.fetch(Medication.fetchRequest())
            //add current prescription to user
        }
        catch
        {
            print("could not fetch core data from medication 😢")
        }
        for medication in medicationCollection
        {
            if(medication.imprint! == activePatientPrescriptionCollection[indexPath.row].imprint!)
            {
                requestedMedication = medication
                break
            }
        }
        //date stuff
        let time: Date = Date()
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        var inputDate = dateFormatter.string(from: time)
        //cell creation stuff
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var cellContent:String = ""

        
       //check if medication has been taken
        if(activePatientPrescriptionCollection[indexPath.row].takenTime! == "not taken yet")
        {//we assume medication hasnt been taken
           cellContent = "\(activePatientPrescriptionCollection[indexPath.row].medicationName!) to be taken at \(activePatientPrescriptionCollection[indexPath.row].scheduledTime!) status: not taken yet"
        }
        else
        {//else we assume medicaion hasnt been taken
          cellContent = "\(activePatientPrescriptionCollection[indexPath.row].medicationName!) to be taken at \(activePatientPrescriptionCollection[indexPath.row].scheduledTime!) status: taken at \(activePatientPrescriptionCollection[indexPath.row].takenTime!)"
            
        }
        cell.textLabel?.text = cellContent
        cell.contentView.backgroundColor = UIColor.clear
        cell.imageView?.image = UIImage(data:requestedMedication.image!)//set medication image
       
       
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    { //search for Prescribe for patient
        tableView.deselectRow(at: indexPath, animated:true)

        var requestedPrescription: Prescribe = Prescribe()
        var loggedInUserRecords : [PrescribeRecord] = []
    
        do
        {
            prescribeRecordCollection =  try coreDataContext.fetch(PrescribeRecord.fetchRequest())
            //grab user records
            for record in prescribeRecordCollection
            {
                //if the record name mathces active patient name and the record imprint matches the imprint of the medication it is
                //the right medication
                if(record.username! == activePatient.username! )
                {
                    loggedInUserRecords.append(record)
                    //print("\(record.imprint!) \(record.username!) 😊")
                }
            }
            for currLoggedInPatientRecord in loggedInUserRecords
            {
                print("I am here")
                if(currLoggedInPatientRecord.imprint! == activePatientPrescriptionCollection[indexPath.row].imprint!)
                {
                    requestedPrescibeRecord = currLoggedInPatientRecord
//                    print(("imprint is\(requestedPrescibeRecord.imprint)"))
//                    print("I am here 2🅾️")
                }
            }
            let time: Date = Date()
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            var inputDate = dateFormatter.string(from: time)
            
            requestedPrescibeRecord.timeTaken?.append(inputDate)
        }

        catch
        {
            print("could not fetch core data from medication 😢")
        }
//        //search for requested presciption
        do
        {
            prescriptionCollection =  try coreDataContext.fetch(Prescribe.fetchRequest())

            //search for prescription
            for specificPrescription in activePatientPrescriptionCollection
            {
                //if prescription matches the prescription at the selected row
                if(specificPrescription.imprint! == activePatientPrescriptionCollection[indexPath.row].imprint! )//gets prescription at row
                {

                    if(specificPrescription.scheduledTime == activePatientPrescriptionCollection[indexPath.row].scheduledTime)
                    {
                        requestedPrescription = specificPrescription//this is medication we are searching for
                        break
                    }
                }
            }
            //find medication in user records
           

        }
        catch{
            print("could not fetch core data :(")
        }
//        //date stuff
        let time: Date = Date()
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        //        var inputDate = dateFormatter.string(from: time)
        var inputDate = dateFormatter.string(from: time)
//        //when clicked set time
//       // self.tableviewWebsiteview.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
//
//
        if(requestedPrescription.takenTime! == "not taken yet")
        {
            requestedPrescription.takenTime = inputDate
        }
        

        
  //      print(requestedPrescibeRecord.username)

        self.tableviewWebsiteview.reloadRows(at: [indexPath],
                                             with:.top )
        appDelegate.saveContext()

    }
   

    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        tableviewWebsiteview.frame = CGRect(x: 0, y: 250, width: 1000, height: 300)
        
        tableviewWebsiteview.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        do
        {
            prescriptionCollection =  try coreDataContext.fetch(Prescribe.fetchRequest())
            //add current prescription to user
            for prescription in prescriptionCollection
            {
                if (activePatient.username == prescription.username)
                {
                    activePatientPrescriptionCollection.append(prescription)
                }
            }

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
    @objc func restartMedication()
    {
        
        let alertController = UIAlertController(title: "It is 12 am",
                                                        message:"Hello user",
                                                        preferredStyle:UIAlertController.Style.alert);
                
                alertController.addAction(UIAlertAction(title: "OK",
                                                        style:UIAlertAction.Style.default,
                                                        handler:nil));
                
                present(alertController,animated:true,completion:nil);
        
    }
    


}

