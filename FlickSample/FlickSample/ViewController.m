//
//  ViewController.m
//  FlickSample
//
//  Created by Dolice on 2013/06/09.
//  Copyright (c) 2013年 Dolice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property NSTimeInterval timestampBegan;
@property CGPoint pointBegan;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //タッチした時間と位置を保存
    UITouch *touch = [touches anyObject];
    _timestampBegan = event.timestamp;
    _pointBegan = [touch locationInView:self.view];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    static const NSTimeInterval kFlickJudgeTimeInterval = 0.3;
    static const NSInteger kFlickMinimumDistance = 10;
    UITouch *touchEnded = [touches anyObject];
    CGPoint pointEnded = [touchEnded locationInView:self.view];
    NSInteger distanceHorizontal = ABS(pointEnded.x - _pointBegan.x);
    NSInteger distanceVertical = ABS(pointEnded.y - _pointBegan.y);
    if (kFlickMinimumDistance > distanceHorizontal && kFlickMinimumDistance > distanceVertical) {
        //縦にも横にもあまり移動していなければreturn
        return;
    }
    NSTimeInterval timeBeganToEnded = event.timestamp - _timestampBegan;
    if (kFlickJudgeTimeInterval > timeBeganToEnded) {
        //フリックした場合の処理
        NSString *message;
        //どの方向にフリックしたかを判定
        if (distanceHorizontal > distanceVertical) {
            if (pointEnded.x > _pointBegan.x) {
                message = @"右フリック";
            } else {
                message = @"左フリック";
            }
        } else {
            if (pointEnded.y > _pointBegan.y) {
                message = @"下フリック";
            } else {
                message = @"上フリック";
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

@end
