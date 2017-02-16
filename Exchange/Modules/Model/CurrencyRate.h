#import <Foundation/Foundation.h>

@interface CurrencyRate : NSObject<NSCopying>

@property (readonly, nonatomic, copy) NSString *currencyID;
@property (readonly, nonatomic, copy) NSNumber *rate;

- (instancetype)initWithCurrencyID:(NSString *)currencyID andRate:(NSNumber *)rate;

+ (instancetype)eur;
+ (instancetype)usd;

@end
