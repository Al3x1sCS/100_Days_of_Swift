//
//  ViewController.swift
//  project7
//
//  Created by user on 15/08/22.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var filterKeyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        title = "Petições White House"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Ceditos", style: .plain, target: self, action: #selector(showCredits))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filtro", style: .plain, target: self, action: #selector(askFilter))
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self?.parse(json: data)
                    return
                }
            }
            
            self?.showError()
        }
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filterData()
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "ERRO!", message: "Ocorreu um problema ao carregar o feed. Por favor verifique sua conexão.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Creditos", message: "Petições encontradas em petitions.whitehouse.gov", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterData() {
        var filterTitle: String
        
        if filterKeyword.isEmpty {
            filterTitle = "Filtro"
            
            filteredPetitions = petitions
        } else {
            filterTitle = "Filtro (atual: \(filterKeyword))"
            
            filteredPetitions = petitions.filter() { petition in
                if let _ = petition.title.range(of: filterKeyword, options: .caseInsensitive) {
                    return true
                }
                if let _ =  petition.body.range(of: filterKeyword, options: .caseInsensitive) {
                    return true
                }
                return false
            }
        }
        
        performSelector(onMainThread: #selector(filterDataGuiUpdate), with: filterTitle, waitUntilDone: false)
    }
    
    @objc func askFilter() {
        let ac = UIAlertController(title: "Filtro", message: "Filtre as petições com uma palavra-chave ou deixe em branco para redefinir.", preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            self?.filterKeyword = ac?.textFields?[0].text ?? ""
            self?.performSelector(inBackground: #selector(ViewController.filterData), with: nil)
        })
        
        present(ac, animated: true)
        
    }
    
    @objc func filterDataGuiUpdate(filterTitle: String) {
        navigationItem.leftBarButtonItem?.title = filterTitle
        tableView.reloadData()
    }
}

