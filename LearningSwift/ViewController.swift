//
//  ViewController.swift
//  LearningSwift
//
//  Created by Ilya Makarevich on 2/9/21.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        example(of: "creating observables") {
          let mostPopular: Observable<String> = Observable<String>.just(episodeI)
          let originalTrilogy = Observable.of(episodeIV, episodeV, episodeVI)
            
        }
        
        example(of: "subscribe") {
            let observable = Observable.of(episodeIV, episodeV, episodeVI)
            
            observable.subscribe { (event) in
                print(event)
            } onError: { (_) in
                
            } onCompleted: {
                
            } onDisposed: {
                
            }
        }
        
        example(of: "empty") {
            let observable = Observable<Void>.empty()
            
            observable.subscribe { (event) in
                print(event)
            } onError: { (_) in
                
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                
            }
        }
        
        example(of: "never") {
            let observable = Observable<Void>.never()
            
            observable.subscribe { (event) in
                print(event)
            } onError: { (_) in
                
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                
            }
        }
        
        example(of: "dispose") {
            let observable = Observable.of(episodeIV, episodeV, episodeVI)

            let subscription = observable.subscribe { (event) in
                print(event)
            }
            
            subscription.dispose()
        }
        
        example(of: "dispose bag") {
            
            let disposeBag = DisposeBag()
            Observable.of(episodeIV, episodeV, episodeVI).subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)

        }
        
        example(of: "without dispose bag") {
            
            Observable.of(episodeIV, episodeV, episodeVI).subscribe { (event) in
                print(event)
            }

        }
        
    }


}

