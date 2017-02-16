#import "ExchangeCellViewModel.h"
#import "ExchangeCellViewModel+Private.h"
#import "CurrencyRate.h"
#import "Money.h"
#import <Foundation/Foundation.h>

@implementation ExchangeCellViewModel

- (BOOL)isEmpty {

    return self.money == nil;
}

- (Money *)bidMoney {
    let absBid = self.bid;
    let amount = [NSNumber numberWithDouble:absBid];
    let money = [Money.alloc initWithCurrencyID:self.money.currencyID andAmount:amount];
    
    return money;
}

- (NSString *)bidText {
    let sign = self.shouldShowSign && self.bid != 0
                ? self.bid > 0
                    ? @"+"
                    : @"-"
                : @"";
    let absBid = fabs(self.bid);
    let str = [NSString stringWithFormat:@"%@%.2f", sign,absBid];
    return str;
}

- (NSString *)remainingMoneyText {
    // TODO: make string
    let moneyStr = self.money.text;
    let str = [NSString stringWithFormat:@"You have %@", moneyStr];
    
    return str;
}
   
- (double)remainingMoney {
    let money = self.money;
    return money.amount.doubleValue;
}

- (NSString *)ratio {
    if (self.relativeCurrency == nil) return nil;
    
    let toRatio = @1.0;
    let fromRatio = [NSNumber numberWithDouble:
                     self.relativeCurrency.rate.doubleValue/self.currency.rate.doubleValue];
    
    let toMoney = [Money.alloc initWithCurrencyID:self.currency.currencyID andAmount:toRatio];
    let fromMoney = [Money.alloc initWithCurrencyID:self.relativeCurrency.currencyID andAmount:fromRatio];
    
    return [NSString stringWithFormat:@"%@ = %@",
            toMoney.text,
            fromMoney.text];
}

- (BOOL)isOutOfBudget {
    return ![self.money isGreaterThanOther:self.requiredMoney];
}

- (instancetype)initWithCurrency:(CurrencyRate *)currency andMoney:(Money *)money {
    
    self = [super init];
    if (self) {
        self.currency = currency;
        self.money = money;
        self.bid = 0;
        self.shouldShowSign = NO;
    }
    return self;
}

// helpers

- (Money *)requiredMoney {
    let money = [Money.alloc initWithCurrencyID:self.currency.currencyID andAmount:[NSNumber numberWithDouble:-self.bid]];
    return money;
}

@end
