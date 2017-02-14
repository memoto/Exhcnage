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

@end
