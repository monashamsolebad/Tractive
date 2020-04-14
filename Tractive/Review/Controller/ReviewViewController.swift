//
//  ReviewViewController.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-09.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
import CoreData


class ReviewViewController: UIViewController, CalandarDateSelectionDelegate, StatusSelectionDelegate {
    
    private let reuseIdentifier = "ReviewCell"
    let headerView: HeaderView = HeaderView()
    let collectionView: ReviewCollectionView = ReviewCollectionView()
    let dv = DetailFooterView()
    var jobApps: [JobApp] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupCollectionView()
        fetchJobs()

        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        self.collectionView.addGestureRecognizer(lpgr)
        
        headerView.searchButton.addTarget(self, action: #selector(searchButtonTapped(_:)), for: .touchUpInside)
        headerView.statusSelectDelegate = self
    }
    
    @objc func searchButtonTapped(_ sender: UIButton) {
        if let searchText = headerView.searchBar.text {
            if searchText != "" {
                searchJobsByCompany(searchText)
            }
            else{
                fetchJobs()
            }
        }
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            return
        }
        
        let press = gestureReconizer.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: press)
        if let indexPath = indexPath {
            let alert = UIAlertController(title: "Delete Confirm", message: "Do you want to delete this application?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (UIAlertAction) in
                let jobToDelete = self.jobApps[indexPath.item]
                CoreDataManager.shared.deleteJob(jobToDelete)
                CoreDataManager.shared.saveContext()
                self.jobApps.remove(at: indexPath.item)
                self.collectionView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            print("Could not find index path")
        }
    }
    
    private func fetchJobs() {
        do {
            jobApps = try CoreDataManager.shared.fetchJobs()
            collectionView.reloadData()
        } catch {
            print("fetch error")
        }
    }
    
    private func searchJobsByCompany(_ searchText : String) {
        do {
            jobApps = try CoreDataManager.shared.searchJobsByCompany(searchText)
            collectionView.reloadData()
        } catch {
            print("fetch error")
        }
    }
    
    private func searchJobsByDate(from date1: String, to date2: String) {
        do {
            jobApps = try CoreDataManager.shared.searchJobsByDate(from: date1, to: date2)
            collectionView.reloadData()
        } catch {
            print("fetch error")
        }
    }
    
    private func searchJobsByStatus(_ status : Int16) {
        do {
            jobApps = try CoreDataManager.shared.searchJobsByStatus(status)
            collectionView.reloadData()
        } catch {
            print("fetch error")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCollectionView()
        fetchJobs()
    }
    
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
    
    func didSelectDates(from date1: Date, to date2: Date) {
        headerView.dateFilterView.setDate(from: date1, to: date2)
        searchJobsByDate(from: formatter.string(from: date1), to: formatter.string(from: date2))
    }
    
    func didSelectDate(_ date: Date) {
        headerView.dateFilterView.setDate(from: date, to: date)
        searchJobsByDate(from: formatter.string(from: date), to: formatter.string(from: date))
    }
    
    func didSelectStatus(_ status: Int16) {
        searchJobsByStatus(status)
    }
    
    fileprivate func setupHeaderView() {
        self.view.addSubview(headerView)
        headerView.anchors(topAnchor: view.safeAreaLayoutGuide.topAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: nil)
        headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        headerView.presentCalendarView = {
            let calendar = CalendarViewController()
            calendar.calendarDateSelectionDelegate = self
            self.present(calendar, animated: true, completion: nil)
        }
    }
    
    fileprivate func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.view.addSubview(collectionView)
        collectionView.anchors(topAnchor: headerView.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: view.bottomAnchor)
    }
    
}

extension ReviewViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jobApps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReviewCollectionViewCell
        let job = jobApps[indexPath.row]
        cell.updateUI(job: job, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = self.view.bounds.size.width - 24
        let height: CGFloat = self.view.bounds.size.height / 4
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailsViewController()
        detailVC.job = jobApps[indexPath.item]
        present(detailVC, animated: true)
    }
    
    private func printDatabaseStatistics() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.perform {
            if Thread.isMainThread {
                print("on main thread")
            } else {
                print("Off main thread")
            }
            if let numRows = try? context.count(for: JobApp.fetchRequest()) {
                print("# of jobs: \(numRows)")
            }
            
            let fetchRequest: NSFetchRequest<JobApp> = JobApp.fetchRequest()
            if let jobs = try? context.fetch(fetchRequest) {
                for (i, job) in jobs.enumerated() {
                    print("#\(i): \(String(describing: job.name)), \(String(describing: job.phone)), \(String(describing: job.id)),\(String(describing: job.date)),\(String(describing: job.status))")
                }
            }
        }
    }
    
}

protocol StatusSelectionDelegate {
    func didSelectStatus(_ status : Int16)
}

