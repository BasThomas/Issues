//
//  IssueKitTests.swift
//  IssueKitTests
//
//  Created by Bas Broek on 29/06/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import XCTest
import IssueKit

class IssueKitTests: XCTestCase {
  
  var json1 = ""
    
  override func setUp() {
    super.setUp()
    
    self.json1 = "[{\"url\": \"https://api.github.com/repos/deltafhict/mirror-docs/issues/1\", \"labels_url\": \"https://api.github.com/repos/deltafhict/mirror-docs/issues/1/labels{/name}\", \"comments_url\": \"https://api.github.com/repos/deltafhict/mirror-docs/issues/1/comments\", \"events_url\": \"https://api.github.com/repos/deltafhict/mirror-docs/issues/1/events\", \"html_url\": \"https://github.com/deltafhict/mirror-docs/issues/1\", \"id\": 90371960, \"number\": 1, \"title\": \"werkt nie\", \"user\": { \"login\": \"BasThomas\", \"id\": 4190298, \"avatar_url\": \"https://avatars.githubusercontent.com/u/4190298?v=3\", \"gravatar_id\": \"\", \"url\": \"https://api.github.com/users/BasThomas\", \"html_url\": \"https://github.com/BasThomas\", \"followers_url\": \"https://api.github.com/users/BasThomas/followers\", \"following_url\": \"https://api.github.com/users/BasThomas/following{/other_user}\", \"gists_url\": \"https://api.github.com/users/BasThomas/gists{/gist_id}\", \"starred_url\": \"https://api.github.com/users/BasThomas/starred{/owner}{/repo}\", \"subscriptions_url\": \"https://api.github.com/users/BasThomas/subscriptions\", \"organizations_url\": \"https://api.github.com/users/BasThomas/orgs\", \"repos_url\": \"https://api.github.com/users/BasThomas/repos\", \"events_url\": \"https://api.github.com/users/BasThomas/events{/privacy}\", \"received_events_url\": \"https://api.github.com/users/BasThomas/received_events\", \"type\": \"User\", \"site_admin\": false }, \"labels\": [{\"url\": \"https://api.github.com/repos/deltafhict/mirror-docs/labels/bug\", \"name\": \"bug\", \"color\": \"fc2929\" }, { \"url\": \"https://api.github.com/repos/deltafhict/mirror-docs/labels/enhancement\", \"name\": \"enhancement\", \"color\": \"84b6eb\" }, { \"url\": \"https://api.github.com/repos/deltafhict/mirror-docs/labels/help%20wanted\", \"name\": \"help wanted\", \"color\": \"159818\" }, { \"url\": \"https://api.github.com/repos/deltafhict/mirror-docs/labels/invalid\", \"name\": \"invalid\", \"color\": \"e6e6e6\" }, { \"url\": \"https://api.github.com/repos/deltafhict/mirror-docs/labels/question\", \"name\": \"question\", \"color\": \"cc317c\" }], \"state\": \"closed\", \"locked\": false, \"assignee\": { \"login\": \"NBoymanns\", \"id\": 6572980, \"avatar_url\": \"https://avatars.githubusercontent.com/u/6572980?v=3\", \"gravatar_id\": \"\", \"url\": \"https://api.github.com/users/NBoymanns\", \"html_url\": \"https://github.com/NBoymanns\", \"followers_url\": \"https://api.github.com/users/NBoymanns/followers\", \"following_url\": \"https://api.github.com/users/NBoymanns/following{/other_user}\", \"gists_url\": \"https://api.github.com/users/NBoymanns/gists{/gist_id}\", \"starred_url\": \"https://api.github.com/users/NBoymanns/starred{/owner}{/repo}\", \"subscriptions_url\": \"https://api.github.com/users/NBoymanns/subscriptions\", \"organizations_url\": \"https://api.github.com/users/NBoymanns/orgs\", \"repos_url\": \"https://api.github.com/users/NBoymanns/repos\", \"events_url\": \"https://api.github.com/users/NBoymanns/events{/privacy}\", \"received_events_url\": \"https://api.github.com/users/NBoymanns/received_events\", \"type\": \"User\", \"site_admin\": false }, \"milestone\": { \"url\": \"https://api.github.com/repos/deltafhict/mirror-docs/milestones/1\", \"html_url\": \"https://github.com/deltafhict/mirror-docs/milestones/nu!!!\", \"labels_url\": \"https://api.github.com/repos/deltafhict/mirror-docs/milestones/1/labels\", \"id\": 1177200, \"number\": 1,\"title\": \"nu!!!\", \"description\": null, \"creator\": { \"login\": \"BasThomas\", \"id\": 4190298, \"avatar_url\": \"https://avatars.githubusercontent.com/u/4190298?v=3\", \"gravatar_id\": \"\", \"url\": \"https://api.github.com/users/BasThomas\", \"html_url\": \"https://github.com/BasThomas\", \"followers_url\": \"https://api.github.com/users/BasThomas/followers\", \"following_url\": \"https://api.github.com/users/BasThomas/following{/other_user}\", \"gists_url\": \"https://api.github.com/users/BasThomas/gists{/gist_id}\", \"starred_url\": \"https://api.github.com/users/BasThomas/starred{/owner}{/repo}\", \"subscriptions_url\": \"https://api.github.com/users/BasThomas/subscriptions\", \"organizations_url\": \"https://api.github.com/users/BasThomas/orgs\", \"repos_url\": \"https://api.github.com/users/BasThomas/repos\", \"events_url\": \"https://api.github.com/users/BasThomas/events{/privacy}\", \"received_events_url\": \"https://api.github.com/users/BasThomas/received_events\", \"type\": \"User\", \"site_admin\": false }, \"open_issues\": 0, \"closed_issues\": 1, \"state\": \"open\", \"created_at\": \"2015-06-23T12:18:50Z\", \"updated_at\": \"2015-06-23T12:43:20Z\", \"due_on\": null, \"closed_at\": null }, \"comments\": 2, \"created_at\": \"2015-06-23T12:18:16Z\", \"updated_at\": \"2015-06-23T12:43:20Z\", \"closed_at\": \"2015-06-23T12:43:20Z\", \"body\": \"fix plz!!!\"}]"
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testJSON() {
//    let parser = ParseController.sharedInstance
//    parser.parseIssues(self.json1)
  }
}