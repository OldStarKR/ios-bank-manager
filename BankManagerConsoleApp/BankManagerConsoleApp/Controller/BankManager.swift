//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

final class BankManager {
    private let clerk: Clerk
    private var customers: QueueWithLinkedList<Customer>
    
    private let customerGroup = DispatchGroup()
    private let depositSemaphore = DispatchSemaphore(value: NumberOfClerks.deposit)
    private let loanSemaphore = DispatchSemaphore(value: NumberOfClerks.loan)
    
    init(clerk: Clerk = Clerk(),
         customers: QueueWithLinkedList<Customer> = QueueWithLinkedList<Customer>()) {
        self.clerk = clerk
        self.customers = customers
    }
    
    func openBank() {
        print("\(Selections.run) : 은행개점\n\(Selections.dismiss) : 종료")
        print("입력 :", terminator: " ")
        let selection = readLine()
        
        switch selection {
        case Selections.run:
            issueTickets()
            return
        case Selections.dismiss:
            return
        default:
            openBank()
            return
        }
    }
    
    private func issueTickets() {
        let numberOfCustomers = Int.random(
            in: NumberOfCustomers.minimum...NumberOfCustomers.maximum
        )
        
        let tickets = Array(1...numberOfCustomers)
        tickets.forEach {
            if let business = Service.allCases.randomElement() {
                customers.enqueue(Customer(number: $0, business: business))
            }
        }
        
        startWork()
        return
    }
    
    private func startWork() {
        var servedCustomers = 0
        
        let start = DispatchTime.now()
        
        while let customer = customers.dequeue() {
            servedCustomers += 1
            
            DispatchQueue.global().async(group: customerGroup) {
                switch customer.business {
                case .deposit:
                    self.depositSemaphore.wait()
                    self.clerk.provideService(customer)
                    self.depositSemaphore.signal()
                case .loan:
                    self.loanSemaphore.wait()
                    self.clerk.provideService(customer)
                    self.loanSemaphore.signal()
                }
            }
        }
        
        customerGroup.wait()
        
        let end = DispatchTime.now()
        let elapsedTime = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1000000000
        
        showResult(servedCustomers: servedCustomers, elapsedTime: elapsedTime)
        openBank()
        return
    }
    
    private func showResult(servedCustomers: Int, elapsedTime: Double) {
        let formattedTime = String(format: "%.2f", elapsedTime)
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(servedCustomers)명이며, 총 업무시간은 \(formattedTime)초입니다.")
    }
}
