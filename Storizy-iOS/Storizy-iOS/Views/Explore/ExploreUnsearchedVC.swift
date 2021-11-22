//
//  ExploreUnsearchedVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/09.
//

import UIKit

class ExploreUnsearchedVC: UIViewController {
    
    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var recommPages: [Page] = [Page(title: "추천 페이지 1"), Page(title: "추천페이지 2"), Page(title: "추천 페이지 3"), Page(title: "추천페이지 4"), Page(title: "추천페이지 5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()   // nib 등록
        setUI()         // UI

    }
    
    // 검색 바 클릭
    @IBAction func searchBarBtnAction(_ sender: Any) {
        let exploreSearchedVC = self.storyboard?.instantiateViewController(identifier: "ExploreSearchedVC") as! ExploreSearchedVC
        self.navigationController?.pushViewController(exploreSearchedVC, animated: false)
    }
    
    // nib 등록
    func registerNib(){
        let nibName = UINib(nibName: "HeartPageCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HeartPageCell")
    }
    
    // ui
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        
        // table view - scroll view
        DispatchQueue.main.async {
            self.tableViewHeight.constant = self.tableView.contentSize.height
        }
    }

}


extension ExploreUnsearchedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeartPageCell") as! HeartPageCell
        return cell
    }
    
    // 셀 선택 시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "OtherPageDetail", bundle: nil)
        let otherPageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC")
        self.navigationController?.pushViewController(otherPageDetailVC, animated: true)
    }
}
