//
//  ViewController.swift
//  Project1-3MS_100days
//
//  Created by user226947 on 12/14/22.
//

import UIKit



class ViewController: UITableViewController {

        var picturesHR = [String]()
        var picturesLR = [String]()

        override func viewDidLoad() {
            super.viewDidLoad()
        
            navigationController?.navigationBar.prefersLargeTitles = true
            title = "Flags and Countries"
            
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasSuffix(".png"){
                    if item.split(separator: "_")[1] == "hd" {
                        picturesHR.append(item)
                    } else if item.split(separator: "_")[1] == "sd" {
                        picturesLR.append(item)
                    }
                }
            }
                
        
            picturesHR = sortByCountryName(picturesHR)
            picturesLR = sortByCountryName(picturesLR)
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return picturesLR.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Flags", for: indexPath) as! CellWithFlag
            
            cell.flagTextLabel?.text = countryName(picturesLR[indexPath.row])
            cell.flagImageView?.image = UIImage(named: picturesLR[indexPath.row])
            cell.flagImageView?.layer.borderColor = UIColor.gray.cgColor
            cell.flagImageView?.layer.borderWidth = 0.3
            
            return cell
        }
        

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                vc.countryselected = indexPath.row
                vc.picturesHR = picturesHR
                navigationController?.pushViewController(vc, animated: true)
            }
        }
     

    func sortByCountryName(_ flags: [String]) -> [String] {
        return flags.sorted(by: {countryName($0) < countryName($1)
        })
    }
    func countryName(_ flags: String) -> String {
        return countryCodes[flags.split(separator: "_")[2].split(separator: ".")[0].uppercased(), default: "No country found"]
        
    }
    
}

class CellWithFlag: UITableViewCell {
    @IBOutlet var flagImageView: UIImageView!
    @IBOutlet var flagTextLabel: UILabel!
}
