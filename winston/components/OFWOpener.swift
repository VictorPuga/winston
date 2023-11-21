//
//  OFWOpener.swift
//  winston
//
//  Created by Igor Marcossi on 30/07/23.
//

import SwiftUI

class OpenFromWeb: ObservableObject {
  static var shared = OpenFromWeb()
  @Published var data: RedditURLType?
}

struct OFWOpener: View {
  @ObservedObject var router: Router
  
  @ObservedObject private var OFW = OpenFromWeb.shared
  
  var body: some View {
    EmptyView()
      .onChange(of: router.path) { _ in
        if OpenFromWeb.shared.data != nil {
          OpenFromWeb.shared.data = nil
        }
      }
      .onChange(of: OFW.data) { link in
        if let link = link {
          switch link {
          case .post(let id, let subreddit):
            if router.firstSelected == nil {
              router.firstSelected = .post(PostViewPayload(post: Post(id: id, api: RedditAPI.shared), sub: Subreddit(id: subreddit, api: RedditAPI.shared)))
            } else {
              router.path.append(PostViewPayload(post: Post(id: id, api: RedditAPI.shared), sub: Subreddit(id: subreddit, api: RedditAPI.shared)))
            }
          case .subreddit(let name):
            if router.firstSelected == nil {
              router.firstSelected = .sub(Subreddit(id: name, api: RedditAPI.shared))
            } else {
              router.path.append(SubredditPostsContainerPayload(sub: Subreddit(id: name, api: RedditAPI.shared)))
            }
          case .user(let username):
            if router.firstSelected == nil {
              router.firstSelected = .user(User(id: username, api: RedditAPI.shared))
            } else {
              router.path.append(User(id: username, api: RedditAPI.shared))
            }
          default:
            break
          }
        }
      }
  }
}
