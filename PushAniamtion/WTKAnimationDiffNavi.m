//
//  WTKAnimationDiffNavi.m
//  WTKPushAndPopAnimation
//
//  Created by 王同科 on 16/9/27.
//  Copyright © 2016年 王同科. All rights reserved.
//

#import "WTKAnimationDiffNavi.h"
#import "WTKBaseViewController.h"
@implementation WTKAnimationDiffNavi

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController * fromVc   = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc     = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration     = [self transitionDuration:transitionContext];

    CGRect bounds               = [[UIScreen mainScreen] bounds];
    
    fromVc.view.hidden          = YES;

    [[transitionContext containerView] addSubview:toVc.view];
    [[toVc.navigationController.view superview] insertSubview:fromVc.snapshot belowSubview:toVc.navigationController.view];
    toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0);
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVc.snapshot.transform = CGAffineTransformMakeScale(0.95, 0.95);
                         toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(0, 0);
                     }
                     completion:^(BOOL finished) {
                         fromVc.view.hidden = NO;
                         [fromVc.snapshot removeFromSuperview];
                         [transitionContext completeTransition:YES];
    }];

}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {

    WTKBaseViewController * fromVc  = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController * toVc         = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    NSTimeInterval duration         = [self transitionDuration:transitionContext];
    
    CGRect bounds                   = [[UIScreen mainScreen] bounds];


    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(-bounds.size.width, 0, bounds.size.width, bounds.size.height)];
    grayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [[transitionContext containerView] addSubview:grayView];
    grayView.transform = CGAffineTransformIdentity;

    [fromVc.view addSubview:fromVc.snapshot];
    fromVc.navigationController.navigationBar.hidden = YES;
    fromVc.view.transform = CGAffineTransformIdentity;
    
    toVc.view.hidden                = YES;
    toVc.snapshot.transform         = CGAffineTransformMakeScale(0.95, 0.95);



    [[transitionContext containerView] addSubview:toVc.view];
    [[transitionContext containerView] addSubview:toVc.snapshot];
    [[transitionContext containerView] sendSubviewToBack:toVc.snapshot];
    [[transitionContext containerView] bringSubviewToFront:fromVc.snapshot];


    if (fromVc.interactivePopTransition)
    {
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             fromVc.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
                             grayView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
                             toVc.snapshot.transform = CGAffineTransformIdentity;
                             grayView.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {

                             toVc.navigationController.navigationBar.hidden = NO;
                             toVc.view.hidden = NO;

                             [fromVc.snapshot removeFromSuperview];
                             [toVc.snapshot removeFromSuperview];
                             fromVc.snapshot = nil;
                             [grayView removeFromSuperview];
                             if (![transitionContext transitionWasCancelled]) {
                                 toVc.snapshot = nil;

                             }

                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];

    }
    else
    {
        [UIView animateWithDuration:duration
                              delay:0
             usingSpringWithDamping:1
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             fromVc.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
                             grayView.alpha = 0.0;
                             toVc.snapshot.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {

                             toVc.navigationController.navigationBar.hidden = NO;
                             toVc.view.hidden = NO;

                             [fromVc.snapshot removeFromSuperview];
                             [toVc.snapshot removeFromSuperview];
                             [grayView removeFromSuperview];
                             fromVc.snapshot = nil;

                             if (![transitionContext transitionWasCancelled]) {
                                 toVc.snapshot = nil;
                             }

                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }

}

@end
