//
//  EditProfileVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/10.
//

import UIKit

let accessToken = "Bearer \(UserDefaults.standard.string(forKey: "accessToken")!)"

class EditProfileVC: UIViewController {
    // components
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var tagsCV: UICollectionView!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var bioTV: UITextView!
    
    let picker = UIImagePickerController()
    
    // data
    var profileData: ProfileData?
    var profileImgDto: UIImage?
    var profileImgData: Data?
    var tagIdsString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 이미지 뷰 UI
        setImgViewUI()
        // 이미지 피커 위임
        setImagePicker()
        // 프로필 불러오기
        getMyProfile()

    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - 함수
    func setImagePicker(){
        picker.sourceType = .photoLibrary
        picker.delegate = self
    }
    
    // MARK: - UI
    func setImgViewUI(){
        profileImageView.layer.cornerRadius = 65
    }
    
    // MARK: - 서버에서 프로필 데이터 불러오기
    // 뷰에 데이터 반영
    func loadProfile(){
        let url = URL(string: profileData?.profileImage ?? "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png")
        let imgData = try! Data(contentsOf: url!)
        profileImgDto = UIImage(data: imgData)
        
        profileImageView.image = profileImgDto
        nicknameTF.text = profileData?.nickname
        contactTF.text = profileData?.contact
        bioTV.text = profileData?.bio
        
        //태그 로드
    }
    
    // 프로필 GET API 호출
    func getMyProfile(){
        // access token 전송
        MyProfileService.shared.getMyProfile(accessToken: accessToken) { (responseCode, responseBody) in
            if responseCode == .success {
                let body = responseBody as! ResponseData<ProfileData>
                print(body)
                
                // 프로필에 불러오기
                self.profileData = body.data
                self.loadProfile()
            } else {
                print(responseCode)
            }
        }
    }
    
    // MARK: - 변경 데이터 반영 (완료 버튼 누를때 호출)
    func updateProfileData(){
        profileData?.nickname = nicknameTF.text ?? ""
        profileData?.contact = contactTF.text ?? ""
        profileData?.bio = bioTV.text ?? ""
        
        profileImgData = profileImgDto?.jpegData(compressionQuality: 1)
        
        // tag id 들 배열 형태의 문자열로 변환
        var tagIds: [String] = []
        for tag in profileData!.tags {
            tagIds.append(String(tag.id!))
        }
        tagIdsString = "[\(tagIds.joined(separator: ","))]"
        
    }
    
    // MARK: - 버튼 액션
    
    // 프로필 이미지 변경
    @IBAction func updateProfileImage(_ sender: Any) {
        present(picker, animated: true, completion: nil)
    }
    
    // 닫기
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 완료
    @IBAction func completeAction(_ sender: Any) {
        // 프로필 업데이트 완료 (바뀐 데이터들 담기)
        updateProfileData()
        // 프로필 업데이트 API 호출
        UpdateProfileService.shared.updateProfile(accessToken: accessToken, imageData: profileImgData!, tagIdsStr: tagIdsString, profileData: profileData! ) { (responseCode, responseBody) in
            if responseCode == .success {
                print(responseCode, responseBody)
                // 편집 뷰 나가기
                self.navigationController?.popViewController(animated: true)
            } else {
                print(responseCode, responseBody)
                // 편집 실패 alert
            }
        }
    }
}


// MARK: - 이미지 피커
extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            // 프로필 이미지 변경
            self.profileImgDto = image
            self.profileImageView.image = profileImgDto
        }
        dismiss(animated: true, completion: nil)
    }
}

