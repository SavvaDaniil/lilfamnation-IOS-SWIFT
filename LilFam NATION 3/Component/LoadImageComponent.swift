//
//  LoadImageComponent.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 26.01.2022.
//

import UIKit

class LoadImageComponent {

    public static func startAsyncDownloadImage(from url: URL?, imageView: UIImageView) -> () {
        if url == nil {
            return
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async { [self] in
            
            getData(from: url!) { data, response, error in
                print("Закончилась загрузка картинки для url: \(url!)")
                //GlobalVariables.lessonsImageLoadAsyncLaunch = GlobalVariables.lessonsImageLoadAsyncLaunch.filter{$0 != id}
                
                guard let data = data, error == nil else {
                    print("Ошибка связи: \(error.debugDescription)")
                    DispatchQueue.main.async() {
                        imageView.image = UIImage(named: "userDefault")
                    }
                    return
                }
                DispatchQueue.main.async() {
                    imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    private static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
