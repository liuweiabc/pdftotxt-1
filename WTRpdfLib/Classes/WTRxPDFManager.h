//
//  WTRxPDFManager.h
//  NXPDF
//
//  Created by wfz on 2019/5/22.
//  Copyright © 2019 wfz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WTRxPDFManager : NSObject

//得到总页数 返回-1是提取失败
+(NSInteger)GetNumPagesWithPDFPath:(NSString *)pdfPath;

//得到几页的文字 1～n
+(NSString *)GetStringWithBeginPage:(NSInteger)beginPage EndPage:(NSInteger)endPage PDFPath:(NSString *)pdfPath;

@end

NS_ASSUME_NONNULL_END
