//
//  addViewController.swift
//  photolog
//
//  Created by Ganesh Prabu on 11/29/17.
//  Copyright © 2017 Ganesh Prabu. All rights reserved.
//

import UIKit

class addViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addimage: UIImageView!
    @IBOutlet weak var addtitletext: UITextField!
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var remove: UIButton!

    var  photolog:Photolog? = nil;
    
    var imageSelector = UIImagePickerController();
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage;
        
        addimage.image = image;
        
        imageSelector.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let context = (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext;

        
        if (photolog == nil) {
            let photolog = Photolog(context: context);
        }
        photolog?.attribute = addtitletext.text;
        photolog?.photo = UIImagePNGRepresentation(addimage.image!);
        (UIApplication.shared.delegate as!  AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func addpiccamera(_ sender: Any) {
        imageSelector.sourceType = .camera;
        present(imageSelector, animated: true, completion: nil)
    
    }
    
    @IBAction func addpicphoto(_ sender: Any) {
        imageSelector.sourceType = .photoLibrary;
        present(imageSelector, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        imageSelector.delegate = self;
        
        if (self.photolog != nil)
        {
            addimage.image = UIImage(data: photolog?.photo as! Data)
            addtitletext.text = photolog?.attribute;
            button.setTitle("Update", for: .normal);
            
        }
        else
        {
            button.setTitle("Add", for: .focused);
            remove.isHidden = true;
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func deletepressed(_ sender: Any) {
        let context = (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext;

        context.delete(photolog!);
        
        (UIApplication.shared.delegate as!  AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
