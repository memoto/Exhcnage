#import <UIKit/UIKit.h>

@class ExchangeOptionsViewModel;
@class ExchangeCell;
@class ExchangeCellViewModel;

@interface ExchangeOptionsView : UIViewController

@property (readonly, nonatomic, strong) NSArray<ExchangeCell *> *cells;
@property (nonatomic, strong) ExchangeOptionsViewModel *vm;
@property (nonatomic, weak) ExchangeCell *current;

- (void)updateWithOptionViewModel:(ExchangeCellViewModel *)vm;

@end
