//
//  OtherProjectDetailVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/09.
//

import UIKit

class OtherProjectDetailVC: UIViewController {

    @IBOutlet weak var pageTableView: UITableView!
    @IBOutlet weak var projectViewHeight: NSLayoutConstraint!
    @IBOutlet weak var projectContentTextView: UITextView!
    
    var pages: [Page] = [Page(title: "페이지 이름11"), Page(title: "페이지 이름22")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "OtherPageCellInProject", bundle: nil)
        pageTableView.register(nibName, forCellReuseIdentifier: "OtherPageCellInProject")
        
        // 프로젝트 뷰 높이
        DispatchQueue.main.async {
            self.projectViewHeight.constant = 125.5 + self.projectContentTextView.contentSize.height
        }

    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OtherProjectDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherPageCellInProject", for: indexPath) as! OtherPageCellInProject
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "OtherPageDetail", bundle: nil)
        let otherPageDetailVC = storyboard.instantiateViewController(identifier: "OtherPageDetailVC")
        self.navigationController?.pushViewController(otherPageDetailVC, animated: true)
    }
    
}
