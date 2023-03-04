//
//  Newsfeed.swift
//  L2.1_SavitskayaGalina
//
//  Created by Irina on 10.01.2023.
//

import Foundation
import UIKit

//struct NewsModel: Codable {
//    let postID: Int
//    let text: String
//    let date: Double
//    let attachments: [Attachment]?
//    let likes: Int
//    let comments: Int
//    let sourceID: Int
//    var avatarURL: String?
//    var creatorName: String?
//    var photosURL: [String]? {
//        get {
//            let photosURL = attachments?.compactMap{ $0.photo?.sizes?.last?.url }
//            return photosURL
//        }
//    }
//
////    var aspectRatio: CGFloat {
////        get {
////            let aspectRatio = attachments?.compactMap{ $0.photo?.sizes?.last?.aspectRatio }.last
////            return aspectRatio ?? 1
////        }
////    }
//
//    enum CodingKeys: String, CodingKey {
//        case postID = "post_id"
//    }
//}
//struct Attachment: Codable {
//    let photo: Photo?
//}
//
//struct Photo: Codable {
//    var id: Int
//    var sizes: [PhotoSize]
//
//
//
//    private func getPropperSize() -> PhotoSize {
//        if let sizeX = sizes.first(where: { $0.type == "x" }) {
//            return sizeX
//        } else if let fallBackSize = sizes.last {
//            return fallBackSize
//        } else {
//            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
//        }
//    }
//}
//
//struct PhotoSize: Codable {
//    var type: String
//    var url: String
//    var width: Int
//    var height: Int
//}
//
//


































struct FeedResponseWrapped: Decodable {
    var response: FeedResponse
}
struct FeedResponse: Decodable {
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [GroupFeed]
}

struct FeedItem: Decodable {
    var source_id: Int?
    var post_id: Int?
    var text: String?
    var date: Int?
    var comments: CountableItem
    var likes: CountableItem
    var reposts: CountableItem
    var views: CountableItem
    var attachments: [Attachment]?
    
//    func convertDate(timeIntervalSince1970: Double) -> String {
//        dateFormatter.dateFormat = "MM-dd-yyyy HH.mm"
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        let date = Date(timeIntervalSince1970: timeIntervalSince1970)
//        return dateFormatter.string(from: date)
//    }
}

struct Attachment: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    var id: Int
    var sizes: [PhotoSize]
    
    
    
    private func getPropperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Decodable {
    var type: String
    var url: String
    var width: Int
    var height: Int
}
// Пробовала сделать через класс, не получилось сделать в NewsfeedService2
//class FeedItem: Decodable {
//    var sourceId = 0
//    var postId = 0
//    var text = ""
//    var date = 0
//    var commentsCount = 0
//    var likesCount = 0
//    var repostsCount = 0
//    var viewsCount = 0
//
//    enum CodingKeys: String, CodingKey {
//        case sourceId = "source_id"
//        case postId = "post_id"
//        case text, date
//        case commentsCount = "comments"
//        case likesCount = "likes"
//        case repostsCount = "reposts"
//        case viewsCount = "views"
//    }
//
//    enum CommentsKeys: String, CodingKey { case count }
//    enum LikesKeys: String, CodingKey { case count }
//    enum RepostsKeys: String, CodingKey { case count }
//    enum ViewsKeys: String, CodingKey { case count }
//
//    convenience required init(from decoder: Decoder) throws {
//        self.init()
//
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.sourceId = try values.decode(Int.self, forKey: .sourceId)
//        self.postId = try values.decode(Int.self, forKey: .postId)
//        self.text = try values.decode(String.self, forKey: .text)
//        self.date = try values.decode(Int.self, forKey: .date)
//
//        let commentsValues = try values.nestedContainer(keyedBy: CommentsKeys.self, forKey: .commentsCount)
//        self.commentsCount = try commentsValues.decode(Int.self, forKey: .count)
//
//        let likesValues = try values.nestedContainer(keyedBy: LikesKeys.self, forKey: .likesCount)
//        self.likesCount = try likesValues.decode(Int.self, forKey: .count)
//
//        let repostsValues = try values.nestedContainer(keyedBy: RepostsKeys.self, forKey: .repostsCount)
//        self.repostsCount = try repostsValues.decode(Int.self, forKey: .count)
//
//        let viewsValues = try values.nestedContainer(keyedBy: ViewsKeys.self, forKey: .viewsCount)
//        self.viewsCount = try viewsValues.decode(Int.self, forKey: .count)
//    }
//}
 
struct CountableItem: Decodable {
    var count: Int?
}
                
struct Profile: Decodable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var photo_100: String?
}

struct GroupFeed: Decodable {
    var id: Int?
    var name: String?
    var photo_100: String?
}
            
//Модель для отображения
struct NewsPost: Equatable {
    var newsAvatarPost: UIImage
    var newsNamePost: String
    var newsDatePost: String
    var newsText: String
    var newsImage: UIImage
    var comments: Int
    var likes: Int
    var reposts: Int
    var views: Int
}

