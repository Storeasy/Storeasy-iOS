//
//  ExploreSearchedVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/09.
//

import UIKit

class ExploreSearchedVC: UIViewController {

    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var pages: [Page] = []
    var users: [User] = []
    var currentDatas: [Any] = []
    
    var type: Int? {
        didSet{
            // type 변경 시
            if type == PAGE {
                currentDatas = pages
            } else {
                currentDatas = users
            }
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 페이지가 default
        type = PAGE
        
        registerNib()
        setUI()
    }
    
    // nib 등록
    func registerNib(){
        // 셀 등록
        let pageNibName = UINib(nibName: "HeartPageCell", bundle: nil)
        tableView.register(pageNibName, forCellReuseIdentifier: "HeartPageCell")
        let userNibName = UINib(nibName: "HeartUserCell", bundle: nil)
        tableView.register(userNibName, forCellReuseIdentifier: "HeartUserCell")
    }
    
    // type 변경
    @IBAction func segmentedDidChange(_ sender: UISegmentedControl) {
        type = sender.selectedSegmentIndex
    }
    
    // ui
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor    }
    
}

extension ExploreSearchedVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
    }
    
    
}

extension ExploreSearchedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 페이지
        if type == PAGE {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeartPageCell", for: indexPath) as! HeartPageCell
            return cell
        }
        
        // 사용자
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeartUserCell", for: indexPath) as! HeartUserCell
            cell.heartBtn.isHidden = true
            cell.usernameLabel.text = users[indexPath.item].name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // 페이지
        if type == PAGE {
            let storyboard = UIStoryboard(name: "OtherPageDetail", bundle: nil)
            let otherPageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC")
            self.navigationController?.pushViewController(otherPageDetailVC, animated: true)
        }
        
        // 사용자
        else {
            let storyboard = UIStoryboard(name: "OtherHome", bundle: nil)
            let otherHomeVC = storyboard.instantiateViewController(identifier: "OtherHomeVC")
            self.navigationController?.pushViewController(otherHomeVC, animated: true)
        }
    }
    
    
}
