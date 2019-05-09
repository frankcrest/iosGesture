//
//  EdgePanViewController.m
//  iosGestures
//
//  Created by Frank Chen on 2019-05-09.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "EdgePanViewController.h"

@interface EdgePanViewController ()

@property (nonatomic, assign)CGPoint originalCenter;
@property (nonatomic, assign)CGPoint originalOpenCenter;
@property (nonatomic, assign)CGPoint maxCenter;
@property (nonatomic,assign)CGPoint maxPanCenter;
@property (nonatomic,weak)UIView* greenBox;
@property (nonatomic,weak)UIScreenEdgePanGestureRecognizer* edgeRecog;
@property (nonatomic,weak)UIPanGestureRecognizer* panGesture;

@end

@implementation EdgePanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor greenColor];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view];
    
    UIScreenEdgePanGestureRecognizer* edgeRecog = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleEdge:)];
    edgeRecog.edges = UIRectEdgeRight;
    [view addGestureRecognizer:edgeRecog];
    self.edgeRecog = edgeRecog;
    self.greenBox = view;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [view.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                                              [view.heightAnchor constraintEqualToConstant:300],
                                              [view.widthAnchor constraintEqualToConstant:300],
                                              [view.leadingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-10],
                                              ]];
}

- (void)viewDidLayoutSubviews{
    self.originalCenter = self.greenBox.center;
    self.maxCenter = CGPointMake(self.originalCenter.x - 100, self.originalCenter.y);
}

-(void)handleEdge:(UIScreenEdgePanGestureRecognizer*)sender{
    NSLog(@"edge");
    CGPoint translationInView = [sender translationInView: self.view];
    CGPoint oldCenter = sender.view.center;
    CGPoint newCenter =  CGPointMake(oldCenter.x + translationInView.x, oldCenter.y);
    sender.view.center = newCenter;
    [sender setTranslation:CGPointZero inView:self.view];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (sender.view.center.x > self.maxCenter.x) {
            sender.view.center = self.originalCenter;
        } else{
            sender.view.center = CGPointMake(self.view.frame.size.width - 150, self.originalCenter.y);
            self.originalOpenCenter = sender.view.center;
            self.maxPanCenter = CGPointMake(sender.view.center.x + 100, self.originalCenter.y);
            [self.greenBox removeGestureRecognizer: self.edgeRecog];
            UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
            self.panGesture = panGesture;
            [self.greenBox addGestureRecognizer:panGesture];
        }
    }
}

-(void)handlePan:(UIPanGestureRecognizer*)sender{
    NSLog(@"pan");
    CGPoint translationInView = [sender translationInView: self.view];
    CGPoint oldCenter = sender.view.center;
    CGPoint newCenter =  CGPointMake(oldCenter.x + translationInView.x, oldCenter.y);
    sender.view.center = newCenter;
    [sender setTranslation:CGPointZero inView:self.view];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (sender.view.center.x > self.maxPanCenter.x) {
            sender.view.center = self.originalCenter;
            [self.greenBox removeGestureRecognizer:(self.panGesture)];
            UIScreenEdgePanGestureRecognizer* edgeRecog = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleEdge:)];
            edgeRecog.edges = UIRectEdgeRight;
            [self.greenBox addGestureRecognizer:edgeRecog];
            self.edgeRecog = edgeRecog;
        } else{
            sender.view.center = self.originalOpenCenter;
        }
    }
}
@end
