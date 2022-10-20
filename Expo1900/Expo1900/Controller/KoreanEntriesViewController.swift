//  Expo1900 - KoreanEntriesViewController.swift
//  Created by Mangdi, zhilly on 2022/10/18

import UIKit

class KoreanEntriesViewController: UIViewController {
    
    @IBOutlet weak var koreanEntriesTableView: UITableView!
    
    let cellIdentifier: String = "koreanEntryCell"
    var koreanEntries: [KoreanEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadKoreanEntries()
        navigationController?.navigationBar.topItem?.backButtonTitle = "메인"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEntryDetail" {
            guard let entriesDetailViewController = segue.destination as? EntriesDetailViewController,
                  let indexPath = koreanEntriesTableView.indexPathForSelectedRow else { return }
            
            entriesDetailViewController.koreanEntry = koreanEntries[indexPath.row]
        }
    }
    
    func loadKoreanEntries() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "items") else { return }
        
        do {
            self.koreanEntries = try jsonDecoder.decode([KoreanEntry].self, from: dataAsset.data)
        } catch {
            return
        }
    }
}

extension KoreanEntriesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.koreanEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = koreanEntriesTableView.dequeueReusableCell(
            withIdentifier: self.cellIdentifier,
            for: indexPath
        )
        let entry: KoreanEntry = self.koreanEntries[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.image = UIImage(named: entry.imageName)
        content.text = entry.name
        content.secondaryText = entry.shortDescription
        cell.contentConfiguration = content
        return cell
    }
}

extension KoreanEntriesViewController: UITableViewDelegate {
    
}
