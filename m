Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:53980 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731960AbeGSTDl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Jul 2018 15:03:41 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id B50BCB008FF
        for <linux-rtc@vger.kernel.org>; Thu, 19 Jul 2018 20:19:19 +0200 (CEST)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gSta1hASQT8E for <linux-rtc@vger.kernel.org>;
        Thu, 19 Jul 2018 20:19:18 +0200 (CEST)
Subject: Re: [PATCH v9 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180718094006.105675-1-giulio.benetti@micronovasrl.com>
 <20180718094006.105675-3-giulio.benetti@micronovasrl.com>
 <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <30d6b568-b785-ae93-9f56-d0a8b7e82901@micronovasrl.com>
 <CAHp75VchXfm6J+PPcB8ekoXcDktsPUNok3KKBMFyyk9XV=AUyQ@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <d03aec28-a33a-5a07-4305-246508185b2b@micronovasrl.com>
Date: Thu, 19 Jul 2018 20:19:17 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VchXfm6J+PPcB8ekoXcDktsPUNok3KKBMFyyk9XV=AUyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Andy,

Il 18/07/2018 18:26, Andy Shevchenko ha scritto:
> On Wed, Jul 18, 2018 at 5:06 PM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
> 
>>>> +       int ret;
>>>> +
>>>> +       ret = kstrtobool(buf, &freq_test_en);
>>>> +       if (ret == -EINVAL) {
> 
>>> What kind of other error code you may expect and why they are not
>>> considered as no error?
> 
>> According to documentation, kstrtobool can only fail with -EINVAL.
>> See:
>> https://elixir.bootlin.com/linux/v4.18-rc5/source/lib/kstrtox.c#L332
> 
> That's correct. So, what do you want to show by explicitly mentioned
> an error code in the condition?
> 

So you mean I should check for negative values instead of specific 
error, right?

Thanks

Giulio
