//
//  ViewController.swift
//  photolog
//
//  Created by Ganesh Prabu on 11/29/17.
//  Copyright © 2017 Ganesh Prabu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var photologs: [Photolog] = [];
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photologs.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        let photolog = photologs[indexPath.row ];
        cell.textLabel?.text = photolog.attribute;
        cell.imageView?.image = UIImage(data: photolog.photo as! Data);
        return cell;
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photolog = photologs[indexPath.row ];
        performSegue(withIdentifier: "photoSegue", sender: photolog);
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! addViewController;
        nextVC.photolog = sender as? Photolog;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableview.delegate = self
        tableview.dataSource = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext;
        do
        {
            photologs = try context.fetch(Photolog.fetchRequest())
            tableview.reloadData();
        } catch {
            
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

