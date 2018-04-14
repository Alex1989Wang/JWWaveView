//
//  JWWaveViewUITests.m
//  JWWaveViewUITests
//
//  Created by JiangWang on 21/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface JWWaveViewUITests : XCTestCase

@end

@implementation JWWaveViewUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAnimationPauseUnpause {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables/*@START_MENU_TOKEN@*/.staticTexts[@"Multiple Wave Cycles"]/*[[".cells.staticTexts[@\"Multiple Wave Cycles\"]",".staticTexts[@\"Multiple Wave Cycles\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    XCUIElement *pauseAnimationButton = [app descendantsMatchingType:XCUIElementTypeButton][@"Pause Animation"];
    XCTAssertTrue([pauseAnimationButton label]);
    XCTAssertTrue([pauseAnimationButton.label isEqualToString:@"Pause Animation"]);
    [pauseAnimationButton tap];
    XCTAssertFalse(pauseAnimationButton.exists);
    XCUIElement *unpauseAnimationButton = app.buttons[@"Unpause Animation"];
    XCTAssertTrue(unpauseAnimationButton.exists);
    XCTAssertTrue([unpauseAnimationButton.label isEqualToString:@"Unpause Animation"]);
    [unpauseAnimationButton tap];
}

@end
