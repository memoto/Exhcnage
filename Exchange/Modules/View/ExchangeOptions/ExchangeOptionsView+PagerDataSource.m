#import "ExchangeOptionsView+PagerDataSource.h"
#import "ExchangeOptionsViewModel.h"
#import "ExchangeOptionsView.h"
#import "ExchangeCell.h"
#import "ExchangeCellViewModel.h"
#import "Money.h"

@implementation ExchangeOptionsView (PagerDataSource)

- (NSInteger)indexOfCell:(ExchangeCell *)cell {
    NSInteger index = [self.vm.options indexOfObjectPassingTest:
                              ^BOOL(ExchangeCellViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                  
                                  return [obj.money.currencyID isEqualToString:cell.vm.money.currencyID];
                              }];
    return index;
}

- (NSInteger)nextIndexAfter:(ExchangeCell *)cell inForwardDirection:(BOOL)isForward {

    let currentIndex = [self indexOfCell:cell];
    let diff = isForward ? 1 : -1;
    let nextIndex = currentIndex + diff;
    let startIndex = 0;
    let endIndex = self.cells.count - 1;
    let isInRange = nextIndex <= endIndex && nextIndex >= startIndex;
    let recoveredNextIndex = isInRange
    ? nextIndex
    : nextIndex < startIndex
    ? endIndex
    : startIndex;
    
    return recoveredNextIndex;
}

- (ExchangeCell *)nextCellAfter:(ExchangeCell *)cell inForwardDirection:(BOOL)isForward {
    let nextIndex = [self nextIndexAfter:cell inForwardDirection:isForward];
    let nextCell = self.cells[nextIndex];
    
    return nextCell;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    let cell = (ExchangeCell *)viewController;
    
    return [self nextCellAfter:cell inForwardDirection:YES];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    let cell = (ExchangeCell *)viewController;
    
    return [self nextCellAfter:cell inForwardDirection:NO];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    
    return self.cells.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    
    return 0;
}

@end

@implementation ExchangeOptionsView (PagerDelegate)

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    
    if (!finished || !completed) return;
    
    let currentCell = pageViewController.viewControllers[0];
    let currentIndex = [self indexOfCell:currentCell];
    
    self.current = currentCell;
    
    [self.vm selectOptionAtIndex:currentIndex];
}

@end
