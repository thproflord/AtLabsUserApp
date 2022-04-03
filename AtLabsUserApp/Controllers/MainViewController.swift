//
//  ViewController.swift
//  AtLabsUserApp
//
//  Created by Fernando Gomes on 01/04/2022.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Views IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    //MARK: - Labels IBOutlets
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var biography: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var reposLabel: UILabel!
    @IBOutlet weak var repos: UILabel!
    
    //MARK: - SearchBar IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Propeties
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        searchBar.delegate = self
        setTranslations()
    }
    
    //MARK: - Functions
    private func setUpViews(){
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowOffset = CGSize(width: 5, height: 5)
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOpacity = 0.3
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToDetails)))
        containerView.isHidden = true
    }
    
    private func setTranslations(){
        followersLabel.text = NSLocalizedString(Constants.followers_label, comment: "Label for followers")
        reposLabel.text = NSLocalizedString(Constants.repos_label, comment: "Label for repositories")
        bioLabel.text = NSLocalizedString(Constants.bio_label, comment: "Label for biography")
    }
    
    private func setCard(user : UserDto){
        containerView.isHidden = false
        avatarImage.loadFromUrl(imageUrl: user.avatar_url)
        username.text = user.login
        if let safeName = user.name {
            firstName.text = safeName
        } else {
            firstName.text = ""
        }
        
        if let safeBio = user.bio {
            biography.text = safeBio
        } else {
            biography.text = ""
        }
        
        followers.text = String(user.followers)
        repos.text = String(user.public_repos)
    }
    
    private func userNotFund(){
        containerView.isHidden = true
        let alert = UIAlertController(title: NSLocalizedString(Constants.user_not_found_title, comment: "no user title") , message: NSLocalizedString(Constants.user_not_found_body, comment: "no user body") , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString(Constants.ok, comment: "ok"), style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    private func fetchUserData(username : String){
        if(Reachability.isConnectedToNetwork()){
            var userData : UserDto? = nil
            let group = DispatchGroup()
            startIndicator()
            group.enter()
            DispatchQueue.global().async {
                userData = MainViewServices.getPostList(username: username)
                group.leave()
            }
            group.notify(queue: .main){
                self.stopIndicator()
                if let safeUserData = userData {
                    self.setCard(user: safeUserData)
                }else {
                    self.userNotFund()
                }
            }
        } else {
            Reachability.dispatchAlert(self)
        }
    }
    
    @objc func goToDetails(){
        performSegue(withIdentifier: Constants.to_detail, sender: nil)
    }
    
    // MARK: - Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is DetailTableViewController {
            let vc = segue.destination as? DetailTableViewController
            vc?.username = self.username.text!
        }
    }

}




// MARK: - SerachBar Delegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(searchBar.text! != ""){
            fetchUserData(username: searchBar.text!)
        }
    }
}
