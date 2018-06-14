//
//  SecondViewController.swift
//  Swifty_companion
//
//  Created by Audrey ROEMER on 4/12/18.
//  Copyright © 2018 Audrey ROEMER. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var coalitionLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var cususLabel: UILabel!
    @IBOutlet weak var correctionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var cursusPicker: UIPickerView! {
        didSet {
            cursusPicker.delegate = self
            cursusPicker.dataSource = self
        }
    }
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView! {
        didSet {
            levelProgress.transform = levelProgress.transform.scaledBy(x: 1, y: 3)

        }
    }
    @IBOutlet weak var skillsMainLabel: UILabel!
    @IBOutlet weak var SkillTableView: UITableView! {
        didSet {
            SkillTableView.dataSource = self
            self.SkillTableView?.rowHeight = 40.0
        }
    }
    @IBOutlet weak var projectsMainLabel: UILabel!
    @IBOutlet weak var ProjectTableView: UITableView! {
        didSet {
            ProjectTableView.dataSource = self
            self.ProjectTableView?.rowHeight = 40.0
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    var user: User?
    var coa: [Coalition]?
    var cursus: [(Int, String)] = []
    var cursus_id: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: (user?.imageUrl)!) {
            downloadImage(url: url)
        }
        if let coaSlug = coa?.first?.slug {
            backgroundImage.image = UIImage(named: coaSlug)
        }
        fillUserInfo()
        skillsMainLabel.textColor = coa?.first?.color.hexColor
        projectsMainLabel.textColor = coa?.first?.color.hexColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillUserInfo()
    {
        guard let user = user else {return }
        for curs in user.cursusUser
        {
            cursus.append((curs.cursus.id, curs.cursus.name))
        }
        displayNameLabel.text = user.displayname
        loginLabel.text = user.login
        phoneLabel.text = user.phone ?? "Unknown"
        mailLabel.text = user.email
        walletLabel.text = "\(user.wallet) ₳"
        gradeLabel.text = user.cursusUser.first?.grade
        correctionLabel.text = "\(user.correctionPoints)"
        if let coa = coa?.first {
            coalitionLabel.text = coa.name
        }
        if let location = user.location
        {
            locationLabel.text = "Available\n\(location)"
        }
        else
        {
            locationLabel.text = "Unavailable"
        }
        if let level = user.cursusUser.first?.level
        {
            levelLabel.text = floatToSring(level: level)
            levelProgress.progress = floatToPercent(level: level)
            if let coa = coa?.first {
                levelProgress.progressTintColor = coa.color.hexColor
            }
        }
    }
    
    func floatToSring(level: Float) -> String
    {
        let levelString = String(level)
        let array = levelString.components(separatedBy: ".")
        let levelInt = array[0]
        var levelPercent = array[1]
        if levelPercent.count == 1
        {
            levelPercent += "0"
        }
        return "Level \(levelInt) - \(levelPercent)%"
    }
    
    func floatToPercent(level: Float) -> Float
    {
        let x: Int = Int(level)
        let levelPercent = level - Float(x)
        return levelPercent
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.userPicture.image = UIImage(data: data)
                self.userPicture.layer.borderWidth = 2
                self.userPicture.layer.masksToBounds = false
                self.userPicture.layer.borderColor = UIColor.white.cgColor
                self.userPicture.layer.cornerRadius = self.userPicture.frame.size.width / 2
                self.userPicture.clipsToBounds = true
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cursus.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.textAlignment = .right
        }
        pickerLabel?.text = cursus[row].1
        pickerLabel?.font = UIFont.systemFont(ofSize: 13.0)
        pickerLabel?.textColor = UIColor.white
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        guard let selected = user?.cursusUser.first(where: { $0.cursus.name == cursus[row].1}) else {return }
        gradeLabel.text = selected.grade
        levelLabel.text = floatToSring(level: selected.level)
        levelProgress.progress = floatToPercent(level: selected.level)
        cursus_id = cursus[row].0
        SkillTableView.reloadData()
        ProjectTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count: Int?
        
        if tableView == self.SkillTableView {
            count = user!.cursusUser.first(where: { $0.cursus.id == cursus_id})?.skills.count
        }
        
        if tableView == self.ProjectTableView {
            count = user!.projectsUser.filter { $0.cursus_ids.first == cursus_id && $0.status == "finished" && $0.project.parent_id == nil}.count
        }
        if (count == nil) {
            count = 0
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if tableView == self.SkillTableView {
            let scell = SkillTableView.dequeueReusableCell(withIdentifier: "SkillCell") as! SkillTableViewCell
            if let skillSelected = user!.cursusUser.first(where: { $0.cursus.id == cursus_id}) {
            scell.skillLabel.text = "\(String(describing: skillSelected.skills[indexPath.row].name))"
            scell.skillLevelLabel.text = "level \(String(describing: skillSelected.skills[indexPath.row].level))"
            scell.skillProgress.progress = floatToPercent(level: (skillSelected.skills[indexPath.row].level))
            if let coa = self.coa?.first
            {
                scell.skillProgress.progressTintColor = coa.color.hexColor
            }
            cell = scell
            }
        }
        
        if tableView == self.ProjectTableView {
            let newArray = user!.projectsUser.filter { $0.cursus_ids.first == cursus_id && $0.status == "finished" && $0.project.parent_id == nil}
            let pcell = ProjectTableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectTableViewCell
            pcell.projectNameLabel.text = newArray[indexPath.row].project.name
            if newArray[indexPath.row].validated == true {
                pcell.projectValidatedImage.image = UIImage(named: "checkmark")
            }
            else {
                pcell.projectValidatedImage.image = UIImage(named: "failed")
            }
            if (newArray[indexPath.row].final_mark != nil)
            {
                pcell.projectGradeLabel.text = String(describing: newArray[indexPath.row].final_mark!)
            }
            else
            {
                pcell.projectGradeLabel.text = "No grade"
            }
            cell = pcell
        }
        return cell!
    }
}

extension String {
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

