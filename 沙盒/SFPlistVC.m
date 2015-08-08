//
//  SFPlistVC.m
//  沙盒
//
//  Created by qing yun on 15/8/6.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SFPlistVC.h"

#define kFileName       @"SFPlist.plist"
@interface SFPlistVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong) NSString *filePath;

@end

@implementation SFPlistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self miscInit];
    [self loadData];
    // Do any additional setup after loading the view.
}


- (void)miscInit
{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _filePath = [docPath stringByAppendingPathComponent:kFileName];
    NSLog(@"%@",_filePath);
    
}


- (void)loadData
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:_filePath];
    NSLog(@"%@",dict);
    
    _label.text = dict[@"textField"];
}
- (IBAction)save:(UIBarButtonItem *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"textField"] = _textField.text;
    dict[@"foo"] = @"bar"   ;
    dict[@"name"] = @"zhangsan";
    dict[@"age"] = @18;
    dict[@"date"] = [NSDate date];
    
    BOOL result = [dict writeToFile:_filePath atomically:YES];
    if (result) {
        NSLog(@"保存文件成功");
    }
}
- (IBAction)textViewDidEndOn:(UITextField *)sender {
    
    [self resignFirstResponder];
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
