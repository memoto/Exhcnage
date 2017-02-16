#import "MoneyConverter.h"
#import "Money.h"
#import "CurrencyRate.h"

@interface MoneyConverter ()

@property (nonatomic, copy) NSArray<CurrencyRate *> *rates;
@property (nonatomic, copy) NSString *targetCurrency;

@end

@implementation MoneyConverter

- (instancetype)initWithRates:( NSArray<CurrencyRate *> * _Nonnull)rates andTargetCurrency:(NSString * _Nonnull)targetCurrency {
    self = [super init];
    if (self) {
        self.rates = rates;
        self.targetCurrency = targetCurrency;
    }
    return self;
}

- (Money *)moneyConvertedFrom:(Money *)otherMoney {
    
    let mineRate = [self rateOfCurrency:self.targetCurrency];
    let theirsRate = [self rateOfCurrency:otherMoney.currencyID];
    
    let ratio = theirsRate.rate.doubleValue/mineRate.rate.doubleValue;
    
    let convertedAmount = otherMoney.amount.doubleValue * ratio;
    let convertedMoney = [Money.alloc initWithCurrencyID:self.targetCurrency
                                               andAmount:[NSNumber numberWithDouble:convertedAmount]
                          ];
    return convertedMoney;
}

- (CurrencyRate *)rateOfCurrency:(NSString *)currencyID {
    let index = [self.rates indexOfObjectPassingTest:^BOOL(CurrencyRate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     
        return obj.currencyID == currencyID;
    }];
    if (index == NSNotFound) return nil;
    
    return self.rates[index];
}

@end
