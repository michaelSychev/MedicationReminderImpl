//
//  CareTakerPatientMedicationHistorViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/30/22.
//

import UIKit
var currCTRecordGlobal : PrescribeRecord = PrescribeRecord()
var currCTMedicationGlobal : Medication = Medication()
class CareTakerPatientMedicationHistorViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource
{
    let tableviewWebsiteview: UITableView = UITableView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

            view.addSubview(tableviewWebsiteview)
            tableviewWebsiteview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            tableviewWebsiteview.delegate = self
            tableviewWebsiteview.dataSource = self
            //\tableviewWebsiteview.reloadData()
        //tableviewWebsiteview.backgroundView = UIImageView(image: UIImage(named: "iPhone-13-Pro-matching-gradient-wallpaper-AR72014-iDownloadBlog-Sierra-Blue-768x1662"))
        
        //tableviewWebsiteview.backgroundColor = UIColor.clear
        labelPatientName.text = currCTPatient.name!
        self.tableviewWebsiteview.backgroundColor = UIColor.clear
        
        
        do
        {
            prescribeRecordCollection =  try coreDataContext.fetch(PrescribeRecord.fetchRequest())
            //add current prescription to user
            medicationCollection = try coreDataContext.fetch(Medication.fetchRequest()
            )
        }
        catch{
            print("could not fetch core data :(")
        }
        for record in prescribeRecordCollection
        {
            if(record.username! == currCTPatient.username!)
            {
                currCTPatientRecords.append(record)
            }
        }
        
       
    }
    
    var activePatientPrescriptionCollection : [Prescribe] = []
    var prescriptionMedicationNames: [String] = []
    var medicationCollection : [Medication] = []
    var patientMedicationCollection : [Medication] = []
    var prescribeRecordCollection : [PrescribeRecord] = []
    var currCTPatientRecords : [PrescribeRecord] = []
    
    
    
    
    @IBOutlet weak var labelPatientName: UILabel!
    
    
    
    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return currCTPatientRecords.count
    }
    //creates table cell content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var requestedMedication = Medication()
        //core data stuff
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
            if(medication.imprint! == currCTPatientRecords[indexPath.row].imprint!)
            {
                requestedMedication = medication
                break
            }
        }
        //cell creation stuff
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cellContent:String = currCTPatientRecords[indexPath.row].imprint!
       //check if medication has been taken
       
        
        cell.textLabel?.text = cellContent
        cell.contentView.backgroundColor = UIColor.clear
        cell.imageView?.image = UIImage(data:requestedMedication.image!)//set medication image
        
       
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    { //search for Prescribe for patient
        tableView.deselectRow(at: indexPath, animated:true)
        currCTRecordGlobal = currCTPatientRecords[indexPath.row]
        for medication in medicationCollection
        {
            if(medication.imprint! == currCTPatientRecords[indexPath.row].imprint! )
            {
                currCTMedicationGlobal = medication
                break
            }
        }
        performSegue(withIdentifier: "historyToSpecifcHistory", sender: nil)
        //
    }
   
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        tableviewWebsiteview.frame = CGRect(x: 0, y: 250, width: 1000, height: 300)
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
//        for website in websiteCollection
//        {
//            if let safeWebsiteName = website.mycellname
//            {
//                websiteNames.append(safeWebsiteName)
//            }
//        }
        tableviewWebsiteview.reloadData()
    
    }

    


}
