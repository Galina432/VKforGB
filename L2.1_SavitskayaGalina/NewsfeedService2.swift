//
//  NewsfeedService2.swift
//  L2.1_SavitskayaGalina
//
//  Created by Irina on 28.01.2023.
//

import Foundation
import RealmSwift

final class NewsfeedService {
    
    func parse(data: Data, completionHandler: @escaping (FeedResponse) -> Void) {
        DispatchQueue.global().async {
            
            var parsedItems = [FeedItem]()
            var parsedProfiles = [Profile]()
            var parsedGroups = [GroupFeed]()
            
            let json = (try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any]) ?? [:]
            
            let response = (json["response"] as? [String : Any]) ?? [:]
            let items = response["items"]
            let profiles = response["profiles"]
            let groups = response["groups"]
            
            let itemsData = (try? JSONSerialization.data(withJSONObject: items as Any, options: .fragmentsAllowed)) ?? Data()
            let profileData = (try? JSONSerialization.data(withJSONObject: profiles as Any, options: .fragmentsAllowed)) ?? Data()
            let groupsData = (try? JSONSerialization.data(withJSONObject: groups as Any, options: .fragmentsAllowed)) ?? Data()
            
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            dispatchGroup.enter()
            dispatchGroup.enter()
            
            DispatchQueue.global().async {
                let modelNews = try? JSONDecoder().decode([FeedItem].self, from: itemsData)
                parsedItems = modelNews ?? []
                dispatchGroup.leave()
            }
            
            DispatchQueue.global().async {
                let modelProfile = try? JSONDecoder().decode([Profile].self, from: profileData)
                parsedProfiles = modelProfile ?? []
                dispatchGroup.leave()
            }
            
            DispatchQueue.global().async {
                let modelGroup = try? JSONDecoder().decode([GroupFeed].self, from: groupsData)
                parsedGroups = modelGroup ?? []
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .global()) {
                let news = FeedResponse(
                    items: parsedItems,
                    profiles: parsedProfiles,
                    groups: parsedGroups
                    
                    //не получается обьединить массивы
//                    for i in 0..<parsedItems.count {
//                        if parsedItems[i].source_id < 0 {
//                            let group = parsedGroups.first(where: { $0.id == -parsedItems[i].source_id })
//                    
//
//                   // parsedGroups[i].name
//                            //parsedGroups[i].photo_100
//                        } else {
//                            let profile = parsedProfiles.first(where: { $0.id == parsedItems[i].source_id })
//                            //(parsedProfiles[i].firstName ?? "") + (parsedProfiles[i].lastName ?? "")
//                            //parsedProfiles[i].photo_100
//                        }
//                    }
                )
                completionHandler(news)
            }
        }
    }
    
    func loadData(completion: @escaping (Data) -> Void) {
        
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/newsfeed.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.instance.userId)),
            URLQueryItem(name: "filters", value: "post, photo"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "count", value: "2")
        ]
        let url = urlConstructor.url!
        
        guard let url = urlConstructor.url else { return }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            
                        guard let data = data else {
                            return
                        }
                        completion(data)
                    }.resume()
        }
}

