//
//  NSUserDefaultVC.m
//  沙盒
//
//  Created by qing yun on 15/8/6.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "NSUserDefaultVC.h"

@interface NSUserDefaultVC ()
@property (weak, nonatomic) IBOutlet UISwitch *toggle;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *progressTextField;

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@end

@implementation NSUserDefaultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    
    NSLog(@"%@",NSHomeDirectory());
    // Do any additional setup after loading the view.
}

- (void)loadData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    _toggle.on = [defaults boolForKey:@"switch"];
    
    _progress.progress = [defaults floatForKey:@"progress"];
    
    _label.text = [defaults stringForKey:@"input"];
    
}
- (IBAction)save:(UIBarButtonItem *)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:_toggle.on forKey:@"switch"];
    
    NSString *progress = _progressTextField.text;
    float progressValue = [progress floatValue];
    [defaults setFloat:progressValue forKey:@"progress"];
    
    [defaults setObject:_inputTextField.text forKey:@"input"];
    
    [defaults synchronize];
}
- (IBAction)textFieldDidEndOn:(id)sender {
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
