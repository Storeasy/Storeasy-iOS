//
//  HeartUserCell.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

class HeartUserCell: UITableViewCell {
    

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var univNameLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heartBTN: UIButton!
    
    var tags: [TagData] = []
    {
        didSet {
            collectionView.reloadData()
        }
    }
    var isLiked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        setUI()
        let nibName = UINib(nibName: "ProfileTagCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "ProfileTagCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.contentView.backgroundColor = UIColor(named: "extra_white")
        } else {
            self.contentView.backgroundColor = UIColor(named: "extra_white")
        }
    }
    
    @IBAction func heartAction(_ sender: Any) {
        self.isLiked.toggle()
        DispatchQueue.main.async {
            self.heartBTN.imageView?.image =
                self.isLiked ? UIImage(named: "favorite") : UIImage(named: "favorite_un")
        }
    }
    
    func setUI(){
        profileImg.layer.cornerRadius = profileImg.bounds.height / 2
    }
    
}

extension HeartUserCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileTagCell", for: indexPath) as! ProfileTagCell
        cell.tagNameLabel.text = tags[indexPath.item].tagName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.cellForItem(at: indexPath)?.bounds.width ?? 70
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
}
