//
//  ViewController.swift
//  DragAndDropView
//
//  Created by Hakim Laoukili on 2020-10-19.
//  Copyright © 2020 Hakim Laoukili. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    private var collectionView: UICollectionView?
    //Arrays of Clours you can drag and drop whith
    var colors: [UIColor] = [
    .brown,
    .systemGreen,
    .systemBlue,
    .red,
    .systemOrange,
    .black,
    .systemPurple,
    .systemGray,
    .systemYellow,]

    
    //VIEWDIDLOAD IS HERE!!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Costom Layout for CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/3.2,
                                 height: view.frame.size.width/3.2)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0,
                                             bottom: 0, right: 0)
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        view.addSubview(collectionView!)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handelLongPressGesture(_:)))
        collectionView?.addGestureRecognizer(gesture)
        
        
    }
    //ENDING VIEWDIDLOAD!!
    
    
    @objc func handelLongPressGesture(_ gesture: UILongPressGestureRecognizer){
        guard let collectionView = collectionView else {
            return

      }
        
        //Moving the ithems whit swithe method
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }

            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
            
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
            
            
        case .ended:
            collectionView.endInteractiveMovement()
            
        default:
            collectionView.cancelInteractiveMovement()
            
        }
    }
    
    
//Cover the hole Screen
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    //Funtions for CollectionViews.
    
    //Nr of Iteams on the Screen
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
//    Resubel the Cell Iteams
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/3.2,
        height: view.frame.size.width/3.2)
    }
//Re-order
//    Move the iteam commando canMove
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
//    commando MoveIteamAt Swisthing the Colors iteam.
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
          let item = colors.remove(at: sourceIndexPath.row)
              colors.insert(item, at:  destinationIndexPath.row)
    }
      
        
    
 }

