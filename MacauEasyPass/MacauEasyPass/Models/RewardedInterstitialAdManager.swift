//
//  RewardedInterstitialAdManager.swift
//  TestAPP
//
//  Created by 楊潤泰 on 2023/10/9.
//

import GoogleMobileAds
import SwiftUI

class InterstitialAdManager: NSObject, GADFullScreenContentDelegate, ObservableObject {
    var interstitial: GADInterstitialAd?
    @Published var isAdLoaded: Bool = false // 用來追踪廣告是否已經加載完成
        
    
    override init() {
        super.init()
        loadAd()
    }
    
    func loadAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910", request: request) { (ad, error) in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            self.interstitial = ad
            self.interstitial?.fullScreenContentDelegate = self
            self.isAdLoaded = true // 廣告已經加載完成
        }
    }

    func showAd() {
        if let ad = interstitial, let rootVC = UIApplication.shared.windows.first?.rootViewController {
            ad.present(fromRootViewController: rootVC)
            self.interstitial = nil  // 展示後清空廣告對象
            self.isAdLoaded = false
            loadAd()  // 重新加載廣告以供下次使用
        }
    }
    
    // Delegate methods
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        //
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Failed to present ad with error: \(error.localizedDescription)")
    }
}
