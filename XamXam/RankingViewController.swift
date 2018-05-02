//
//  RankingViewController.swift
//  
//
//  Created by Yamadou Traore on 5/2/18.
//

import UIKit

class RankingViewController: UIViewController {

    // Mark: - Properties
    var gameStats: [GameStat] = []
    
    // Mark: - IBOutlets
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var rankingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
            self.gameStats = gameStats
            completion()
        })
    }
}

extension RankingViewController: UITableViewDelegate {
}

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
