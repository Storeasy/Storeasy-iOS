//
//  TagSelectVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/25.
//

import UIKit
import TTGTagCollectionView

class TagSelectVC: UIViewController {

    @IBOutlet weak var headBarView: UIView!
    @IBOutlet weak var tagTF: UITextField!
    @IBOutlet weak var addTagBTN: UIButton!
    @IBOutlet weak var startBTN: UIButton!
    var tagCV =  TTGTextTagCollectionView()
    var selectedTagIds: [Int] = []
    
    var tags: [TagData] = [] {
        didSet {
            setTagCV()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTagList()
        setUI()
        print(accessToken)
    }
    
    @IBAction func finishAction(_ sender: Any) {
        generateSelectedTagIds()
    }
    
    func setTagCV(){

        tagCV = TTGTextTagCollectionView.init(frame: CGRect.init(x: 30 , y: self.headBarView.bounds.maxY + 20, width: view.bounds.width - 60, height: 300))
        tagCV.numberOfLines = 4
        tagCV.enableTagSelection = true
        tagCV.selectionLimit = 3
        tagCV.alignment = .fillByExpandingWidthExceptLastLine
        tagCV.horizontalSpacing = CGFloat(12)
        tagCV.verticalSpacing = CGFloat(12)

        self.view.addSubview(tagCV)
        
        for tag in tags {
            if (tag.id == 5) { continue }
            let content = TTGTextTagStringContent.init(text: tag.tagName!)
            content.textColor = UIColor(named: "black") ?? UIColor.black
            content.textFont = UIFont.systemFont(ofSize: 14)
            
            let normalStyle = TTGTextTagStyle.init()
            normalStyle.backgroundColor = UIColor(named: "extra_white") ?? UIColor.white
            normalStyle.extraSpace = CGSize.init(width: 30, height: 10)
            normalStyle.shadowOpacity = 0
            normalStyle.cornerRadius = 30
            normalStyle.borderWidth = 1
            normalStyle.borderColor = UIColor(named: "light_gray2")!
            
            
            let selectedContent = TTGTextTagStringContent.init(text: tag.tagName!)
            selectedContent.textColor = UIColor(named: "extra_white") ?? UIColor.white
            selectedContent.textFont = UIFont.systemFont(ofSize: 14)
            
            let selectedStyle = TTGTextTagStyle.init()
            selectedStyle.backgroundColor = UIColor(named: "lasing_green") ?? UIColor.green
            selectedStyle.extraSpace = CGSize.init(width: 30, height: 10)
            selectedStyle.shadowOpacity = 0
            selectedStyle.cornerRadius = 30
            selectedStyle.borderWidth = 0

            let tag = TTGTextTag.init()
            tag.content = content
            tag.style = normalStyle
            tag.selectedStyle = selectedStyle
            tag.selectedContent = selectedContent
            tagCV.addTag(tag)
        }
        tagCV.reload()

    }
    
    func getTagList(){
        TagListReadService.shared.getTagList(accessToken: accessToken) { rcode, rbody in
            if rcode == .success {
                guard let body = rbody as? ResponseData<[TagData]> else { return }
                self.tags = body.data ?? []
//                print(body.data)
            } else {
                print("errr\(rbody)")
            }
        }
    }
    
    // 완료 버튼 클릭
    // 선택 태그 전송
    func generateSelectedTagIds(){
        var tagIds: [Int] = []
        for tag in tagCV.allSelectedTags() {
            tagIds.append( ( tags[Int(tag.tagId)+1].id ?? 1 ) )
        }
        selectedTagIds = tagIds
        print(selectedTagIds)
        postSelectedTag()
    }
    
    // 태그 저장 요청 전송
    func postSelectedTag(){
        PostProfileTagsService.shared.postProfileTags(accessToken: accessToken, tagIds: selectedTagIds) { rcode, rbody in
            if rcode == .success {
                print(rcode, rbody)
                // 최초X 저장
                UserDefaults.standard.setValue("false", forKey: "firstLoad")
                //성공시 탭바C으로 이동
                let tabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
                let tabBarController = tabBarStoryboard.instantiateViewController(identifier: "TabBarController")
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true, completion: nil)
                
            } else {
                print(rcode, rbody)
            }
        }
    }
    
    // MARK: - UI
    // TF, 이전 BNT
    func borderUI<T: UIView>(_ view: T){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "light_gray2")?.cgColor
    }
    
    // TF, BTNs
    func roundUI<T: UIView>(_ view: T){
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
    }
    
    func setUI(){
        // 헤더 그림자
        headBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headBarView.layer.shadowRadius = 6
        headBarView.layer.shadowOpacity = 1
        headBarView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        // BTN
        roundUI(startBTN)
        
    }
    


}
