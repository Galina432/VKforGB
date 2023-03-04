//
//  FavoriteGroupTableViewController.swift
//  L2.1_SavitskayaGalina
//
//  Created by Galina on 22.04.2022.
//

import UIKit
import RealmSwift
import FirebaseDatabase
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FavoriteGroupTableViewController: UITableViewController {
    
    let operationQueue = OperationQueue()
    
    let db = Firestore.firestore()
    
    func loadGroups(groupHandler: @escaping ([Int]) -> Void) {
        db
            .collection("authentificatedGroup")
            .document("Group")
            .getDocument { snapshot, error in
                print(error as Any)
                
                guard
                    let dataDict = snapshot?.data(),
                    let data = try? JSONSerialization.data(withJSONObject: dataDict, options: .fragmentsAllowed),
                    let groupDocument = try? JSONDecoder().decode(GroupsResponse.Response.Items.self, from: data)
                else { return }
                
                groupHandler([groupDocument.id])
            }
    }
    
    func writeToGroup(group: [Int]) {
        db
            .collection("authentificatedGroup")
            .document("Group")
            .setData(["id" : group])
    }
    
    
    //Создал пустой массив с типом Groups
    var myGroups: [Groups] = []
    private var realmNotification: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var components = URLComponents()
            components.scheme = "https"
            components.host = "api.vk.com"
            components.path = "/method/groups.get"
            components.queryItems = [
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "v", value: "5.131"),
                URLQueryItem(name: "fields", value: "country,can_post"),
                URLQueryItem(name: "access_token", value: Session.instance.token )
            ]
        
            guard let url = components.url else { return }
        
        let urlRequest = URLRequest(url: url)
        let loadOperation = FetchDataOperation(request: urlRequest)
        let parseOperation = ParsingOperation<GroupsResponse>()
        parseOperation.addDependency(loadOperation)
        
        parseOperation.completionBlock = {
            print(parseOperation.outputModel as Any)
        }
        
        operationQueue.addOperation(loadOperation)
        operationQueue.addOperation(parseOperation)
        
        
        
        
        
    
        //Вызываю функцию loadGroup
//        GroupService().loadGroup { [weak self]  (complition) in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                // а здесь пришедшие данные , которые отсортированы по имени и фото добавляю в массив myGroups
//                self.myGroups = complition
//                self.tableView.reloadData()
//
//                guard let realm = try? Realm() else { return }
//                self.makeObserver(realm: realm)
//                self.tableView.reloadData()
//            }
//        }
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupRealm.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
            preconditionFailure("Error cell")
        }

        // Здесь достаем из GroupCell наше имя группы и фото группы
        //cell.groupNameLabel.text = myGroups[indexPath.row].groupName
        //А здем проверяем, если наша фотка пришла, то загружаем ее в наш groupImageView
        //if let imgUrl = URL(string: myGroups[indexPath.row].groupLogo) {
            //let avatar = ImageResource(downloadURL: imgUrl) //работает через Kingfisher
            //cell.avatarFriendView.avatarImage.kf.setImage(with: avatar) //работает через Kingfisher
            // работает через extension UIImageView
            // Я создал отдельный файл с расширением для UIImage, так работать удобнее, можно вытаскивать метод load
            //через точечный синтаксис
            //cell.groupImageView.load(url: imgUrl) //загружаем нашу пришедшую картинку.
       
        cell.groupNameLabel.text = myGroupRealm[indexPath.row].name
        
        if let imgUrl = URL(string: myGroupRealm[indexPath.row].photo50) {
            cell.groupImageView.load(url: imgUrl)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let groupsToDelete = myGroupRealm[indexPath.row]
        if editingStyle == .delete {
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.delete(groupsToDelete)
                try realm.commitWrite()
            } catch {
                print(error)
            }
            
            //myGroups.remove(at: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    @IBAction func addNewGroup(_ sender: Any) {
    }
    
    var myGroupRealm: [GroupsRealm] = []
    
    private func makeObserver(realm: Realm) {
        let objs = realm.objects(GroupsRealm.self)
        
        realmNotification = objs.observe({ changes in
            switch changes {
            case let .initial(objs):
                self.myGroupRealm = Array(objs)
                self.tableView.reloadData()
            case .error(let error): print(error)
            case let .update(myGroupRealm, deletions, insertions, modifications):

                DispatchQueue.main.async { [self] in
                    self.myGroupRealm = Array(myGroupRealm)

                    tableView.beginUpdates()

                    tableView.deleteRows(at: deletions.map {IndexPath.init(row: $0, section: 0)}, with: .automatic)
                    tableView.insertRows(at: insertions.map {IndexPath.init(row: $0, section: 0)}, with: .automatic)
                    tableView.reloadRows(at: modifications.map {IndexPath.init(row: $0, section: 0)}, with: .automatic)

                    tableView.endUpdates()
                }
            }
        })
    }
}
