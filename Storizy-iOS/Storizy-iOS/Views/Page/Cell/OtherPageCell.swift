//
//  OtherPageCell.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/08.
//

import UIKit

class OtherPageCell: UITableViewCell {

    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var dotImg: UIImageView!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pagePeriodLabel: UILabel!
    @IBOutlet weak var pageContentLabel: UILabel!
    @IBOutlet weak var tagCV: UICollectionView!
    
    var tags: [String] = ["kiki", "보브영원해라"]

    override func awakeFromNib() {
        super.awakeFromNib()
        tagCV.delegate = self
        tagCV.dataSource = self
        setUI()
        registerNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.contentView.backgroundColor = UIColor(named: "extra_white")
        } else {
            self.contentView.backgroundColor = UIColor(named: "extra_white")
        }
    }
    
    // 페이지 좋아요
    @IBAction func likeAction(_ sender: Any) {
    }
    
    // nib 등록
    func registerNib(){
        let nibName = UINib(nibName: "PTagCell", bundle: nil)
        tagCV.register(nibName, forCellWithReuseIdentifier: "PTagCell")
    }
    
    // UI
    func setUI(){
        frameView.layer.cornerRadius = 12
        frameView.layer.borderWidth = 1
        frameView.layer.borderColor = UIColor(named: "light_gray2")?.cgColor
    }
}
extension OtherPageCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PTagCell", for: indexPath) as? PTagCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor(named: "white")
        cell.tagNameLB.text = tags[indexPath.item]
        return cell
    }
    
}
