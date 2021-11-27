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
    @IBOutlet weak var projectTitleLB: UILabel!
    @IBOutlet weak var periodLB: UILabel!
    @IBOutlet weak var contentTV: UITextView!
    @IBOutlet weak var contentTVHeight: NSLayoutConstraint!
    @IBOutlet weak var tagCV: UICollectionView!
    @IBOutlet weak var dotImage: UIImageView!
    
    var projectId: Int = 0
    var project: Project?
    var pages: [PageInProject] = [] {
        didSet {
            pageTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        setUI()
        getProjectDetail()
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
    
    // 프로젝트 데이터 채우기
    func loadProject(){
        dotImage.image = UIImage(named: "tag_black_project")
        projectTitleLB.text = project?.title
        periodLB.text = "\(project!.startDate ?? "") - \(project!.endDate ?? "")"
        contentTV.text = project?.description
    }
    
    
    // API 호출
    func getProjectDetail(){
        GetProjectDetailService.shared.getProjectDetail(accessToken: accessToken, projectId: projectId) { (responseCode, responseBody) in
            if responseCode == .success {
                guard let body = responseBody as? ProjectDetail else { print("return!"); return }
                print(body)
                self.project = body.project
                self.pages = body.pages
                self.loadProject()
                self.setUI()
            } else {
                print(responseCode)
            }
        }
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
        cell.pageTitleLabel.text = pages[indexPath.row].title
        cell.pagePeriodLabel.text = "\(pages[indexPath.row].startDate ?? "") - \(pages[indexPath.row].endDate ?? "")"
        cell.pageContentLabel.text = pages[indexPath.row].content
        cell.tags = pages[indexPath.row].tags
        cell.dotImg.image = UIImage(named: "tag_black_page")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "OtherPageDetail", bundle: nil)
        guard let otherPageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC") as? OtherPageDetailVC else { return }
        otherPageDetailVC.pageId = pages[indexPath.row].pageId ?? 0
        self.navigationController?.pushViewController(otherPageDetailVC, animated: true)
    }
    
}

// MARK: - project tag Collection View
extension OtherProjectDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return project?.tags.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PTagCell", for: indexPath) as? PTagCell else { return UICollectionViewCell() }
        let tag = project?.tags[indexPath.item]
        cell.tagNameLB.text = tag?.tagName
        cell.frameView.backgroundColor = UIColor(named: "extra_white")
        cell.tagNameLB.textColor = UIColor(named: "black")
        return cell
    }
    
    
}

