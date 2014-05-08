//
//  WTMGlyphDetectorView.h
//  WTMGlyphDemo
//
//  Created by Torin Nguyen on 5/7/12.
//  Copyright (c) 2012 torin.nguyen@2359media.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTMGlyphDetector.h"

@class WTMGlyphDetectorView;

@protocol WTMGlyphDetectorViewDelegate <NSObject>
@optional
- (void)wtmGlyphDetectorView:(WTMGlyphDetectorView*)theView glyphDetected:(WTMGlyph *)glyph withScore:(float)score;
- (void)glyphResults:(NSArray *)results;
@end

@interface WTMGlyphDetectorView : UIView
@property (nonatomic, strong) id delegate;
@property (nonatomic, assign) BOOL enableDrawing;
@property (nonatomic, strong) WTMGlyphDetector *glyphDetector;
@property BOOL disableAutoDetection;

- (void)loadTemplatesWithNames:(NSString*)firstTemplate, ... NS_REQUIRES_NIL_TERMINATION;

- (NSString *)getGlyphNamesString;
-(void)logStrokes;

@end
