//
//  UserDataManager.swift
//  RemindersApp
//
//  Created by Phil on 2023/06/17.
//

import Foundation
import Alamofire

class UserDataManager {
    let baseURL = "https://port-0-asteroid-backend-dihik2mlis5q700.sel4.cloudtype.app"

    func getLists() { //MyListView.onApear
        let url = baseURL + "/list/lists"
        
        AF.request(url).responseDecodable(of: [List].self) { response in
            switch response.result {
            case .success(let lists):
                print(lists)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postLists(title: String) { //AddNewListView.Done
        let url = baseURL + "/list/register"
        let parameters: [String: Any] = ["title": title]
        
        AF.request(url, method: .post, parameters: parameters).responseDecodable(of: List.self) { response in
            switch response.result {
            case .success(let post):
                print(post)
            case .failure(let error):
                print(error)
            }
        }
    }
    func deleteList(listId: Int) { // MyListView.deleteList
        let url = baseURL + "/list/\(listId)"
        
        AF.request(url, method: .delete).response { response in
            if let error = response.error {
                print(error)
            } else {
                print("삭제성공")
            }
        }
    }
    func getTasks(userId: Int, listId : Int) { //ReminderListView.init
        let url = baseURL + "/\(userId)/todo/\(listId)"
        
        AF.request(url).responseDecodable(of: [Task].self) { response in
            switch response.result {
            case .success(let tasks):
                    print(tasks)

            case .failure(let error):
                print(error)
            }
        }
    }
    func postTasks(userId: Int, listId : Int, content:String, completed: Bool) { // ReminderListView.NewReminder
        let url = baseURL + "/\(userId)/todo/\(listId)/post"
        let parameters: [String: Any] = ["content": content, "completed" : completed ]
        
        AF.request(url, method: .post, parameters: parameters).responseDecodable(of: List.self) { response in
            switch response.result {
            case .success(let post):
                print(post)
            case .failure(let error):
                print(error)
            }
        }
    }
    func deleteTask(userId: Int, listId : Int) { //ReminderListView.deleteTask
        let url = baseURL + "/\(userId)/todo/\(listId)/post"
        
        AF.request(url, method: .delete).response { response in
            if let error = response.error {
                print(error)
            } else {
                print("success")
            }
        }
    }
//    func updatePost(id: Int, title: String, body: String, completion: @escaping (Result<Post, Error>) -> Void) {
//        let url = baseURL + "/posts/\(id)"
//        let parameters: [String: Any] = ["title": title, "body": body]
//
//        AF.request(url, method: .patch, parameters: parameters).responseDecodable(of: Post.self) { response in
//            switch response.result {
//            case .success(let post):
//                completion(.success(post))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }

//    func updateTask(listId: Int, taskId: Int, content: String, completed : Bool) {
//                let url = baseURL + "\(userId)/todo/\(listId)/\(taskId)"
//        let parameters: [String: Any] = ["listId" : listId, "content": content, "completed": completed]
//
//        AF.request(url, method: .patch, parameters: parameters).responseDecodable(of: Post.self) { response in
//            switch response.result {
//            case .success(let post):
//                completion(.success(post))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//    }

    struct List: Codable {
        let id: Int
        let title: String
        let tasks: [Task]
    }
    struct Task : Codable {
        let content: String
        let completed: Bool
    }
}
