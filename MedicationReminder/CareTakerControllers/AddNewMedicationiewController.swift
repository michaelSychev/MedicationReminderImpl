//
//  AddNewMedicationiewController.swift
//  MedicationReminder
//
//  Created by Michael Sychev on 11/19/22.
//

import UIKit
import CoreData
class AddNewMedicationiewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //image view for picture of medication
    @IBOutlet weak var imageMedicationImage: UIImageView!

   
    @IBOutlet weak var labelMedicationName: UITextField!
    
    @IBOutlet weak var labelMedicationImprint: UITextField!
    
    @IBOutlet weak var labelMedicationStrength: UITextField!
    
    
    //CAMERA FUNCTION
     @IBAction func buttonAddMedicationImage(_ sender: Any)
    {
        let imagePicker: UIImagePickerController = UIImagePickerController()
        
        imagePicker.delegate = self
        
        
        //check if camera is avaible
        if(UIImagePickerController.isSourceTypeAvailable(.camera))
        {
            imagePicker.sourceType = .camera
            if(UIImagePickerController.isCameraDeviceAvailable(.front))
            {
                imagePicker.cameraDevice = .front
            }
            else
            {
                imagePicker.cameraDevice = .rear
            }
            
        }
        else
        {
            imagePicker.sourceType = .photoLibrary
        }
        self.present(imagePicker, animated:true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        imageMedicationImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion:nil)
    }
    
    //pre:none
    //post:add parameters to core data and clear inputs
    @IBAction func buttonSubmitMedication(_ sender: UIButton)
    {
//        let newImage = Images(context:context)
//        newImage.imageAttribute = imgPicture.image?.pngData
//        appdelegate.saveContext()
        //make sure image is not nill
        if(imageMedicationImage.image == nil)
        {
            let alertController = UIAlertController(title: "EMPTY IMAGE",
                                                            message:"IMAGE IS NOT TAKEN",
                                                            preferredStyle:UIAlertController.Style.alert);
                    
                    alertController.addAction(UIAlertAction(title: "I WILL FILL IN IMAGE",
                                                            style:UIAlertAction.Style.default,
                                                            handler:nil));
                    
                    present(alertController,animated:true,completion:nil);
        }
        else//if image is not nill send data to core data
        {
            addNewMedication(name:labelMedicationName.text!,imprint:labelMedicationImprint.text!, strength:labelMedicationStrength.text!, image:(imageMedicationImage.image?.pngData())! )
            
            //display success
            let alertController = UIAlertController(title: "Medication Submit🫡",
                                                    message:"\(labelMedicationName.text!) has beem submit!",
                                                            preferredStyle:UIAlertController.Style.alert);
                    
                    alertController.addAction(UIAlertAction(title: "OK",
                                                            style:UIAlertAction.Style.default,
                                                            handler:nil));
                    
                    present(alertController,animated:true,completion:nil);
            //clear form
            imageMedicationImage.image = nil
            labelMedicationName.text = ""
            labelMedicationImprint.text = ""
            labelMedicationStrength.text = ""
        }
        
        
    }
    
    //pre:all forms must be filled out
    //post:sends parameters to medication entity in core data
    func addNewMedication(name: String, imprint: String , strength: String, image:Data) -> Void
    {
        let newMedication: Medication = Medication(context: coreDataContext)//creates new instance of Medication object
        newMedication.name = name//id of user
        newMedication.imprint = imprint
        newMedication.strength = strength
        newMedication.image = image
        appDelegate.saveContext()
    }

    
    
    
    
    
    
    
    //send image to coredata
    //let newImage = Images(context:context)
   // newImage.imageAttribute = imgPicture.image?.pngData
    //appdelegate.saveContext()
    //ACCESS IMAGE FROM CORE Data
    /*
     do
     {
       data = try context.fetch(Images.fetchRequest()
    
     imgPicture.image = UIImage(data: data[0].imgAttribute!)
     imgPicture.image = UIImage(data: data[data.count-1].imgAttribute!)

     
     }
     */
}
