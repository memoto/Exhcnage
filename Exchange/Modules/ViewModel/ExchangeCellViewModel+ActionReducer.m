#import "ExchangeCellViewModel+ActionReducer.h"
#import "ExchangeCellViewModel+Private.h"
#import "Money.h"
#import "CurrencyRate.h"
#import "MoneyConverter.h"

@implementation ExchangeCellViewModel (ActionReducer)

- (void)refreshWithCurrencyRates:(NSArray<CurrencyRate *> *)currencyRates {
    
    for (CurrencyRate *currencyRate in currencyRates) {
        if (![currencyRate.currencyID isEqualToString:self.money.currencyID]) continue;
        
        self.currency = currencyRate;
        break;
    }
    self.currencyRates = currencyRates;

    if (!self.didChange) return;
    self.didChange(self);
}

- (void)refreshWithMoney:(Money *)money {
    self.money = money;
    
    if ([money.currencyID isEqualToString:@"EUR"]) {
        self.currency = CurrencyRate.eur;
    }
    
    if (self.currency == nil) {
        self.currency = [CurrencyRate.alloc initWithCurrencyID:self.money.currencyID
                                                       andRate:@1.0];
    }
    
    if (!self.didChange) return;
    self.didChange(self);
}

- (void)refreshWithRelativeCurrency:(NSString *)relCurrency {
    CurrencyRate *relCurrencyRate = nil;
    for (CurrencyRate *currencyRate in self.currencyRates) {
        if (![currencyRate.currencyID isEqualToString:relCurrency]) continue;
        
        relCurrencyRate = currencyRate;
        break;
    }
    
    self.relativeCurrency = relCurrencyRate;
    
    if (!self.didChange) return;
    self.didChange(self);
}

- (void)convertMoney:(Money *)money {
    let oldBid = self.bid;
    if (self.currencyRates == nil) {
        self.bid = money.amount.doubleValue;
    }
    else {
        let converter = [MoneyConverter.alloc initWithRates:self.currencyRates
                                          andTargetCurrency:self.money.currencyID];
        self.bid = [converter moneyConvertedFrom:money].amount.doubleValue;
    }
    self.shouldShowSign = YES;
    
    if (oldBid == self.bid) return;
    if (!self.didChange) return;
    self.didChange(self);
}

- (void)bidInput:(NSString *)bidStr {
    if (bidStr == nil) {
        self.bid = 0;
        self.didChange(self);
        return;
    }
    
    double pBid;
    let scanner = [NSScanner scannerWithString:bidStr];
    if ([scanner scanDouble:&pBid]) {
        let bid = fabs(bidStr.doubleValue);
        self.bid = self.relativeCurrency != nil || bid == 0
                    ? bid
                    : -bid;
    }
    self.shouldShowSign = YES;
    
    if (!self.didChange) return;
    self.didChange(self);
    
    if (!self.didBidChange) return;
    self.didBidChange(self);
}

- (void)didBeginBidInput {
    self.shouldShowSign = NO;
    
    if (!self.didChange) return;
    self.didChange(self);
}

@end
