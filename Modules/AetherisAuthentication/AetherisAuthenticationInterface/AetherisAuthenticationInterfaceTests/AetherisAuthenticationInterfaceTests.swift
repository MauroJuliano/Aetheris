//
//  AetherisAuthenticationInterfaceTests.swift
//  AetherisAuthenticationInterfaceTests
//
//  Created by maclau on 24/02/26.
//

import Testing
@testable import AetherisAuthenticationInterface

@MainActor
struct AetherisAuthenticationInterfaceTests {
    @Test
    func sessionStore_startsLoggedOutAndPublishesAuthenticationChanges() {
        let sut = AppSessionStore()

        #expect(sut.isAuthenticated == false)

        sut.isAuthenticated = true

        #expect(sut.isAuthenticated == true)
    }

    @Test
    func tabBarVisibilityStore_startsVisibleAndAllowsTogglingVisibility() {
        let sut = TabBarVisibilityStore()

        #expect(sut.isVisible == true)

        sut.isVisible = false

        #expect(sut.isVisible == false)
    }
}
