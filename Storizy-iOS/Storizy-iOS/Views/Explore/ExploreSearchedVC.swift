//
//  ExploreSearchedVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/09.
//

import UIKit

class ExploreSearchedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pages: [Page] = [Page(title: "프로젝트1")]
    var users: [User] = [User(name: "임수정"), User(name: "유기현")]
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
    
    
}
