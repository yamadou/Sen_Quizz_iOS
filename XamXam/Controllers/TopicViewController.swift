//
//  TopicViewController.swift
//  XamXam
//
//  Created by Yamadou Traore on 4/12/18.
//  Copyright © 2018 com.yamadou. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TopicViewController: UIViewController {

    // Mark: - Properties
    var user: User!
    var topics: [Topic] = []
    let topicsRef = Database.database().reference(withPath: "themes")
    
    // Mark: - IBOutlets
    @IBOutlet weak var topicsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicsCollectionView.delegate = self
        topicsCollectionView.dataSource = self
        
        fetchTopics(completion: {
            DispatchQueue.main.async {
                self.topicsCollectionView.reloadData()
            }
        })
    
    }
    
    // Mark: - Private
    private func fetchTopics(completion: @escaping () -> Void) {
        WebService.fetchTopics( { topics in
            self.topics = topics
            completion()
        })
    }
    
}


extension TopicViewController: UICollectionViewDataSource {
    
    // Mark: - CollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as! TopicCollectionViewCell
        
        let index = indexPath.row
        let topic = topics[index]
        
        cell.model = TopicCollectionViewCell.Model(topic: topic)
        
        return cell
        
    }
}


extension TopicViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Mark: - CollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.view.frame.size.width-10)/3 - 4
        let height = width
        
        return CGSize(width: width, height: height);
    }
    
    // Mark: - CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        let selectedTopic = topics[index]
        
        let playOrSubmitQuestionVC = storyboard?.instantiateViewController(withIdentifier: "PlayOrSubmitQuestionVC") as! PlayOrSubmitQuestionViewController
        
        playOrSubmitQuestionVC.view.backgroundColor = UIColor.clear
        playOrSubmitQuestionVC.modalPresentationStyle = .overCurrentContext
        playOrSubmitQuestionVC.topicNameLabel.text = selectedTopic.name.uppercased()
        playOrSubmitQuestionVC.topic = selectedTopic
        playOrSubmitQuestionVC.user = user
        
        self.present(playOrSubmitQuestionVC, animated: true, completion: nil)
    }
}

