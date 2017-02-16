#import "CurrencyRate.h"

@interface CurrencyRate ()

@property (readwrite, nonatomic, copy) NSString *currencyID;
@property (readwrite, nonatomic, copy) NSNumber *rate;

@end

@implementation CurrencyRate

- (instancetype)initWithCurrencyID:(NSString *)currencyID andRate:(NSNumber *)rate {
    self = [super init];
    if (self) {
        self.currencyID = currencyID;
        self.rate = rate;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    CurrencyRate *copy = [[[self class] alloc] init];
    
    if (copy) {
        copy.currencyID = self.currencyID;
        copy.rate = self.rate;
    }
    
    return copy;
}

+ (instancetype)eur {
    return [CurrencyRate.alloc initWithCurrencyID:@"EUR" andRate:@1.0];
}

+ (instancetype)usd {
    return [CurrencyRate.alloc initWithCurrencyID:@"USD" andRate:@1.0555];
}

@end
