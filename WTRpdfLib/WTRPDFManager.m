//
//  WTRPDFManager.m
//  pdftotxt
//
//  Created by wfz on 2019/5/22.
//

#import "WTRPDFManager.h"
#import "WTRxPDFManager.h"

@implementation WTRPDFManager

+(NSInteger)GetNumPagesWithPDFPath:(NSString *)pdfPath
{
    return [WTRxPDFManager GetNumPagesWithPDFPath:pdfPath];
}
+(NSString *)GetStringWithBeginPage:(NSInteger)beginPage EndPage:(NSInteger)endPage PDFPath:(NSString *)pdfPath
{
    return [WTRxPDFManager GetStringWithBeginPage:beginPage EndPage:endPage PDFPath:pdfPath];
}

@end
