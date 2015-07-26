//
//  Requests.swift
//  Issues
//
//  Created by Bas Broek on 24/07/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

// MARK: - Issues

/// [GET] issues in all the authenticated user's repository, including their organization(s).
public let issues = "/issues"

/// [GET] issues in owned repositories and member repositories of the authenticated user.
public let userIssues = "/user/issues"

// TODO:

// GET /orgs/:org/issues

public let repos = "/repos"