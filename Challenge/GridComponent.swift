//
//  GridComponent.swift
//  Challenge
//
//  Created by Mikhail Strizhenov on 12.05.2020.
//  Copyright © 2020 Mikhail Strizhenov. All rights reserved.
//

import UIKit

class GridComponent: UIStackView {
    
    private var cells = [UIView]()
    
    private var currentRow: UIStackView!
    
    let rowCapacity: Int
    let rowWidth: CGFloat
    let rowHeight: CGFloat
    
    init(rowCapacity: Int, rowWidth: CGFloat, rowHeight: CGFloat) {
        self.rowCapacity = rowCapacity
        self.rowWidth = rowWidth
        self.rowHeight = rowHeight
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 5
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareRow() -> UIStackView {
        let row = UIStackView(arrangedSubviews: [])
        row.translatesAutoresizingMaskIntoConstraints = false
        row.axis = .horizontal
        row.spacing = 5
        row.distribution = .fillEqually
        return row
    }
    
    func addCell(view: UIView) {
        let firstCellInRow = cells.count % rowCapacity == 0
        if currentRow == nil || firstCellInRow {
            currentRow = prepareRow()
            addArrangedSubview(currentRow)
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
        view.widthAnchor.constraint(equalToConstant: rowWidth).isActive = true
        cells.append(view)
        currentRow.addArrangedSubview(view)
    }
}
