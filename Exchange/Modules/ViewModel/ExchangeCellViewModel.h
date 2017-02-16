#import <Foundation/Foundation.h>

@class CurrencyRate;
@class Money;

@interface ExchangeCellViewModel : NSObject

// MARK: - Notifier
@property (nonatomic, copy) void(^didChange)(ExchangeCellViewModel *);
@property (nonatomic, copy) void(^didBidChange)(ExchangeCellViewModel *);

// MARK: - Computed props
@property (readonly, nonatomic, getter=isEmpty) BOOL empty;
@property (readonly, nonatomic) double bid;
@property (readonly, nonatomic, copy) NSString *bidText;
@property (readonly, nonatomic, copy) Money *bidMoney;
@property (readonly, nonatomic) double remainingMoney;
@property (readonly, nonatomic, copy) NSString *remainingMoneyText;
@property (readonly, nonatomic, copy) NSString *ratio;
@property (readonly, nonatomic, getter=isOutOfBudget) BOOL outOfBudget;

// MARK: - Stored original passive models
@property (nonatomic, copy) CurrencyRate *relativeCurrency;
@property (readonly, nonatomic, copy) CurrencyRate *currency;
@property (readonly, nonatomic, copy) Money *money;

// MARK: - Construction
- (instancetype)initWithCurrency:(CurrencyRate *)currency andMoney:(Money *)money;

@end
