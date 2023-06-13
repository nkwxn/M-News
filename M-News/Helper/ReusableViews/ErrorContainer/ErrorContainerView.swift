//
//  ErrorContainerView.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import UIKit

class ErrorContainerView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var errorTitle: UILabel!
    @IBOutlet private weak var errorDesc: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ErrorContainerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func configure(error: Error) {
        self.errorDesc.text = error.localizedDescription
    }
}
