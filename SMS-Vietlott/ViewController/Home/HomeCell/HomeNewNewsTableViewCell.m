//
//  HomeNewNewsTableViewCell.m
//  SMS-Vietlott
//
//  Created by HuCuBi on 6/3/20.
//  Copyright © 2020 HuCuBi. All rights reserved.
//

#import "HomeNewNewsTableViewCell.h"
#import "HomeNewNewsCollectionViewCell.h"
#import "Utils.h"

@implementation HomeNewNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews {
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HomeNewNewsCollectionViewCell";
    
    HomeNewNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (self.arrayItem) {
        NSDictionary *dict = [Utils converDictRemoveNullValue:self.arrayItem[indexPath.row]];
        
        cell.labelNews.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
        cell.labelTimes.text = [NSString stringWithFormat:@"%@",dict[@"create_time"]];
        
        NSString *linkImage = [Utils convertStringUrl:[NSString stringWithFormat:@"%@",dict[@"img_link"]]];
        [cell.imageNews sd_setImageWithURL:[NSURL URLWithString:linkImage] placeholderImage:[UIImage imageNamed:@"Rectangle 3"]];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = collectionView.frame.size.width*0.7;
    float height = collectionView.frame.size.height;
    
    return CGSizeMake(width, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate pushViewControllerShowDetailItem:[Utils converDictRemoveNullValue:self.arrayItem[indexPath.row]]];
}

@end
