//
//  HeartUserCell.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

class HeartUserCell: UITableViewCell {
    

    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var univNameLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tags: [String] = ["개발", "iOS", "Server"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nibName = UINib(nibName: "ProfileTagCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "ProfileTagCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUI(){
        profileImg.layer.cornerRadius = profileImg.bounds.height / 2
    }
    
}

extension HeartUserCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileTagCell", for: indexPath) as! ProfileTagCell
        cell.tagNameLabel.text = tags[indexPath.item]
        return cell
    }
    
}
