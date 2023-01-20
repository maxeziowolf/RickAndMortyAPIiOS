//
//  CharacterViewModel.swift
//  RickAndMortyAPI
//
//  Created by Maximiliano Ovando Ramírez on 19/01/23.
//


class CharacterViewModel {
    
    var refreshResults = {() -> () in}
    var refreshCounts = {(_:Int,_:Int) -> () in}
    
    var nextPage: String?
    var results: [Character] = []{
        didSet{
            refreshResults ()
        }
    }
    var allCount: Int = 826{
        didSet{
            refreshCounts(results.count,allCount)
        }
    }
    
    
    func getCharacters(){
        
        let url = nextPage ?? RickAndMortyAPIConstans.getCharacterUrl()
        
        ServiceCoordinator.sendRequest(url: url) { [weak self] (response: ServiceStatus<ResponseAPI>) in
            switch response {
            case .success(let data):
                if let info = data.results{
                    self?.results.append(contentsOf: info)
                    self?.nextPage = data.info?.next
                    self?.allCount = data.info?.count ?? 826
                }
            case .failed(let error):
                print(error.rawValue)
            case .unowned(let error):
                print(error)
            }
        }
        
    }
    
    
}
