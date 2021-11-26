//
//  OtherProjectDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/09.
//

import UIKit

class OtherProjectDetailVC: UIViewController {

    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var projectBarView: UIView!
    @IBOutlet weak var projectFrameView: UIView!
    @IBOutlet weak var pageTableView: UITableView!
    @IBOutlet weak var contentTV: UITextView!
    @IBOutlet weak var contentTVHeight: NSLayoutConstraint!
    @IBOutlet weak var tagCV: UICollectionView!
    
    var pages: [Page] = []
    var storyTags: [String] = ["IT", "개발", "iOS", "안녕하세요태그인데요", "예선진출", "경축", "많관부"]

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        setUI()
        
    }
    
    // 닫기
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // nib 등록
    func registerNib(){
        
        let tagNibName = UINib(nibName: "PTagCell", bundle: nil)
        tagCV.register(tagNibName, forCellWithReuseIdentifier: "PTagCell")
        
        let nibName = UINib(nibName: "OtherPageCell", bundle: nil)
        pageTableView.register(nibName, forCellReuseIdentifier: "OtherPageCell")
        
    }
    
    // UI
    func setUI(){
        // 프로젝트 뷰 높이
        DispatchQueue.main.async {
            self.contentTVHeight.constant = self.contentTV.contentSize.height
        }
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        // 프로젝트 뷰 둥글
        projectFrameView.layer.cornerRadius = 12
        
    }
    
}

// MARK: - page table view
extension OtherProjectDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherPageCell", for: indexPath) as! OtherPageCell
        // ui
        if indexPath.row == pages.count - 1 {
            cell.bottomBar.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "OtherPageDetail", bundle: nil)
        let otherPageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC")
        self.navigationController?.pushViewController(otherPageDetailVC, animated: true)
    }
    
}

// MARK: - project tag Collection View
extension OtherProjectDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PTagCell", for: indexPath) as? PTagCell else { return UICollectionViewCell() }
        cell.tagNameLB.text = storyTags[indexPath.item]
        cell.frameView.backgroundColor = UIColor(named: "tag_pink-light")
        cell.tagNameLB.textColor = UIColor(named: "tag_pink")
        return cell
    }
    
    
}

