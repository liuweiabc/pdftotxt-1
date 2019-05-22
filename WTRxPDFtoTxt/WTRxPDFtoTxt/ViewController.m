//
//  ViewController.m
//  WTRxPDFtoTxt
//
//  Created by wfz on 2019/5/22.
//  Copyright © 2019 wfz. All rights reserved.
//

#import "ViewController.h"
#import "WTRxPDFManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSString *pdfPath=[[NSBundle mainBundle] pathForResource:@"qwe" ofType:@"pdf"];

    NSInteger num=[WTRxPDFManager GetNumPagesWithPDFPath:pdfPath];

    NSLog(@"页数:%d",(int)num);

    NSString *str=[WTRxPDFManager GetStringWithBeginPage:1 EndPage:num PDFPath:pdfPath];

    NSLog(@"%@",str);
}


@end
