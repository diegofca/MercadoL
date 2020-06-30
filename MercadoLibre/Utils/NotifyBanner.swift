//  NotifyBanner.swift
//  MercadoLibre
//
//  Created by MacBook Pro on 28/06/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.

import Foundation
import NotificationBannerSwift

class NotifyBanner {
    
    class func showBanner(title: String?, subtitle: String?, style: BannerStyle) {
        let banner1 = FloatingNotificationBanner(title: title,
                                                 subtitle: subtitle,
                                                 style: .success)
        banner1.duration = 1
        banner1.show(queuePosition: .front, bannerPosition: .top, queue: .init(maxBannersOnScreenSimultaneously: 1))
    }
    
}
