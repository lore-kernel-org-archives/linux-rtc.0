Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:57224 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731460AbeISWpW (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 19 Sep 2018 18:45:22 -0400
Date: Wed, 19 Sep 2018 19:06:18 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: a.zummo@towertech.it, andy.shevchenko@gmail.com, robh@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
Message-ID: <20180919170618.GC2479@piout.net>
References: <20180725172605.108040-1-giulio.benetti@micronovasrl.com>
 <20180725172605.108040-4-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725172605.108040-4-giulio.benetti@micronovasrl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 25/07/2018 19:26:05+0200, Giulio Benetti wrote:
> On m41txx you can enable open-drain OUT pin to check if offset is ok.
> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
> 512 times faster than 1s tick base.
> 
> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
> V10 => V11:
> * kstrtobool(): check error if (ret) avoiding checking specific error.
> 
>  drivers/rtc/rtc-ds1307.c | 94 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
