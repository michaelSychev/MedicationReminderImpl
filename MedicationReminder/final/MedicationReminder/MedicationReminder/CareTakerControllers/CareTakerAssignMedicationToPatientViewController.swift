//
//  CareTakerAssignMedicationToPatientViewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/28/22.
//

import UIKit

class CareTakerAssignMedicationToPatientViewController: UIViewController , UITableViewDelegate, UITableViewDataSource
{
    let tableviewMedicationList: UITableView = UITableView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
            //set patient name
            labelCurrPatientName.text = currCTPatient.name
            view.addSubview(tableviewMedicationList)
            tableviewMedicationList.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            tableviewMedicationList.delegate = self
            tableviewMedicationList.dataSource = self
            tableviewMedicationList.reloadData()
        //tableviewWebsiteview.backgroundView = UIImageView(image: UIImage(named: "iPhone-13-Pro-matching-gradient-wallpaper-AR72014-iDownloadBlog-Sierra-Blue-768x1662"))
        labelCurrPatientName.text = currCTPatient.name!
        //time stuff
       
        print(getTime())



    }

    
    
    
    
    @IBOutlet weak var datePickerTimeToBeTaken: UIDatePicker!
    @IBOutlet weak var labelPrescriptionSelection: UILabel!
    @IBOutlet weak var labelCurrPatientName: UILabel!
    @IBOutlet weak var labelPrescriptionSummary: UILabel!
    
    var medicationCollection: [Medication] = []
    var medicationImprintList: [String] = []
    var selectedMedication : Medication = Medication()
    
    var prescribeRecordCollection : [PrescribeRecord] = []
    var currCTRecordCollectiom : [PrescribeRecord] = []
    
    //TABLE STUFF
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //print(websiteNames.count)
        return medicationCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(medicationCollection[indexPath.row].name!)(\(medicationCollection[indexPath.row].imprint!))"
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated:true)
        selectedMedication = medicationCollection[indexPath.row]
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        //        var inputDate = dateFormatter.string(from: time)
        var inputDate = dateFormatter.string(from: datePickerTimeToBeTaken.date)
        //Set selected medication to desired Medication
        labelPrescriptionSelection.text = selectedMedication.name!
        labelPrescriptionSummary.text = "\(currCTPatient.name!) is to be prescribed \(selectedMedication.name!) and to take it at: \(inputDate)"
        
        
    }
   

    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        tableviewMedicationList.frame = CGRect(x: 0, y: 500, width: 1000, height: 200)
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
        

        tableviewMedicationList.reloadData()
    
    }


    
   //TIME STUFF
    //pre:none
    //post:submits new prescription for user
    @IBAction func buttonSubmitPrescription(_ sender: Any)
    {
        addNewPrescription()
        var isPrescribedMedication : Bool = false
//        addNewPrescriptionRecord()
        //we must create prescription record only if this is first time patient gets medication
        //import patient records
        do
        {
            prescribeRecordCollection =  try coreDataContext.fetch(PrescribeRecord.fetchRequest())
            //
            for record in prescribeRecordCollection
            {
                if(record.username! == currCTPatient.username)
                {
                    currCTRecordCollectiom.append(record)
                }
                
            }
            //now we have the records, we must see if the records contain the medicaiton
            for currRecord in currCTRecordCollectiom
            {
                if(currRecord.imprint! == selectedMedication.imprint)
                {
                    isPrescribedMedication = true
                }
            }
        }

        catch
        {
            print("could not fetch core data from medication 😢")
        }
        if(isPrescribedMedication == false)//medication hasnt been assigned before
        {
            //we give record to patient for said medication
            addNewPrescriptionRecord()
            let alertController = UIAlertController(title: "Record Created",
                                                    message:"First time \(selectedMedication.name!) has     been prescribed to \(currCTPatient.name!).      Patient record has been created",
                                                    preferredStyle:UIAlertController.Style.alert);
                    
                    alertController.addAction(UIAlertAction(title: "OK",
                                                            style:UIAlertAction.Style.default,
                                                            handler:nil));
            let alertController2 = UIAlertController(title: "Success",
                                                    message:"Prescription Submit",
                                                            preferredStyle:UIAlertController.Style.alert);
                    
                    alertController2.addAction(UIAlertAction(title: "OK",
                                                            style:UIAlertAction.Style.default,
                                                            handler:nil));
                    
                    present(alertController,animated:true,completion:nil);
                    present(alertController2,animated:true,completion:nil)
        }
        else
        {
            let alertController = UIAlertController(title: "Success",
                                                            message:"Prescription has been submit",
                                                            preferredStyle:UIAlertController.Style.alert);
                    
                    alertController.addAction(UIAlertAction(title: "OK",
                                                            style:UIAlertAction.Style.default,
                                                            handler:nil));
                    
                    present(alertController,animated:true,completion:nil);
        }
        //add medication for requested amount of times
        var dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .short // You can also use Long, Medium and No style.
        dateFormatter.timeStyle = .none

//            var inputDate = dateFormatter.stringFromDate(*datepicker outlet name*.date)
        var inputDate = dateFormatter.string(from: datePickerTimeToBeTaken.date)

    }
    
    
    
    func getTime()-> String
    {
        var dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .none // You can also use Long, Medium and No style.
        dateFormatter.timeStyle = .short

//            var inputDate = dateFormatter.stringFromDate(*datepicker outlet name*.date)
        var inputDate = dateFormatter.string(from: datePickerTimeToBeTaken.date)
        print(inputDate)
        return inputDate
    }
    func getDate()-> String
    {
        var dateFormatter = DateFormatter()
        let date : Date = Date()//todays date
        dateFormatter.dateStyle = .short // You can also use Long, Medium and No style.
        dateFormatter.timeStyle = .none

//            var inputDate = dateFormatter.stringFromDate(*datepicker outlet name*.date)
        var inputDate = dateFormatter.string(from: date)
        print(inputDate)
        return inputDate
    }
    

    
    
    //CORE DATA STUFF
    func addNewPrescription() -> Void
    {
        let newPrescription: Prescribe = Prescribe(context: coreDataContext)//creates new instance of prescribe object
        newPrescription.username = currCTPatient.username
        newPrescription.scheduledTime = getTime()
        newPrescription.medicationName = selectedMedication.name
        newPrescription.imprint = selectedMedication.imprint
        newPrescription.takenTime = "not taken yet"
        
        
        //newPrescription.medicationName =
        //newPrescription.timeTaken = datepickerMedicationRecievingTime
        //newPrescription.imprint =
        
        appDelegate.saveContext()
    }
    func addNewPrescriptionRecord() -> Void
    {
        let newPrescriptionRecord: PrescribeRecord = PrescribeRecord(context:coreDataContext)
        newPrescriptionRecord.imprint = selectedMedication.imprint
        newPrescriptionRecord.username = currCTPatient.username
        newPrescriptionRecord.timeTaken = []
        appDelegate.saveContext()
    }

}
