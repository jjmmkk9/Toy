//
//  LoginViewController.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/23/24.
//

import Foundation
import AuthenticationServices
import UIKit

class LoginViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //로그인버튼을 탭하면 handleAuthorization... 함수를 호출하고, 사용자 이름과 이메일 주소에 대한 인증요청응ㄹ 수행하고 흐름 시작...
    //다음 시스템이 사용자가 apple id로 로그인 했는지 확인하고 아니라면 애플 아이디로 로그인하도록 안내하는 알림 표시
//    func setupProviderLoginView(){
//        let authorizationButton = ASAuthorizationAppleIDButton()
//        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside) self.loginProviderStackView.addArrangedSubview(authorizationButton))
//    }

    @IBAction func handleAuthorizationAppleIDButtonPress(_ sender: UIButton) {
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        //사용자 이름과 이메일 주소에 대한 인증요청
        request.requestedScopes = [.fullName, .email]
        
        //컨트롤러에 리퀘스트들을 담아
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        //self로 했기 때문에 ASAuthorizationControllerDelegate를 LoginViewControllere가 채택해야 한다.
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

}

extension LoginViewController {
    func authorizationController(
            controller: ASAuthorizationController,
            didCompleteWithAuthorization authorization: ASAuthorization
        ) {
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                return
            }
            
            print(credential.user)
            
            let alert = UIAlertController(title: "로그인 성공", message: nil, preferredStyle: .alert)
            alert.addAction(.init(title: "확인", style: .cancel))
            present(alert, animated: true)
            
        }

        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            let alert = UIAlertController(title: "로그인 실패", message: nil, preferredStyle: .alert)
            alert.addAction(.init(title: "확인", style: .cancel))
            present(alert, animated: true)
        }
}
