//
//  ChatsViewController.swift
//  ChatApp
//
//  Created by user on 22/05/24.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import FirebaseFirestore

class ChatsViewController: MessagesViewController {
    
    private var messages: [MMessage] = []
    private let user: MUser
    private let chat: MChat
    private var messageListener: ListenerRegistration?
    
    // MARK: - Init
    init(user: MUser, chat: MChat) {
        self.user = user
        self.chat = chat
        super.init(nibName: nil, bundle: nil)
        title = chat.friendUserName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        messageListener?.remove()
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupListener()
        configureMessageInputBar()
    }
    
    private func setupViews() {
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
            layout.photoMessageSizeCalculator.incomingAvatarSize = .zero
            layout.photoMessageSizeCalculator.outgoingAvatarSize = .zero
        }
        view.backgroundColor = .mainColor
        messagesCollectionView.backgroundColor = .mainColor
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    private func setupListener() {
        messageListener = ListenerService.shared.messagesObserve(chat: chat, completion: { result in
            switch result {
            case .success(var message):
                if let url = message.downloadUrl {
                    StorageService.shared.downloadImageData(url: url) { [weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case .success(let image):
                            message.image = image
                            self.insertNewMessage(message: message)
                        case .failure(let error):
                            self.showAlert(with: "Error!", and: error.localizedDescription)
                        }
                    }
                } else {
                    self.insertNewMessage(message: message)
                }
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        })
    }
    
    private func insertNewMessage(message: MMessage) {
        guard !messages.contains(message) else { return }
        messages.append(message)
        messages.sort()
        let isLatestMessage = messages.firstIndex(of: message) == (messages.count - 1)
        let shouldScrollBottom = messagesCollectionView.isAtBottom && isLatestMessage
        messagesCollectionView.reloadData()
        
        if shouldScrollBottom {
            DispatchQueue.main.async {
                self.messagesCollectionView.scrollToLastItem()
            }
        }
    }
    
    func configureMessageInputBar() {
        messageInputBar.isTranslucent = true
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.backgroundView.backgroundColor = .mainColor
        messageInputBar.inputTextView.backgroundColor = .white
        messageInputBar.inputTextView.placeholderTextColor = .lightGray
        messageInputBar.inputTextView.placeholder = "Enter your message"
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 14, left: 15, bottom: 14, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 14, left: 20, bottom: 14, right: 36)
        messageInputBar.inputTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        messageInputBar.inputTextView.layer.borderWidth = 0.2
        messageInputBar.inputTextView.layer.cornerRadius = 18.0
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        messageInputBar.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        messageInputBar.layer.shadowRadius = 5
        messageInputBar.layer.shadowOpacity = 0.3
        messageInputBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        configureSendButton()
        configureCameraIcon()
    }
    
    func configureSendButton() {
        messageInputBar.sendButton.setImage(UIImage(named: "Sent"), for: .normal)
        messageInputBar.setRightStackViewWidthConstant(to: 56, animated: true)
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 6, right: 30)
        messageInputBar.sendButton.setSize(CGSize(width: 48, height: 48), animated: true)
        messageInputBar.middleContentViewPadding.right = -38
    }
    
    func configureCameraIcon() {
        let cameraItem = InputBarButtonItem(type: .system)
        cameraItem.tintColor = #colorLiteral(red: 0.8309458494, green: 0.7057176232, blue: 0.9536159635, alpha: 1)
        let cameraIMage = UIImage(systemName: "camera")
        cameraItem.image = cameraIMage
        
        cameraItem.addTarget(self, action: #selector(didTapCameraButton), for: .primaryActionTriggered)
        cameraItem.setSize(CGSize(width: 60, height: 30), animated: true)
        messageInputBar.leftStackView.alignment = .center
        messageInputBar.setLeftStackViewWidthConstant(to: 50, animated: false)
        messageInputBar.setStackViewItems([cameraItem], forStack: .left, animated: false)
        
    }
    
    // MARK: - Actions
    @objc private func didTapView() {
        view.endEditing(true)
    }
 
    @objc private func didTapCameraButton() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            picker.sourceType = .camera
//        } else {
//            picker.sourceType = .photoLibrary
//        }
        present(picker, animated: true)
    }
    
    private func sendPhoto(image: UIImage) {
        StorageService.shared.uploadImageMessage(photo: image, chat: chat) { result in
            switch result {
            case .success(let url):
                var message = MMessage(user: self.user, image: image)
                message.downloadUrl = url
                FirestoreService.shared.sendMessage(chat: self.chat, message: message) { result in
                    switch result {
                    case .success:
                        self.messagesCollectionView.scrollToLastItem()
                    case .failure(_):
                        self.showAlert(with: "Error!", and: "Image is not available")
                    }
                }
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
    }
}

// MARK: - MessagesDataSource
extension ChatsViewController: MessagesDataSource {
    var currentSender: SenderType {
        return Sender(senderId: user.id, displayName: chat.friendUserName)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.item]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if indexPath.item % 4 == 0 {
            return NSAttributedString(
                string: MessageKitDateFormatter.shared.string(from: message.sentDate),
                attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
                             NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        } else {
            return nil
        }
    }
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

// MARK: - MessagesLayoutDelegate
extension ChatsViewController: MessagesLayoutDelegate {
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if (indexPath.item) % 4 == 0 {
            return 30
        } else {
            return 0
        }
    }
}

// MARK: - MessagesDisplayDelegate
extension ChatsViewController: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : #colorLiteral(red: 0.8309458494, green: 0.7057176232, blue: 0.9536159635, alpha: 1)
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1) : .white
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        return avatarView.isHidden = true
    }
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize? {
        return .zero
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        return .bubble
    }
}

// MARK: - InputBarAccessoryViewDelegate
extension ChatsViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = MMessage(user: user, content: text)
        FirestoreService.shared.sendMessage(chat: chat, message: message) { result in
            switch result {
            case .success:
                self.messagesCollectionView.scrollToLastItem()
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
        inputBar.inputTextView.text = ""
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ChatsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        sendPhoto(image: image)
    }
}


extension UIScrollView {
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInsert = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInsert - scrollViewHeight
        return scrollViewBottomOffset
    }
}
