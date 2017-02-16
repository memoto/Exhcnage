#import "ExchangeCellViewModel.h"

@interface ExchangeCellViewModel ()

@property (readwrite, nonatomic) double bid;
//@property (readwrite, nonatomic, copy) CurrencyRate *relativeCurrency;
@property (readwrite, nonatomic, copy) CurrencyRate *currency;
@property (nonatomic, copy) NSArray<CurrencyRate *> *currencyRates;
@property (readwrite, nonatomic, copy) Money *money;
@property (nonatomic) BOOL shouldShowSign;

@end
