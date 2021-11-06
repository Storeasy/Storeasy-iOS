//
//  HomeVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/05.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var feedTableViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "ProjectCell", bundle: nil)
        feedTableView.register(nibName, forCellReuseIdentifier: "projectCell")
        
        DispatchQueue.main.async {
            self.feedTableViewHeight.constant = self.feedTableView.contentSize.height
        }

        //최초시작
        if UserDefaults.standard.string(forKey: "firstLoad") == nil {
            print("최초시작")
            UserDefaults.standard.setValue("false", forKey: "firstLoad")
            // 온보딩
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let onboardingVC = storyboard.instantiateViewController(identifier: "OnboardingVC") as! OnboardingVC
            onboardingVC.modalPresentationStyle = .popover
            present(onboardingVC, animated: true, completion: nil)
        }
        
        //!최초시작
        
        
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectCell
        cell.label.text = "project~"
        
        return cell
    }
    
    
}
