Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38690 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730897AbeGRRFh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Jul 2018 13:05:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180718140946.115093-3-giulio.benetti@micronovasrl.com>
References: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <20180718140946.115093-1-giulio.benetti@micronovasrl.com> <20180718140946.115093-3-giulio.benetti@micronovasrl.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 18 Jul 2018 19:26:56 +0300
Message-ID: <CAHp75VeR8H-XhqkrSxBKoaVwcTx6__w4xpR0x2tm-0dxq9tZrw@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Jul 18, 2018 at 5:09 PM, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
> On m41txx you can enable open-drain OUT pin to check if offset is ok.
> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
> 512 times faster than 1s tick base.
>
> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.

Taking into consideration the amount of patches per hour you need to
slow down a bit.

-- 
With Best Regards,
Andy Shevchenko
