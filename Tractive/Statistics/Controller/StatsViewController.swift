    //
    //  StatsViewController.swift
    //  Tractive
    //
    //  Created by Sean Chien on 2019-10-09.
    //  Copyright © 2019 Derrick Park. All rights reserved.
    //
    
    import UIKit
    import CoreData
    class StatsViewController: UIViewController {
        
        var jobApps: [JobApp]!
        let one = StatsCategoryView()
        let two = StatsCategoryView()
        let three = StatsCategoryView()
        let four = StatsCategoryView()
        let five = StatsCategoryView()
        let six = StatsCategoryView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .darkGray
            let spacing: CGFloat = 12
            let column: CGFloat = 2
            let width: CGFloat = (view.frame.size.width / column) - (spacing * (column + 1))
            
            one.constraintWidth(equalToConstant: width, heightEqualToConstant: width)
            
            two.constraintWidth(equalToConstant: width, heightEqualToConstant: width)
            
            three.constraintWidth(equalToConstant: width, heightEqualToConstant: width)
            
            four.constraintWidth(equalToConstant: width, heightEqualToConstant: width)
            
            five.constraintWidth(equalToConstant: width, heightEqualToConstant: width)
            
            six.constraintWidth(equalToConstant: width, heightEqualToConstant: width)
            
            let row1 = HorizontalStackView(arrangedSubviews: [one, two], spacing: 20, alignment: .center, distribution: .fillEqually)
            let row2 = HorizontalStackView(arrangedSubviews: [three, four], spacing: 20, alignment: .center, distribution: .fillEqually)
            let row3 = HorizontalStackView(arrangedSubviews: [five, six], spacing: 20, alignment: .center, distribution: .fillEqually)
            let verticalSV = VerticalStackView(arrangedSubviews: [row1, row2, row3], spacing: 20, alignment: .center, distribution: .equalCentering)
            view.addSubview(verticalSV)
            verticalSV.anchors(topAnchor: view.topAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: nil, padding: .init(top: 30, left: 16, bottom: 0, right: 16))
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            loadStats()
        }
        
        func loadStats(){
            do {
                jobApps = try CoreDataManager.shared.fetchJobs()
            } catch {
                print("StatsViewController: fetch error")
            }
            
            let sent = jobApps.filter { $0.status == 0 }.count
            let received = jobApps.filter { $0.status == 1 }.count
            let cancelled = jobApps.filter { $0.status == 2 }.count
            let thisMonth = jobApps.filter {
                let month = Calendar.current.component(.month, from: $0.date!)
                let thisMonth = Calendar.current.component(.month, from: Date())
                return month == thisMonth
            }.count
            let thisYear = jobApps.filter {
                let year = Calendar.current.component(.year, from: $0.date!)
                let thisYear = Calendar.current.component(.year, from: Date())
                return year == thisYear
            }.count
            
            one.statsCategory = StatsCategory(imageIconName: "sent-white", categoryName: "Total Send", stats: sent)
            two.statsCategory = StatsCategory(imageIconName: "recieved-white", categoryName: "Total Received", stats: received)
            three.statsCategory = StatsCategory(imageIconName: "canceled-white", categoryName: "Total Canceled", stats: cancelled)
            four.statsCategory = StatsCategory(imageIconName: "AllIcon", categoryName: "Total Companies", stats: jobApps.count)
            five.statsCategory = StatsCategory(imageIconName: "Group 4", categoryName: "Send this Month", stats: thisMonth)
            six.statsCategory = StatsCategory(imageIconName: "Group 4.1", categoryName: "Send this Year", stats: thisYear)
            
        }
    }
