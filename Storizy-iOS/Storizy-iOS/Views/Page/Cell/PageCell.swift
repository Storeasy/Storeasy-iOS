//
//  PageCell.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/06.
//

import UIKit

class PageCell: UITableViewCell {

    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var pageContentView: UIView!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var pageContentLabel: UILabel!
    @IBOutlet weak var tagCV: UICollectionView!
    
    // data
    var tags: [String] = ["kiki", "보브영원해라"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagCV.delegate = self
        tagCV.dataSource = self
        setUI()
        registerNib()
    }
    
    // nib 등록
    func registerNib(){
        let nibName = UINib(nibName: "PTagCell", bundle: nil)
        tagCV.register(nibName, forCellWithReuseIdentifier: "PTagCell")
    }
    
    func setUI(){
        frameView.layer.cornerRadius = 12
        frameView.layer.borderWidth = 1
        frameView.layer.borderColor = UIColor(named: "light_gray2")?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            pageContentView.backgroundColor = UIColor(named: "extra_white")
        } else {
            pageContentView.backgroundColor = UIColor(named: "extra_white")
        }
    }
    
}

extension PageCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
