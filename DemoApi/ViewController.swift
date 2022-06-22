//
//  ViewController.swift
//  DemoApi
//
//  Created by Hoàng Chí Nhân on 21/06/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var meme: Status?
    let cellId = "Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        downloadJSON {
                   self.tableView.reloadData()
                   print("success")
               }
               
    }
    func downloadJSON(completed: @escaping () -> ()) {
            let url = URL(string: "https://api.imgflip.com/get_memes")
            
            URLSession.shared.dataTask(with: url!) { data, response, err in
                
                if err == nil {
                    do {
                        self.meme = try JSONDecoder().decode(Status.self, from: data!)
                        DispatchQueue.main.async {
                            completed()
                        }
                    }
                    catch {
                        print("error fetching data from api")
                    }
                }
            }.resume()
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meme?.data.memes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        let imageName = meme?.data.memes[indexPath.row].name
        cell?.textLabel?.text = imageName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell: \(String(describing: meme?.data.memes[indexPath.row]))")
        //performSegue(withIdentifier: "showDetails", sender: self)
//        let identifier = String(describing: type(of: MemeViewController.Type))
        let vc = storyboard?.instantiateViewController(identifier: "MemeViewController") as! MemeViewController
        vc.memess =  meme?.data.memes[indexPath.row]
//        self.performSegue(withIdentifier: "meme", sender: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? MemeViewController {
                destination.memess = meme?.data.memes[tableView.indexPathForSelectedRow!.row]
            }
        }
}

