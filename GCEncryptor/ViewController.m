//
//  ViewController.m
//  GCEncryptor
//
//  Created by GWesley on 15/1/23.
//  Copyright (c) 2015年 GWesley. All rights reserved.
//

#import "ViewController.h"
#import "RNEncryptor.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fileUrls = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}



- (IBAction)addItems:(id)sender {
    
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setDirectory:NSHomeDirectory()];
    [panel setAllowsMultipleSelection:YES];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:YES];
    [panel setAllowsOtherFileTypes:YES];
    
    if ([panel runModal] == NSOKButton) {
        
        [self.fileUrls addObjectsFromArray:[panel URLs]];
        [self.tableView reloadData];
    }
}

- (IBAction)encryptor:(id)sender {
    
    if (!self.fileUrls) {
        NSRunAlertPanel(@"提示", @"请添加加密文件", @"OK",@"",@"");
        return;
    }
    
    if ([self.passwordField stringValue].length == 0) {
        NSRunAlertPanel(@"提示", @"请输入加密密码", @"OK",@"",@"");
        return;
    }
    
    for (NSInteger i = 0; i < self.fileUrls.count; i++) {
        NSError *error;
        NSURL *url = [self.fileUrls objectAtIndex:i];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSData *encryptedData = [RNEncryptor encryptData:data
                                            withSettings:kRNCryptorAES256Settings
                                                password:[self.passwordField stringValue]
                                                   error:&error];
        
        NSString *path = [url.path stringByReplacingOccurrencesOfString:url.lastPathComponent withString:[NSString stringWithFormat:@"f%ld.gc",i]];
        
        BOOL complete = [[NSFileManager defaultManager] createFileAtPath:path contents:encryptedData attributes:nil];
        if ((i == (self.fileUrls.count - 1)) && complete) {
            NSRunAlertPanel(@"提示", @"任务已完成", @"OK",@"",@"");
            [self.fileUrls removeAllObjects];
            [self.tableView reloadData];
        }
    }
    
    
    
    
}

#pragma mark - TableView
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if (self.fileUrls) {
        return self.fileUrls.count;
    }
    return 0;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTextField *field = [[NSTextField alloc] init];
    field.bordered = NO;
    field.stringValue = [[self.fileUrls objectAtIndex:row] lastPathComponent];
    return field;
}

@end
