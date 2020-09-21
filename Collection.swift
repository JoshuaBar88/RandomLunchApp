//
//  Collection.swift
//  APIptmilli
//
//  Created by Joshua Barnett on 6/10/20.
//  Copyright © 2020 Joshua Barnett. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

struct Image: Codable{
    let images: Picture
}
struct Picture: Codable{
    let thumbnail: Size
}
struct Size: Codable{
    let url: URL
}


struct Restaurants: Codable{
    let address: String?
    var name: String?
    let rating: String?
    let price_level: String?
    let phone: String?
    let photo: Image?
    let description: String?
}

class Collection: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var finalUrlll = String()
    var users = [Restaurants]()
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCollection.self, forCellWithReuseIdentifier: "customCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 40).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let headers = [
                "x-rapidapi-host": "tripadvisor1.p.rapidapi.com",
                "x-rapidapi-key": "4ebd995e9emsh33ff3c0981ef85cp1de2c5jsn1091d896c9b3"
            ]
        
        let request = NSMutableURLRequest(url: NSURL(string: finalUrlll)! as URL,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 30.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response,error) -> Void in
                if (error == nil) {
                    do{
                        let dictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                        let datab = dictionary!.object(forKey: "data") as? [[String:AnyObject]]
                        let me = try? JSONSerialization.data(withJSONObject: datab as Any, options: [])
                        self.users = try JSONDecoder().decode([Restaurants].self, from: me!)
                        //var blass = Collection()
                        //blass.getStruct(place: users)
                        //print(datab)
                        //print(dictionary)
                        //print(self.users)
                        //print(self.users.count)
                    }catch {
                        print("dfnboiusn")
                    }
                    
                }
            
                    
                    
                     
                     
                

        })
        dataTask.resume()
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCollection
        //print(users[indexPath.row].name!)
        
        cell.backgroundColor = .red

        cell.users = self.
        //cell.pic.contentMode = .scaleAspectFit
        //cell.pic.downloaded(from: (users[indexPath.row].photo?.images.thumbnail.url)!)
        
        
        return cell
    }
    

}
class CustomCollection: UICollectionViewCell{
    
    var users: Restaurants? {
        didSet{
            guard let users = users else{ return }
            name.text = users.name
        }
    }
    fileprivate let name: UILabel = {
        let myMeat = UILabel()
        myMeat.translatesAutoresizingMaskIntoConstraints = false
        myMeat.clipsToBounds = true
        //myMeat.font = UIFont(name: Plain, size: 20)
        //myMeat.
        return myMeat
    }()
    
    
    
   override init(frame: CGRect){
    super.init(frame: .zero)
        contentView.addSubview(name)
    name.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    name.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
    name.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
