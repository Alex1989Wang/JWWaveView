//
//  JWWaveViewTests.m
//  JWWaveViewTests
//
//  Created by JiangWang on 21/03/2018.
//  Copyright © 2018 JiangWang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <JWWaveView/JWWaveView.h>

@interface JWWaveViewTests : XCTestCase
@property (nonatomic, strong) JWWaveView *testView;
@end

@implementation JWWaveViewTests

- (void)setUp {
    [super setUp];
    _testView = [[JWWaveView alloc] initWithFrame:(CGRect){10, 10, 10, 10}];
    _testView.waveShift = M_PI;
    _testView.waveDuration = 2.0;
    _testView.waveCycles = 1;
    _testView.waveColor = [UIColor yellowColor];
}

- (void)tearDown {
    [super tearDown];
    _testView = nil;
}

- (void)testViewCodingFunctionality {
    //encoding
    NSString *filePath = NSStringFromClass([JWWaveView class]);
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fullPath = [docPath stringByAppendingPathComponent:filePath];
    BOOL archived = [NSKeyedArchiver archiveRootObject:self.testView toFile:fullPath];
    XCTAssertTrue(archived);
    
    //decoding
    JWWaveView *decodedView = [NSKeyedUnarchiver unarchiveObjectWithFile:fullPath];
    XCTAssertTrue(decodedView.waveDuration == self.testView.waveDuration);
    XCTAssertTrue(CGColorEqualToColor(decodedView.waveColor.CGColor, self.testView.waveColor.CGColor));
}


@end
