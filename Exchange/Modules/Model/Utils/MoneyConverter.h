#import <Foundation/Foundation.h>

@class Money;
@class CurrencyRate;

@interface MoneyConverter : NSObject

- (instancetype)initWithRates:(NSArray<CurrencyRate *> *)rates andTargetCurrency:(NSString *)currencyID;

- (Money *)moneyConvertedFrom:(Money *)otherMoney;

@end
