//
//  SFOCAPIs.m
//  沙盒
//
//  Created by qing yun on 15/8/6.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SFOCAPIs.h"
#define kFileName      @"OCFileAPIs.txt"
@interface SFOCAPIs ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic,strong ) NSString *filePath;
@end

@implementation SFOCAPIs

- (void)viewDidLoad {
    [super viewDidLoad];
    [self miscInit];
    [self loadData];
    // Do any additional setup after loading the view.
}


- (void)miscInit
{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *testDirectory = [docPath stringByAppendingPathComponent:@"test"];
    NSError *error;
    [manager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:0 error:&error];
    if (error) {
        NSLog(@"%@",error);
        return;
    }
    
    _filePath = [testDirectory stringByAppendingPathComponent:@"kFileName"];
    if (![manager fileExistsAtPath:_filePath]) {
        [manager createFileAtPath:_filePath contents:nil attributes:0];
        NSLog(@"%@",_filePath);
    }
}


- (void) loadData
{
    NSError *error;
    _textField.text = [[NSString alloc] initWithContentsOfFile:_filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%@",error);
        return;
    }
}
- (IBAction)save:(UIBarButtonItem *)sender {
    
    NSString *content = _textField.text;
    NSError *error ;
    [content writeToFile:_filePath atomically:YES encoding:NSUTF8StringEncoding error:&error    ];
    if (error) {
        NSLog(@"%@",error);
        return;
    }
    NSLog(@"保存成功");
}

- (IBAction)textFieldDidEndOnExit:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
