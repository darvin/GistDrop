//
//  GistDropTests.m
//  GistDropTests
//
//  Created by Sergey Klimov on 1/13/13.
//  Copyright (c) 2013 Sergey Klimov. All rights reserved.
//

#import "GistDropTests.h"
#import "GistUploader.h"
#import "Gist.h"


@implementation GistDropTests {
    GistUploader* uploader;
    NSBundle* testBundle;
    NSConditionLock *lock;
}

- (void)setUp
{
    [super setUp];
    
    uploader = [[GistUploader alloc] initForUser:@"gistdrop-testuser" password:@"gistdrop-testpassword"];
    testBundle = [NSBundle bundleForClass:[self class]];
    lock = [NSConditionLock new];
}

- (void)tearDown
{    
    [super tearDown];
}

- (void)testUploadSmallTextFragment
{
    NSString * filename = @"hello.rb";
    NSURL* helloPath = [testBundle URLForResource:@"hello" withExtension:@"rb"];
    NSLog(@"%@", helloPath);
    NSError * error;
    NSString* text = [NSString stringWithContentsOfURL:helloPath encoding:NSUTF8StringEncoding error:&error];
    __block Gist *gist = nil;
    [uploader postText:text filename:filename description:nil callback:^(Gist * g) {
        gist = g;
        [lock unlockWithCondition:1];
    }];
    
    [lock lockWhenCondition:1 beforeDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    STAssertNotNil(gist, @"Gist have to be created");
    STAssertEqualObjects(gist.filename, filename, @"suppose to be named properly");
    NSLog(@"done");
}

- (void)testUploadImage
{
    NSString * filename = @"hello.rb";
    NSURL* helloPath = [testBundle URLForResource:@"hello" withExtension:@"rb"];
    NSLog(@"%@", helloPath);
    NSError * error;
    NSString* text = [NSString stringWithContentsOfURL:helloPath encoding:NSUTF8StringEncoding error:&error];
    __block Gist *gist = nil;
    [uploader postText:text filename:filename description:nil callback:^(Gist * g) {
        gist = g;
        [lock unlockWithCondition:1];
    }];
    
    [lock lockWhenCondition:1 beforeDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    STAssertNotNil(gist, @"Gist have to be created");
    STAssertEqualObjects(gist.filename, filename, @"suppose to be named properly");
    NSLog(@"done");
}





@end
