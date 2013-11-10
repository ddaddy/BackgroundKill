//
//  BKViewController.m
//  BackgroundKill
//
//  Created by Darren Jones on 10/11/2013.
//  Copyright (c) 2013 Darren Jones. All rights reserved.
//

#import "BKViewController.h"
#import <mach/mach.h>

@interface BKViewController ()

@property (weak, nonatomic) IBOutlet UIButton *killAllButton;
@property (weak, nonatomic) IBOutlet UILabel *usageLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
- (IBAction)killAllButtonPressed:(id)sender;
@end

@implementation BKViewController {
    NSMutableArray *tmpArray;
    BOOL work;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.statusLabel.text = @"";
    self.usageLabel.text = @"";
    self.activity.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    self.statusLabel.text = @"Did Receive Memory Warning\nThis doesn't mean backgrounded apps have been killed yet\n\nWait for me to crash";
    
    [super didReceiveMemoryWarning];
}

- (IBAction)killAllButtonPressed:(id)sender
{
    if ([self.killAllButton.titleLabel.text isEqualToString:@"Stop"]) {
        
        [self.killAllButton setTitle:@"Kill All Background Apps" forState:UIControlStateNormal];
        self.activity.hidden = YES;
        [self.activity stopAnimating];
        work = NO;
    } else {
    
        [self.killAllButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.activity startAnimating];
        self.activity.hidden = NO;
        work = YES;
        [self loadImage];
    }
}

- (void)loadImage
{
    if (tmpArray == nil)
        tmpArray = [NSMutableArray array];
    
    if (work) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *imagefile = [bundle pathForResource:
                               @"LARGE_elevation" ofType:@"jpg" ];
        
        UIImage *largeImage = [UIImage imageWithContentsOfFile:imagefile];
        
        [tmpArray addObject:[largeImage copy]];
        
#ifdef __LP64__
        self.usageLabel.text = [NSString stringWithFormat:@"Memory usage: %luMB", ([self report_memory] / 1024 / 1024)];
#else
        self.usageLabel.text = [NSString stringWithFormat:@"Memory usage: %uMB", ([self report_memory] / 1024 / 1024)];
#endif
        
        [self performSelector:@selector(loadImage) withObject:nil afterDelay:0.00005];
    }
}

-(vm_size_t)report_memory
{    
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    if( kerr == KERN_SUCCESS ) {
    } else {
        NSLog(@"Error with task_info(): %s", mach_error_string(kerr));
    }
    
    return info.resident_size;
}

@end
