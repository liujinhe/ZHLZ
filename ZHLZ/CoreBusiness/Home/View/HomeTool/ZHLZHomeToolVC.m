//
//  ZHLZHomeToolVC.m
//  ZHLZ
//
//  Created by apple on 2019/12/9.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeToolVC.h"

@interface ZHLZHomeToolVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *speedTextFile;
@property (weak, nonatomic) IBOutlet UITextField *widthTextFile;
@property (weak, nonatomic) IBOutlet UITextField *areaTextFile;


@property (weak, nonatomic) IBOutlet UIView *value1View;
@property (weak, nonatomic) IBOutlet UIView *value2View;
@property (weak, nonatomic) IBOutlet UIView *value3View;
@property (weak, nonatomic) IBOutlet UIView *value4View;
@property (weak, nonatomic) IBOutlet UIView *value5View;
@property (weak, nonatomic) IBOutlet UIView *value6View;

@property (weak, nonatomic) IBOutlet UILabel *value1Label;
@property (weak, nonatomic) IBOutlet UILabel *value2Label;
@property (weak, nonatomic) IBOutlet UILabel *value3Label;
@property (weak, nonatomic) IBOutlet UILabel *value5Label;
@property (weak, nonatomic) IBOutlet UILabel *value6Label;
@property (weak, nonatomic) IBOutlet UILabel *value4Label;


@property (weak, nonatomic) IBOutlet UITextView *msgTextView;


@end

@implementation ZHLZHomeToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"占道施工围蔽长度检查核算";
    
    self.value1View.layer.cornerRadius = 7.5f;
    self.value2View.layer.cornerRadius = 7.5f;
    self.value3View.layer.cornerRadius = 7.5f;
    self.value4View.layer.cornerRadius = 7.5f;
    self.value5View.layer.cornerRadius = 7.5f;
    self.value6View.layer.cornerRadius = 7.5f;
    
    [self.msgTextView setEditable:NO];
    [self.msgTextView setSelectable:NO];
    
    self.speedTextFile.delegate = self;
    self.widthTextFile.delegate = self;
    self.areaTextFile.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangeValue:) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - Notification

- (void)textFieldChangeValue:(NSNotification *)notification
{
    if (notification.object == self.speedTextFile) {
        
        if ([self.speedTextFile.text isNotBlank]) {
            
            //限制速度
            [self setlimitWithSpeed:[self.speedTextFile.text intValue]];
            
            //警告区
            [self setwarningWithSpeed:[self.speedTextFile.text intValue]];
            
            //缓冲区
            [self setBufferWithLimitSpeed:[self.value1Label.text intValue]];
            
            //终止区
            [self setTerminationWithLimitSpeed:[self.value1Label.text intValue]];
            
            //上游过渡区
            if ([self.widthTextFile.text isNotBlank]) {
                [self setUpstreamWithSpeed:[self.speedTextFile.text intValue] andWidth:[self.widthTextFile.text intValue]];
            }
            
        } else {
            self.value1Label.text = @"0";
            self.value2Label.text = @"0";
            self.value4Label.text = @"0";
            self.value6Label.text = @"0";
            self.value3Label.text = @"0";
        }
 
    } else if (notification.object == self.widthTextFile) {
        
        if ([self.widthTextFile.text isNotBlank]) {
            //上游过渡区
            if ([self.speedTextFile.text isNotBlank]) {
                [self setUpstreamWithSpeed:[self.speedTextFile.text intValue] andWidth:[self.widthTextFile.text intValue]];
            }
            
            //下游过渡区
            [self setDownstreamWithWidth:[self.widthTextFile.text intValue]];
        }
        
        else {
            self.value3Label.text = @"0";
            self.value5Label.text = @"0";
        }
        
    }
}

- (void)setUpstreamWithSpeed:(int)spped andWidth:(int)width{
    if (spped <= 60) {
        self.value3Label.text = [NSString stringWithFormat:@"%.2f",(spped * spped * width) / 155.00 ];
    } else {
        self.value3Label.text = [NSString stringWithFormat:@"%.2f",spped * width * 0.625];
    }
}


- (void)setDownstreamWithWidth:(int)width {
    self.value5Label.text = [NSString stringWithFormat:@"%.2f",width * 3.75];
}


- (void)setTerminationWithLimitSpeed:(int)limitSpeed{
    if (limitSpeed <= 40) {
        self.value6Label.text = @"10 ~ 30";
    } else {
        self.value6Label.text = @"30";
    }
}


- (void)setBufferWithLimitSpeed:(int)limitSpeed{
    if (limitSpeed <= 30) {
        self.value4Label.text = @"15";
    } else if (limitSpeed > 30 && limitSpeed <= 40){
        self.value4Label.text = @"40";
    } else if (limitSpeed > 40 && limitSpeed <= 60){
        self.value4Label.text = @"80";
    } else if (limitSpeed > 60){
        self.value4Label.text = @"120";
    }
}

- (void)setwarningWithSpeed:(int)speed{
    if (speed <= 60) {
        self.value2Label.text = @"40";
    } else if (speed > 60 && speed <= 80) {
        self.value2Label.text = @"100";
    }else if (speed > 80 && speed <= 100) {
        self.value2Label.text = @"1000";
    }else if (speed > 100) {
        self.value2Label.text = @"--";
    }
}


- (void)setlimitWithSpeed:(int)speed{
    if (speed <= 20) {
        self.value1Label.text = @"20";
        
    } else if (speed > 20 && speed <= 50){
        self.value1Label.text = @"30";
        
    } else if (speed > 50 && speed <= 60){
        self.value1Label.text = @"40";
        
    } else if (speed > 60 && speed < 80){
        self.value1Label.text = @"60";
        
    } else if (speed >= 80 && speed < 100){
        self.value1Label.text = @"70";
        
    } else if (speed >= 100){
        self.value1Label.text = @"80";
    }
}

@end
