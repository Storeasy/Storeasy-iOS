//
//  EditProfileVC.swift
//  Storizy-iOS
//
//  Created by 임수정 on 2021/11/10.
//

import UIKit

let accessToken = UserDefaults.standard.string(forKey: "accessToken") ?? ""

class EditProfileVC: UIViewController {
    // components
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var tagsCV: UICollectionView!
    @IBOutlet weak var contactTF: UITextField!
    @IBOutlet weak var bioTV: UITextView!
    @IBOutlet weak var completeBTN: UIButton!
    
    let picker = UIImagePickerController()
    
    // data
    var profileData: ProfileData? {
        didSet {
            tagsCV.reloadData()
        }
    }
    var profileImgDto: UIImage?
    var profileImgData: Data?
    var tagIdsString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI
        setUI()
        // 이미지 피커 위임
        setImagePicker()
        // 프로필 불러오기
        getMyProfile()
        // nib 등록
        registerNib()

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
    
    func registerNib(){
        let profileTagNibName = UINib(nibName: "ProfileTagCell", bundle: nil)
        tagsCV.register(profileTagNibName, forCellWithReuseIdentifier: "ProfileTagCell")
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
    // 3 프로필 업데이트 함수
    func updateProfileData(_ imageUrl: String){
        profileData?.profileImage = imageUrl // "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png"

        self.profileData?.nickname = self.nicknameTF.text ?? ""
        self.profileData?.contact = self.contactTF.text ?? ""
        self.profileData?.bio = self.bioTV.text ?? ""
        
        let tagIds = self.profileData?.tags.map({ $0.id ?? 0 })
        
        // 프로필 업데이트 API 호출
        UpdateProfileService.shared.updateProfile(accessToken: accessToken, tagIds: tagIds ?? [], profileData: self.profileData! ) { (responseCode, responseBody) in
            if responseCode == .success {
                print(responseCode, responseBody)
                // 편집 뷰 나가기
                self.navigationController?.popViewController(animated: true)
            } else {
                print(responseCode, responseBody)
                // 편집 실패 alert
                self.navigationController?.popViewController(animated: true) // temp
            }
        }
    }
    
    
    // 2 이미지 업로드 후 프로필 업데이트 함수를 호출하며 이미지 URL을 전달하는 함수
    func getImageUrl(imageData: Data) {
        UploadProfileImage.shared.uploadProfileImage(accessToken: accessToken, imageData: imageData) { (responseCode, responseBody) in
            if responseCode == .success {
                print(responseCode, responseBody)
                guard let body = responseBody as? ResponseData<String> else { return }
                let imgUrl = body.data ?? "https://storeasy.s3.ap-northeast-2.amazonaws.com/profileImages/profile_image.png"
                print("urlurlurl\(imgUrl)")
                self.updateProfileData(imgUrl)
            } else {
                print(responseCode, responseBody)
            }
        }
    }
    
    // 1 이미지 -> 데이터 -> 업로드 함수 호출
    func uploadImage(){
        self.profileImgData = self.profileImgDto?.jpegData(compressionQuality: 1)
        self.getImageUrl(imageData: self.profileImgData!)
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
        // 1
        uploadImage()
        // 프로필 업데이트 완료 (바뀐 데이터들 담기)
//        updateProfileData()
        
    }
    
    // MARK: - UI
    func frameUI<T: UIView>(_ view: T){
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "light_gray2")?.cgColor
        view.clipsToBounds = true
    }
    
    func setUI(){
        // 헤더 그림자
        headerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headerView.layer.shadowRadius = 6
        headerView.layer.shadowOpacity = 1
        headerView.layer.shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.1).cgColor
        
        // 이미지 뷰 원
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2

        // 둥글, 테두리
        // 이름 입력 칸
        frameUI(nicknameTF)
        // 연락처 입력 칸
        frameUI(contactTF)
        // 자기소개 Text View
        frameUI(bioTV)
        bioTV.textContainerInset = UIEdgeInsets(top: 12, left: 6,bottom: 12,right: 12)
        
        // 완료 버튼 UI
        completeBTN.layer.cornerRadius = 12
    }
}

// MARK: - 태그 collection view

extension EditProfileVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileData?.tags.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileTagCell", for: indexPath) as? ProfileTagCell else {
            return UICollectionViewCell()
        }
        cell.tagNameLabel.text = profileData?.tags[indexPath.item].tagName
        // TAG UI
        cell.frameView.backgroundColor = UIColor(named: "dark_gray1")
        cell.tagNameLabel.textColor = UIColor(named: "extra_white")
        cell.frameView.layer.borderWidth = 0
        return cell
    }
    
    // 선택시 태그 수정
    
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

