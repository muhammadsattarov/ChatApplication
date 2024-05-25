//
//  WaitingChatsNavigation.swift
//  ChatApp
//
//  Created by user on 22/05/24.
//

import Foundation

protocol WaitingChatsNavigation: AnyObject {
    func removeWaitingChat(chat: MChat)
    func chatToActive(chat: MChat)
}
