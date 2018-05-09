//
//  RankingViewController.swift
//  
//
//  Created by Yamadou Traore on 5/2/18.
//

import UIKit

class RankingViewController: UIViewController {

    // Mark: - Properties
    var topic = "Croyance"
    var gameStats: [GameStat] = []
    
    // Mark: - IBOutlets
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var rankingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topicTitleLabel.text = topic
        
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        
        fetchRanking(completion: {
            DispatchQueue.main.async {
                self.rankingTableView.reloadData()
            }
        })
    }
    
    private func fetchRanking(completion: @escaping () -> Void) {
        WebService.fetchGameStats({ gameStats in
            self.gameStats = gameStats.filter{ $0.topic == self.topic}
            self.gameStats.sort(by: { $0.score > $1.score })
            completion()
        })
    }
    
    // Mark: IBAction
    @IBAction func closeDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// Mark: UITableViewDelegate
extension RankingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.section
        let stat = gameStats[index]
        
        let rankingDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ScoreDetailVC") as! RankingDetailViewController
        rankingDetailVC.stat = stat
        rankingDetailVC.view.backgroundColor = UIColor.clear
        rankingDetailVC.modalPresentationStyle = .overCurrentContext
        
        self.present(rankingDetailVC, animated: true, completion: nil)
    }
}

// Mark: UITableViewDataSource
extension RankingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return gameStats.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell") as! RankingCell
        
        let index = indexPath.section
        let gameStat = gameStats[index]
        
        cell.model = RankingCell.Model(stat: gameStat, index: index)
        return cell
    }
}
