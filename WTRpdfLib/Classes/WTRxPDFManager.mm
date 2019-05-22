//
//  WTRxPDFManager.m
//  NXPDF
//
//  Created by wfz on 2019/5/22.
//  Copyright © 2019 wfz. All rights reserved.
//

#import "WTRxPDFManager.h"

int pdfinfomain(int argc, char *argv[]);
int pdftotxtmain(int argc, char *argv[]);

@interface WTRxPDFManager()

@end

static id _s;
@implementation WTRxPDFManager
{
    NSString *RootPath;
    NSString *xpdfrcp;
}
+(WTRxPDFManager *)sharedInstance
{
    @synchronized (self) {
        if (!_s) {
            _s=[[[self class] alloc] init];
        }
    }
    return _s;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *path  = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        RootPath=[[path lastObject] stringByAppendingPathComponent:@"pdftotxt"];
        [[NSFileManager defaultManager] removeItemAtPath:RootPath error:nil];
    }
    return self;
}

-(void)checkRootPath
{
    xpdfrcp=[RootPath stringByAppendingPathComponent:@"xpdfrc"];

    BOOL isdir;
    BOOL isin=[[NSFileManager defaultManager] fileExistsAtPath:RootPath isDirectory:&isdir];

    if (!isin||!isdir) {
        [[NSFileManager defaultManager] removeItemAtPath:RootPath error:nil];
        [[NSFileManager defaultManager] createDirectoryAtPath:RootPath withIntermediateDirectories:YES attributes:nil error:nil];

        NSBundle *bundle = [NSBundle bundleForClass:[WTRxPDFManager class]];
        NSString *bpath=[bundle pathForResource:@"WTRXPDF" ofType:@"bundle"];
        NSBundle *xpdfBundle = [NSBundle bundleWithPath:bpath];

        NSString *xpdfrcPath=[xpdfBundle pathForResource:@"xpdfrc" ofType:@"txt"];

        NSString *xpdfrcStr=[NSString stringWithContentsOfFile:xpdfrcPath encoding:NSUTF8StringEncoding error:nil];

        xpdfrcStr=[xpdfrcStr stringByReplacingOccurrencesOfString:@"@Library" withString:RootPath]; //每次启动路径会变 所以每次启动必须得重写一次
        [xpdfrcStr writeToFile:xpdfrcp atomically:YES encoding:NSUTF8StringEncoding error:nil];

        NSString *ypath=[xpdfBundle pathForResource:@"xpdf-chinese-simplified" ofType:@""];
        NSString *xFontsPath=[NSString stringWithFormat:@"%@/xFonts",RootPath];
        [[NSFileManager defaultManager] copyItemAtPath:ypath toPath:xFontsPath error:nil];
    }
}
+(NSInteger)GetNumPagesWithPDFPath:(NSString *)pdfPath
{
    return [[self sharedInstance] GetNumPagesWithPDFPath:pdfPath];
}
-(NSInteger)GetNumPagesWithPDFPath:(NSString *)pdfPath
{
    if (!pdfPath||![pdfPath isKindOfClass:[NSString class]]) {
        return -1;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:pdfPath]) {

        [self checkRootPath];

        NSString *command=[NSString stringWithFormat:@"pdf -f 1 -l 1 -cfg %@ %@",xpdfrcp,pdfPath];
        NSArray *arr=[command componentsSeparatedByString:@" "];
        char *argv[arr.count];
        for (int i=0; i<arr.count; i++) {
            NSString *cstr=arr[i];
            argv[i]=(char *)cstr.UTF8String;
        }
        int ret=pdfinfomain((int)arr.count,argv);
        return ret;
    }
    return -1;
}
+(NSString *)GetStringWithBeginPage:(NSInteger)beginPage EndPage:(NSInteger)endPage PDFPath:(NSString *)pdfPath
{
    return  [[self sharedInstance] GetStringWithBeginPage:beginPage EndPage:endPage PDFPath:pdfPath];
}
-(NSString *)GetStringWithBeginPage:(NSInteger)beginPage EndPage:(NSInteger)endPage PDFPath:(NSString *)pdfPath
{
    if (!pdfPath||![pdfPath isKindOfClass:[NSString class]]) {
        return @"";
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:pdfPath]) {

        [self checkRootPath];

        NSString *txtpath=[RootPath stringByAppendingPathComponent:@"out.txt"];
        NSString *command=[NSString stringWithFormat:@"pdf -f %d -l %d -cfg %@ %@ %@",(int)beginPage,(int)endPage,xpdfrcp,pdfPath,txtpath];
        NSArray *arr=[command componentsSeparatedByString:@" "];
        char *argv[arr.count];
        for (int i=0; i<arr.count; i++) {
            NSString *cstr=arr[i];
            argv[i]=(char *)cstr.UTF8String;
        }
        int ret=pdftotxtmain((int)arr.count,argv);
        if (ret==0) {
            NSString *str=[NSString stringWithContentsOfFile:txtpath encoding:NSUTF8StringEncoding error:nil];
            return str;
        }
        return @"";
    }
    return @"";
}


@end
