//
//  MemeViewController.swift
//  DemoApi
//
//  Created by Hoàng Chí Nhân on 21/06/2022.
//

import UIKit


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping (Data) -> Void) {
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(data)
//            let image = UIImage(data: data!)
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
            DispatchQueue.main.async() {
                completion(data!)
            }
        }.resume()
    }
//    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        downloaded(from: url, contentMode: mode)
//    }
}
class MemeViewController: UIViewController {

    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memeImg: UIImageView!
    
    var memess: Meme?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        nameLabel.text = memess?.name
        urlLabel.text = memess?.url
        //nameLabel.text = memess?.data.memes.init(name: String)
        
        // Do any additional setup after loading the view.
        let imgUrl = memess!.url
        guard let url = URL(string: imgUrl) else { return }
        print(imgUrl)
        self.memeImg.downloaded(from: url) { [weak self] imageData in
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                
                self?.memeImg.image = image
            }
            
        }
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
