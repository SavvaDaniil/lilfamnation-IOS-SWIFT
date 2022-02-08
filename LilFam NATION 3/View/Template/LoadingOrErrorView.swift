//
//  LoadingOrErrorView.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 22.01.2022.
//

import UIKit


class LoadingOrErrorView : UIView {
    
    private var _loadingOrErrorViewDelegate: LoadingOrErrorViewDelegate?
    private var _loadingView: UIView?
    private var _spinner = UIActivityIndicatorView(style: .large)
    
    private var _errorView: UIView?
    private var _errorDesc: UILabel?
    private var _btnTryAgain: ButtonDefault?
    
    init(loadingOrErrorViewDelegate: LoadingOrErrorViewDelegate){
        _loadingOrErrorViewDelegate = loadingOrErrorViewDelegate
        super.init(frame: CGRect())
        
        self.isHidden = true
        
        _loadingView = UIView(frame: CGRect())
        _loadingView?.addSubview(_spinner)
        _spinner.translatesAutoresizingMaskIntoConstraints = false
        _spinner.centerXAnchor.constraint(equalTo: _loadingView!.centerXAnchor).isActive = true
        _spinner.centerYAnchor.constraint(equalTo: _loadingView!.centerYAnchor).isActive = true
        
        self.addSubview(_loadingView!)
        _loadingView!.translatesAutoresizingMaskIntoConstraints = false
        _loadingView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _loadingView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _loadingView!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _loadingView!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        _loadingView!.isHidden = true
        
        _errorView = UIView(frame: CGRect())
        self.addSubview(_errorView!)
        _errorView!.translatesAutoresizingMaskIntoConstraints = false
        _errorView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        _errorView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        _errorView!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        _errorView!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        _errorView!.isHidden = true
        
        
        _btnTryAgain = ButtonDefault("Повторить")
        _errorView!.addSubview(_btnTryAgain!)
        _btnTryAgain!.translatesAutoresizingMaskIntoConstraints = false
        _btnTryAgain!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        _btnTryAgain!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        _btnTryAgain!.widthAnchor.constraint(equalToConstant: 160).isActive = true
        _btnTryAgain!.layer.cornerRadius = 15
        _btnTryAgain!.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
        
        _errorDesc = UILabel(frame: CGRect())
        _errorDesc!.font = UIFont(name: GlobalVariables.fontGothamProLightSrc, size: 24)
        _errorDesc!.textColor = .white
        _errorDesc!.text = "Ошибка сети"
        _errorDesc!.textAlignment = .center
        _errorView!.addSubview(_errorDesc!)
        _errorDesc!.translatesAutoresizingMaskIntoConstraints = false
        _errorDesc!.bottomAnchor.constraint(equalTo: _btnTryAgain!.topAnchor, constant: -20).isActive = true
        _errorDesc!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        _errorDesc!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    private func tryAgain(){
        _loadingOrErrorViewDelegate!.loadingOrErrorTryAgain()
    }
    
    public func setLoadingStatus(){
        self.isHidden = false
        _spinner.startAnimating()
        _loadingView!.isHidden = false
        _errorView!.isHidden = true
    }
    
    public func setDeactivatedStatus(){
        self.isHidden = true
        _spinner.stopAnimating()
        _loadingView!.isHidden = true
        _errorView!.isHidden = true
    }
    
    public func setErrorStatus(){
        self.isHidden = false
        _spinner.stopAnimating()
        _loadingView!.isHidden = true
        _errorView!.isHidden = false
    }
    
}
