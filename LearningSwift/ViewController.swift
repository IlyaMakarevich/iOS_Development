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
        
        example(of: "create") {
            
            enum Droid: Error {
                case OI812
            }
            let disposeBag = DisposeBag()
            Observable<String>.create { observer in
                observer.onNext("robot police")
                observer.onError(Droid.OI812)
                observer.onNext("robot police2")
                observer.onNext("robot police3")
                observer.onCompleted()
                return Disposables.create()
            }.subscribe(onNext: {print($0)}, onError: {print($0)}, onCompleted: {print("compl")}, onDisposed: {print("disposed")}).disposed(by: disposeBag)
        }
        
        example(of: "Single") {
            let disposedBag = DisposeBag()
            
            enum FileReadError: Error {
                case fileNotFound, unreadable, encodingFailed
            }
            
            
            func loadText(from fileName: String) -> Single<String> {
                return Single.create { single in
                    let disposable = Disposables.create()
                    
                    guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
                        single(.failure(FileReadError.fileNotFound))
                        return disposable
                    }
                    
                    guard let data = FileManager.default.contents(atPath: path) else {
                        single(.failure(FileReadError.unreadable))
                        return disposable
                    }
                    
                    guard let contents = String(data: data, encoding: .utf8) else {
                        single(.failure(FileReadError.encodingFailed))
                        return disposable
                    }
                    
                    single(.success(contents))
                
                    return disposable
                }
            }
            
            loadText(from: "file")
                .subscribe {
                    switch $0 {
                    case .success(let string):
                        print(string)
                    case .failure(let error):
                        print(error)
                    }
                }.disposed(by: disposedBag)
        }
        
    }


}

