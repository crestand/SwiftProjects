//
//  ViewController.swift
//  ImageViewer
//
//  Created by Hamza Eren Koc on 22.04.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recomendApp))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.imageCount = pictures.count
            vc.imageIndex = indexPath.row + 1
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func recomendApp() {
        let textToShare = "Check out this app!"
        
        if let appURL = NSURL(string: "https://www.google.com") { //write app's link
            let objectsToShare = [textToShare, appURL] as [Any]
            let vc = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
        }
        
    }

}

