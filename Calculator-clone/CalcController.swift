//
//  ViewController.swift
//  Calculator-clone
//
//  Created by Vinayaka Prabhu on 13/09/25.
//

import UIKit

class CalcController: UIViewController {

    
    // MARK: - Variables
    let viewModel: CalcControllerViewModel
    
    
    
    // MARK: - UI Components
    private let CollectionViewe: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.register(CalcHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CalcHeaderCell.identifier)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.identifier)
        return collectionView
        
    }()
    
    
    
    // MARK: - Lifecycle
    init(_ viewModel: CalcControllerViewModel = CalcControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPurple
        self.setupUI()
        // Do any additional setup after loading the view.
        
        
        self.CollectionViewe.delegate = self
        self.CollectionViewe.dataSource = self
        
        self.viewModel.updateViews = { [weak self] in
            DispatchQueue.main.async {   [weak self] in
                self?.CollectionViewe.reloadData()
            }
        }
    }

    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(self.CollectionViewe)
        self.CollectionViewe.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.CollectionViewe.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.CollectionViewe.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.CollectionViewe.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.CollectionViewe.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
    }

}


 // MARK: - CollectionView Methods

extension CalcController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    
    // MARK: - Section Header Cell
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalcHeaderCell.identifier, for: indexPath) as? CalcHeaderCell else {
            fatalError(" Failed to dequeue a CalcHeaderCell in CalcController")
        }
        header.configure(currentCalcText: self.viewModel.calcHeaderLabel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let totalCellHeight = view.frame.size.width
        let totalVerticalCellSpacing = CGFloat(10*4)
        
        let window = view.window?.windowScene?.keyWindow
        let topPadding = window?.safeAreaInsets.top ?? 0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        
        let availableScreenHeight = view.frame.size.height - topPadding - bottomPadding
        let headerheight = availableScreenHeight - totalCellHeight - totalVerticalCellSpacing
        
        return CGSize(width: view.frame.size.width, height: headerheight)
    }
    
    
    // MARK: - Normal Cells (Buttons)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.calcButtonCells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell{
        guard let cell = CollectionViewe.dequeueReusableCell(withReuseIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell else {
            fatalError(" Failed to dequeue a ButtonCell in CalcController")
            
        }
        let calcButton = self.viewModel.calcButtonCells[indexPath.row]
        
        cell.configure(with: calcButton)
        
        
        if let operation = self.viewModel.operation, self.viewModel.secondNumber == nil  {
            if operation.title == calcButton.title {
                cell.setOperationSelected()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let calcButton = self.viewModel.calcButtonCells[indexPath.row]
        
        switch calcButton {
            
        case let .number(int) where int == 0:
            return CGSize(width: (view.frame.size.width/5)*2 + ((view.frame.size.width/5)/3), height: view.frame.width / 5) ;
        default:
            return CGSize(width: view.frame.width / 5, height: view.frame.width / 5);
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (self.view.frame.width / 5)/3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let buttonCell = self.viewModel.calcButtonCells[indexPath.row]
        self.viewModel.didSelectButton(with: buttonCell)
    }
}

