Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:44019 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbeGRREo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Jul 2018 13:04:44 -0400
MIME-Version: 1.0
In-Reply-To: <30d6b568-b785-ae93-9f56-d0a8b7e82901@micronovasrl.com>
References: <20180718094006.105675-1-giulio.benetti@micronovasrl.com>
 <20180718094006.105675-3-giulio.benetti@micronovasrl.com> <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <30d6b568-b785-ae93-9f56-d0a8b7e82901@micronovasrl.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 18 Jul 2018 19:26:03 +0300
Message-ID: <CAHp75VchXfm6J+PPcB8ekoXcDktsPUNok3KKBMFyyk9XV=AUyQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] rtc: ds1307: add frequency_test_enable sysfs
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

On Wed, Jul 18, 2018 at 5:06 PM, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:

>>> +       int ret;
>>> +
>>> +       ret = kstrtobool(buf, &freq_test_en);
>>> +       if (ret == -EINVAL) {

>> What kind of other error code you may expect and why they are not
>> considered as no error?

> According to documentation, kstrtobool can only fail with -EINVAL.
> See:
> https://elixir.bootlin.com/linux/v4.18-rc5/source/lib/kstrtox.c#L332

That's correct. So, what do you want to show by explicitly mentioned
an error code in the condition?

-- 
With Best Regards,
Andy Shevchenko
