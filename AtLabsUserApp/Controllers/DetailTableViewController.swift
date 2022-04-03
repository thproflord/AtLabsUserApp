//
//  DetailTableViewController.swift
//  AtLabsUserApp
//
//  Created by Fernando Gomes on 03/04/2022.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    var username : String = ""
    var repoList = [RepoDto]()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRepoList()
    }
    
    //MARK: - Functions
    private func fetchRepoList(){
        if(Reachability.isConnectedToNetwork()){
            let group = DispatchGroup()
            startIndicator()
            group.enter()
            DispatchQueue.global().async {
                self.repoList = DetailViewService.getRepoList(username: self.username)
                group.leave()
            }
            group.notify(queue: .main){
                self.stopIndicator()
                self.tableView.reloadData()
            }
        } else {
            Reachability.dispatchAlert(self)
        }
    }


}

//MARK: - Table View Data Source and Delegates
extension DetailTableViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.repo_detail_cell, for: indexPath) as! RepoViewCell
        cell.setCell(repo: self.repoList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: self.repoList[indexPath.row].html_url) {
            UIApplication.shared.open(url)
        }
    }
}

//MARK: - Repo Cell
class RepoViewCell : UITableViewCell {
    
    @IBOutlet weak var repoName : UILabel!
    @IBOutlet weak var repoLanguage : UILabel!
    @IBOutlet weak var repoUrl : UILabel!
    
    override class func awakeFromNib() {
    }
    
    func setCell(repo : RepoDto){
        repoName.text = repo.name
        if let safeLanguage  = repo.language {
            repoLanguage.text = safeLanguage
        } else {
            repoLanguage.text = ""
        }
        repoUrl.text = repo.html_url
    }
}

