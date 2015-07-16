//
//  ViewController.h
//  GCEncryptor
//
//  Created by GWesley on 15/1/23.
//  Copyright (c) 2015年 GWesley. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTextField *passwordField;

@property (weak) IBOutlet NSScrollView *scrollView;

@property (strong) NSMutableArray *fileUrls;
@property (weak) IBOutlet NSTableView *tableView;

- (IBAction)addItems:(id)sender;
- (IBAction)encryptor:(id)sender;
@end

