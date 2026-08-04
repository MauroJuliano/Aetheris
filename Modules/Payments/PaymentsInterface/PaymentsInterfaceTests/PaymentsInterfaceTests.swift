//
//  PaymentsInterfaceTests.swift
//  PaymentsInterfaceTests
//
//  Created by maclau on 25/02/26.
//

import Testing
@testable import PaymentsInterface

struct PaymentsInterfaceTests {
    @Test
    func tabBarVisibilityStore_startsVisibleAndAcceptsVisibilityChanges() {
        let sut = TabBarVisibilityStore()

        #expect(sut.isVisible == true)

        sut.isVisible = false

        #expect(sut.isVisible == false)
    }
}
