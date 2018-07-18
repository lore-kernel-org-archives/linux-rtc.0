Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:49532 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbeGRSTK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Jul 2018 14:19:10 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 2FEB8B00758
        for <linux-rtc@vger.kernel.org>; Wed, 18 Jul 2018 19:40:12 +0200 (CEST)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y4QkaQLJNHSB for <linux-rtc@vger.kernel.org>;
        Wed, 18 Jul 2018 19:40:11 +0200 (CEST)
Subject: Re: [PATCH v10 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <20180718140946.115093-1-giulio.benetti@micronovasrl.com>
 <20180718140946.115093-3-giulio.benetti@micronovasrl.com>
 <CAHp75VeR8H-XhqkrSxBKoaVwcTx6__w4xpR0x2tm-0dxq9tZrw@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <2a249756-3b3b-2a3e-f293-3a13d586e9ad@micronovasrl.com>
Date: Wed, 18 Jul 2018 19:40:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VeR8H-XhqkrSxBKoaVwcTx6__w4xpR0x2tm-0dxq9tZrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Il 18/07/2018 18:26, Andy Shevchenko ha scritto:
> On Wed, Jul 18, 2018 at 5:09 PM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>> On m41txx you can enable open-drain OUT pin to check if offset is ok.
>> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
>> 512 times faster than 1s tick base.
>>
>> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.
> 
> Taking into consideration the amount of patches per hour you need to
> slow down a bit.
> 

You're right, I'm really sorry about it.

Giulio
