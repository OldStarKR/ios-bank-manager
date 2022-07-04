//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

final class BankManager {
    private let firstClerk: Clerk
    private var clients: CustomerQueue<Client>
    
    init(firstClerk: Clerk = Clerk(),
         clients: CustomerQueue<Client> = CustomerQueue()) {
        self.firstClerk = firstClerk
        self.clients = clients
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
        let customerNumber = Int.random(
            in: Customer.minimumNumbers...Customer.maximumNumbers
        )
        
        let tickets = Array(1...customerNumber)
        tickets.forEach {
            clients.enqueue(Client(number: $0))
        }
        
        startWork()
        return
    }
    
    private func startWork() {
        var servedClients = 0
        var timeSpent = 0.0
        
        while let client = clients.dequeue() {
            firstClerk.provideService(client)
            servedClients += 1
            timeSpent += EstimatedTime.deposit
        }
        
        finishWork(customers: servedClients, time: timeSpent)
        openBank()
        return
    }
    
    private func finishWork(customers: Int, time: Double) {
        let formattedTime = String(format: "%.2f", time)
        print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(customers)명이며, 총 업무시간은 \(formattedTime)초입니다.")
    }
}