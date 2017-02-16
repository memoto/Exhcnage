#import "ExchangeMainViewModel.h"

@class CurrencyRate;
@class Wallet;

@interface ExchangeMainViewModel (ActionReducer)

- (void)refreshWithCurrencyRates:(NSArray<CurrencyRate *>*)currencyRates;
- (void)refreshWithWallet:(Wallet *)wallet;
- (void)doExchange;

@end
