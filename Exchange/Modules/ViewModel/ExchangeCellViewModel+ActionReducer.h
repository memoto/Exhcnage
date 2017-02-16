#import "ExchangeCellViewModel.h"

@interface ExchangeCellViewModel (ActionReducer)

- (void)refreshWithCurrencyRates:(NSArray<CurrencyRate *>*)currencyRates;
- (void)refreshWithMoney:(Money *)money;
- (void)convertMoney:(Money *)money;
- (void)bidInput:(NSString *)bidStr;
- (void)didBeginBidInput;

@end
