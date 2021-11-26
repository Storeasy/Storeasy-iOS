//
//  ProjectDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/06.
//

import UIKit

class ProjectDetailVC: UIViewController {
    // components
    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var dotImage: UIImageView!
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var projectPeriodLabel: UILabel!
    @IBOutlet weak var projectContentTextView: UITextView!
    @IBOutlet weak var projectTagCV: UICollectionView!
    @IBOutlet weak var pageTableView: UITableView!
    @IBOutlet weak var projectMoreBtn: UIButton!
    @IBOutlet weak var projectView: UIView!
    @IBOutlet weak var contentTVHeight: NSLayoutConstraint!
    
    @IBOutlet weak var projectInsideFrameView: UIView!
    
    var storyTags: [String] = ["IT", "개발", "iOS", "안녕하세요태그인데요", "예선진출", "경축", "많관부"]

    var projectId: Int = 0
    var projectDetail: ProjectDetail?
    var project: Project?
    var pages: [PageInProject] = [] {
        didSet {
            pageTableView.reloadData()
        }
    }
    var projectTags: [TagData] = [] {
        didSet{
            projectTagCV.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileDetail()
        registerNib()   // nib 등록
        moreAction()    // more btn menu setting
        setUI()         // UI
    }
    
    // 프로젝트 상세 조회 API
    func getProfileDetail(){
        GetProjectDetailService.shared.getProjectDetail(accessToken: accessToken, projectId: projectId) { (responseCode, responseBody) in
            if responseCode == .success {
                guard let body = responseBody as? ProjectDetail else { print("return!"); return }
                print(body)
                self.project = body.project
                self.pages = body.pages
//                self.pageTableView.reloadData()
                self.loadProjectData()
                self.setUI()
            } else {
                print(responseCode)
            }
        }
    }
    
    // 뷰에 데이터 채우기
    func loadProjectData(){
        dotImage.image = UIImage(named: "\(project?.projectColor ?? "tag_green")_project")
        projectTitleLabel.text = project?.title
        projectPeriodLabel.text = "\(project!.startDate!) - \(project!.endDate!)"
        projectTags = project!.tags
        projectContentTextView.text = project?.description
        
    }
    
    func moreAction(){
        projectMoreBtn.showsMenuAsPrimaryAction = true
        // 수정하기 메뉴 아이템
        let edit = UIAction(title: "수정하기", image: nil) { _ in
            // 수정하기 뷰 띄우기
            let storyboard = UIStoryboard(name: "EditProject", bundle: nil)
            let editProjectVC = storyboard.instantiateViewController(identifier: "EditProjectVC")
            self.navigationController?.pushViewController(editProjectVC, animated: true)
        }
        
        let delete = UIAction(title: "삭제하기", image: nil) { _ in
            // 삭제하기
        }
        
        let cancel = UIAction(title: "취소", attributes: .destructive) { _ in }
        
        projectMoreBtn.menu = UIMenu(title: "project menu", image: nil, identifier: nil, options: .displayInline, children: [edit, delete, cancel])
    }
    
    // 닫기
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // nib 등록
    func registerNib(){
        let nibName = UINib(nibName: "PageCell", bundle: nil)
        pageTableView.register(nibName, forCellReuseIdentifier: "PageCell")
        
        let tagNibName = UINib(nibName: "PTagCell", bundle: nil)
        projectTagCV.register(tagNibName, forCellWithReuseIdentifier: "PTagCell")
    }
    
    
    // MARK: - UI
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        
        // 프로젝트 뷰 둥글
        projectInsideFrameView.layer.cornerRadius = 12
        
        // 프로젝트 뷰 높이
        DispatchQueue.main.async {
            self.contentTVHeight.constant = self.projectContentTextView.contentSize.height
        }
    }
    
}


// MARK: - table view
extension ProjectDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PageCell", for: indexPath) as? PageCell {
            cell.pageTitleLabel.text = pages[indexPath.row].title
            cell.periodLabel.text = "\(pages[indexPath.row].startDate!) - \(pages[indexPath.row].endDate!)"
            cell.pageContentLabel.text = pages[indexPath.row].content
            cell.tags = pages[indexPath.row].tags
            cell.dotImage.image = UIImage(named: "\(project!.projectColor!)_page")
            return cell
        }
        return UITableViewCell()
    }
    
    // 페이지 셀 선택
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 페이지 아이디 전달
        //페이지 상세 이동
        let storyboard = UIStoryboard(name: "PageDetail", bundle: nil )
        guard let pageDatailVC = storyboard.instantiateViewController(identifier: "PageDetailVC") as? PageDetailVC else { return }
        pageDatailVC.pageId = pages[indexPath.row].pageId!

        self.navigationController?.pushViewController(pageDatailVC, animated: true)
    }
    
    
}

// MARK: - Collection View
extension ProjectDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projectTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PTagCell", for: indexPath) as? PTagCell else { return UICollectionViewCell() }
        cell.tagNameLB.text = "#\(projectTags[indexPath.item].tagName!)"
        cell.frameView.backgroundColor = UIColor(named:"extra_white")
        cell.tagNameLB.textColor = UIColor(named: "\(projectTags[indexPath.item].tagColor!)")
        return cell
    }
    
    
}
