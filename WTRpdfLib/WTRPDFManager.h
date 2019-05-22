//
//  WTRPDFManager.h
//  pdftotxt
//
//  Created by wfz on 2019/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WTRPDFManager : NSObject

//得到总页数 返回-1是提取失败
+(NSInteger)GetNumPagesWithPDFPath:(NSString *)pdfPath;

//得到几页的文字 1～n
+(NSString *)GetStringWithBeginPage:(NSInteger)beginPage EndPage:(NSInteger)endPage PDFPath:(NSString *)pdfPath;

@end

NS_ASSUME_NONNULL_END
