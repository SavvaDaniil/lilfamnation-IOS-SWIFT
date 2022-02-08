//
//  UserFacade.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 14.01.2022.
//

import CoreData

class UserFacade {
    
    private var _context: NSManagedObjectContext
    init(_ context: NSManagedObjectContext){
        _context = context
    }
    
    public func isAuth() -> Bool {
        let techDataService = TechDataService(_context)
        return techDataService.isAccessTokenExist()
    }
    
    
    public func login(_ username: String, _ password: String, _ userLoginResultDelegate: UserLoginResultDelegate) {
        
        let url = URL(string: GlobalVariables.baseDomain + "/api/user/app/login")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "username": username,
            "password" : password
        ]
        request.httpBody = parameters.percentEncoded()

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                userLoginResultDelegate.result(jsonAnswerStatus: nil)
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                userLoginResultDelegate.result(jsonAnswerStatus: nil)
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            //print("UserFacade login responseString = \(responseString)")
            
            do {
                
                let jsonData = try! responseString?.data(using: .utf8)
                if jsonData == nil {
                    userLoginResultDelegate.result(jsonAnswerStatus: nil)
                    return
                }
                let jsonAnswerStatus: JsonAnswerStatus = try! JSONDecoder().decode(JsonAnswerStatus.self, from: jsonData!)
                
                DispatchQueue.main.async {
                    userLoginResultDelegate.result(jsonAnswerStatus: jsonAnswerStatus)
                }
                
                
            } catch {
                return
            }
            
            //lessonPreviewsTableView.reloadData()
        }

        task.resume()
    }
    
    
    public func registration(
        userRegistrationDelegate: UserRegistrationDelegate,
        username: String,
        fio: String,
        phone: String,
        password: String,
        passwordAgain: String,
        sex: Int,
        dateOfBirthdayStr: String,
        parentFio: String,
        parentPhone: String
    ){
        ...
        
    }
    
    
    public func logout() -> Bool {
        let techDataService = TechDataService(_context)
        return techDataService.updateAccessToken(nil)
    }
    
    
    public func forget(
        userForgetDelegate: UserForgetDelegate,
        step: Int,
        username: String?,
        code: String?,
        forget_id: Int = 0
    ){
        
        ...
    }
    
    
    public func getProfile(
        userProfileDelegate: UserProfileDelegate
    ){
        
        ...
    }
    
    
    public func save(
        userProfileDelegate: UserProfileDelegate,
        username: String,
        fio: String?,
        phone: String?,
        sex: Int,
        dateOfBirthday: String?,
        parentFio: String?,
        parentPhone: String?,
        passwordCurrent: String?,
        passwordNew: String?
    ){
        
        ...
    }
}
