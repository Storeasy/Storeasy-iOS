//
//  ProjectCell.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/03.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var insideFrameView: UIView!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var dotImage: UIImageView!
    
    @IBOutlet weak var projectContentView: UIView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var projectContentLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var tagCV: UICollectionView!
    
    var tags: [TagData?] = []
    
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
    
    // UI Set
    func setUI(){
        insideFrameView.layer.cornerRadius = 12
        dotView.layer.cornerRadius = 10
        dotView.layer.zPosition = 2
        tagCV.backgroundColor = UIColor(named: "white")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            projectContentView.backgroundColor = UIColor(named: "extra_white")
        } else {
            projectContentView.backgroundColor = UIColor(named: "extra_white")
        }
    }
    
    @IBAction func moreAction(_ sender: Any) {
        
    }
    
}

extension ProjectCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PTagCell", for: indexPath) as? PTagCell else {
            return UICollectionViewCell()
        }
        let tag = tags[indexPath.item]
        cell.tagNameLB.text = "#\(tag?.tagName ?? "")"
        cell.tagNameLB.textColor = UIColor(named: tag?.tagColor ?? "black")
        cell.frameView.backgroundColor = UIColor(named: "extra_white")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.cellForItem(at: indexPath)?.bounds.width ?? 70
        let height = tagCV.bounds.height
        return CGSize(width: width, height: height)
    }
    
}
