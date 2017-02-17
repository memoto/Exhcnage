#import <Foundation/Foundation.h>

@class ExchangeOptionsViewModel;
@class Wallet;
@class CurrencyRate;

@interface ExchangeMainViewModel : NSObject

@property (nonatomic, strong) ExchangeOptionsViewModel *top;
@property (nonatomic, strong) ExchangeOptionsViewModel *bottom;

@property (nonatomic, copy) void(^didWalletChange)(Wallet *);

- (void)refreshWithWallet:(Wallet *)wallet;
- (void)refreshWithCurrencyRates:(NSArray<CurrencyRate *>*)currencyRates;
- (void)doExchange;

@end
