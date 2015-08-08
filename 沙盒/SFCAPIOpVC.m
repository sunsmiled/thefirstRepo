//
//  SFCAPIOpVC.m
//  沙盒
//
//  Created by qing yun on 15/8/6.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "SFCAPIOpVC.h"



#define kFileName    @"CAPIFile.txt"
#define BUFSIZE      256

@interface SFCAPIOpVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic,strong) NSString *filePath;
@end

@implementation SFCAPIOpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self miscInit];
    [self loadDatas];
    // Do any additional setup after loading the view.
}


- (void)miscInit
{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _filePath = [docPath stringByAppendingPathComponent:kFileName];
    
}

- (void)loadDatas
{
    const char *path = [_filePath UTF8String];
    FILE *fp = fopen(path, "r");
    if (fp == NULL) {
        perror("fopen");
        return;
    }
    
    fseek(fp, 0, SEEK_END);
    long size = ftell(fp);
    
    rewind(fp);
    char buf[BUFSIZE] = {0};
    size_t count = fread(buf, size, 1, fp);
    
    if (count > 0) {
        _textField.text = [NSString stringWithUTF8String:buf];
        
    }
    
    fclose(fp);
}

- (IBAction)saveData:(UIBarButtonItem *)sender {
    
    const char *path = [_filePath UTF8String];
    FILE *fp = fopen(path, "w+");
    if (fp == NULL) {
        perror("fopen");
        return;
    }
    
    NSString *content = _textField.text;
    
    size_t count = fwrite([content UTF8String], content.length, 1, fp);
    if (count > 0) {
        NSLog(@"保存文件成功");
    }
    
    fclose(fp);
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
