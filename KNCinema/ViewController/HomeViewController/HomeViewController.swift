//
//  HomeViewController.swift
//  KNCinema
//
//  Created by kienND9 on 6/19/17.
//  Copyright © 2017 ABC. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: BaseViewController {

    @IBOutlet weak var listMovieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listMovieTableView.delegate = self
        listMovieTableView.dataSource = self
        listMovieTableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        // Do any additional setup after loading the view.
        loadData()
    }

    func loadData() {
        let ref = self.fireBaseRef.child("Movies").observeSingleEvent(of: .value, with: {(snapshot: FIRDataSnapshot) in
            if let listTypeMovies: [FIRDataSnapshot] = snapshot.children.allObjects as! [FIRDataSnapshot]{
                print(listTypeMovies)
                
                for index in listTypeMovies{
                    let refMovie = self.fireBaseRef.child("Movies").child(index.key).observeSingleEvent(of: .value, with: {(snap: FIRDataSnapshot) in
                        if let listMovie: [FIRDataSnapshot] = snap.children.allObjects as? [FIRDataSnapshot]{
                            print(listMovie)
                        }
                    })
                }
            }
        })
        print(ref)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            var height: CGFloat = 0
            if isIpad(){
                height = 200
            }
            else{
                height = 150
            }
            let view = HeaderHomeView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: height))
            
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            if isIpad(){
                return 200
            }
            else{
                return 150
            }

        }
        //print(tableView.sectionHeaderHeight)
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
