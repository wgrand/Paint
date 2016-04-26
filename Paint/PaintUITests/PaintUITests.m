//
//  PaintUITests.m
//  PaintUITests
//
//  Created by William Grand on 4/20/16.
//  Copyright © 2016 William Grand. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PaintUITests : XCTestCase

@end

@implementation PaintUITests

- (void)setUp {
    [super setUp];
    
    // Stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    
    // Launch application
    [[[XCUIApplication alloc] init] launch];
    
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAll {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    // draw dot
    XCUIElement *element = [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element;
    [[[element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] tap];
    
    // open color picker
    XCUIElementQuery *toolbarsQuery = app.toolbars;
    XCUIElement *button = [[toolbarsQuery childrenMatchingType:XCUIElementTypeButton] elementBoundByIndex:0];
    [button tap];
    
    // pick color
    XCUIElement *element2 = [element childrenMatchingType:XCUIElementTypeOther].element;
    [element2 tap];
    
    // apply color
    XCUIElementQuery *navigationBarsQuery = app.navigationBars;
    [navigationBarsQuery.buttons[@"Apply"] tap];
    
    // open color picker
    [button tap];

    // pick same color
    [element2 tap];
    
    // cancel color picker
    [navigationBarsQuery.buttons[@"Cancel"] tap];
    
    // clear drawing
    XCUIElement *clearButton = toolbarsQuery.buttons[@"Clear"];
    [clearButton tap];
    
    // cancel clear drawing
    XCUIElementQuery *collectionViewsQuery = app.alerts[@"Warning"].collectionViews;
    [collectionViewsQuery.buttons[@"No"] tap];
    [clearButton tap];
    
    // confirm clear drawing
    [collectionViewsQuery.buttons[@"Yes"] tap];
    
    // share
    [toolbarsQuery.buttons[@"Share"] tap];
    
}

@end
