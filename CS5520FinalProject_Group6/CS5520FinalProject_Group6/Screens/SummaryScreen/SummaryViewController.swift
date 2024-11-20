// Created by Yanqiong Ma on 11/19/24.
// Modified by Jiali Han on 11/24/24.
// Improved the data model and implementation of observeTestRecords().
// Reset color design for user experience.

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let summaryView = SummaryView()
    private var testRecords: [[String: Any]] = []
    
    // add
    private var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = summaryView
        title = "Test History"
        view.backgroundColor = UIColor(named: "PrimaryColor")
        
        summaryView.tableView.dataSource = self
        summaryView.tableView.delegate = self
        
        //        fetchTestRecords()
        observeTestRecords() // Use real-time updates
    }
    
    //    private func fetchTestRecords() {
    //        guard let userID = Auth.auth().currentUser?.uid else {
    //            print("User is not logged in")
    //            return
    //        }
    //
    //        let db = Firestore.firestore()
    //        db.collection("tests").whereField("userID", isEqualTo: userID).getDocuments { snapshot, error in
    //            if let error = error {
    //                print("Failed to fetch test records: \(error.localizedDescription)")
    //                return
    //            }
    //
    //            guard let documents = snapshot?.documents else {
    //                print("No test records found")
    //                return
    //            }
    //
    //            self.testRecords = documents.map { $0.data() }
    //            DispatchQueue.main.async {
    //                self.summaryView.tableView.reloadData()
    //            }
    //        }
    //    }
    
    // MARK: order(by: "date", descending: true):
    // Ensures the results are fetched in descending order by date, showing the newest results first.
    // The method remains public, so it can be triggered externally.
    func fetchTestRecords() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("tests")
            .whereField("userID", isEqualTo: userID)
            .order(by: "date", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Failed to fetch test records: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No test records found")
                    self.testRecords = [] // Clear records if no results
                    DispatchQueue.main.async {
                        self.summaryView.tableView.reloadData()
                    }
                    return
                }
                
                // Clear and reload records
                self.testRecords = documents.map { $0.data() }
                DispatchQueue.main.async {
                    self.summaryView.tableView.reloadData()
                }
            }
    }
    
    
    func observeTestRecords() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("User is not logged in")
            return
        }
        
        let db = Firestore.firestore()
        listener = db.collection("tests")
            .whereField("userID", isEqualTo: userID)
            .order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Failed to listen for test records: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No test records found")
                    self.testRecords = [] // Clear records if no results
                    DispatchQueue.main.async {
                        self.summaryView.tableView.reloadData()
                    }
                    return
                }
                
                // Add documentID to each record
                self.testRecords = documents.map { document in
                    var data = document.data()
                    data["documentID"] = document.documentID // Add the document ID
                    return data
                }
                
                DispatchQueue.main.async {
                    self.summaryView.tableView.reloadData()
                }
            }
    }
    
    
    deinit {
        listener?.remove()
    }
    
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestRecordCell",
                                                 for: indexPath) as! TestRecordCell
        let record = testRecords[indexPath.row]
        
        let testName = record["testName"] as? String ?? "Unknown Test"
        let score = record["score"] as? Int ?? 0
        let date = record["date"] as? Timestamp ?? Timestamp(date: Date())
        let dateString = DateFormatter.localizedString(from: date.dateValue(), dateStyle: .medium, timeStyle: .none)
        
        cell.configure(testName: testName, score: score, date: dateString)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected test record
        let selectedRecord = testRecords[indexPath.row]
        
        // Extract data for the selected test record
        let testName = selectedRecord["testName"] as? String ?? "Unknown Test"
        let score = selectedRecord["score"] as? Int ?? 0
        let resultMessage = selectedRecord["resultMessage"] as? String ?? "No result message available"
        
        // Initialize ResultViewController
        let resultVC = ResultViewController()
        resultVC.testName = testName
        resultVC.score = score
        resultVC.resultMessage = resultMessage
        
        // Navigate to ResultViewController
        navigationController?.pushViewController(resultVC, animated: true)
        
        // Deselect the row after navigation
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Swipe-to-Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Get the document ID for the selected record
            let recordToDelete = testRecords[indexPath.row]
            guard let documentID = recordToDelete["documentID"] as? String else {
                print("Error: documentID not found in record")
                return
            }
            
            // Show confirmation alert
            let alert = UIAlertController(
                title: "Confirm Delete",
                message: "Are you sure you want to delete this test result? This action cannot be undone.",
                preferredStyle: .alert
            )
            
            // Add "Yes" action
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { _ in
                // Proceed with deletion
                let db = Firestore.firestore()
                db.collection("tests").document(documentID).delete { error in
                    if let error = error {
                        print("Failed to delete record: \(error.localizedDescription)")
                        return
                    }
                    
                    print("Record deleted successfully from Firestore")
                    
                    
                }
            })
            
            // Add "Cancel" action
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            // Present the alert
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

