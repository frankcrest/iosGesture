//
//  TapViewController.m
//  iosGestures
//
//  Created by Frank Chen on 2019-05-09.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "TapViewController.h"

@interface TapViewController ()

@end

@implementation TapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 100 / 2, CGRectGetMidY(self.view.bounds) - 100 / 2, 100, 100)];
    view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [view addGestureRecognizer:tapGesture];
    
}

-(void)handleTap:(UITapGestureRecognizer*)sender{
    sender.view.backgroundColor = [sender.view.backgroundColor isEqual:[UIColor purpleColor]] ? [UIColor blueColor] : [UIColor purpleColor];
}


@end
