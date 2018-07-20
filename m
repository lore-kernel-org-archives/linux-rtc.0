Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43320 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbeGTNlv (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 20 Jul 2018 09:41:51 -0400
MIME-Version: 1.0
In-Reply-To: <d03aec28-a33a-5a07-4305-246508185b2b@micronovasrl.com>
References: <20180718094006.105675-1-giulio.benetti@micronovasrl.com>
 <20180718094006.105675-3-giulio.benetti@micronovasrl.com> <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <30d6b568-b785-ae93-9f56-d0a8b7e82901@micronovasrl.com> <CAHp75VchXfm6J+PPcB8ekoXcDktsPUNok3KKBMFyyk9XV=AUyQ@mail.gmail.com>
 <d03aec28-a33a-5a07-4305-246508185b2b@micronovasrl.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 20 Jul 2018 15:53:42 +0300
Message-ID: <CAHp75VdSHdtJA5E=KvkUyij8CcgpyVO1b63-XBR7MnhVeWDpWA@mail.gmail.com>
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

On Thu, Jul 19, 2018 at 9:19 PM, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
> Hi Andy,
>
> Il 18/07/2018 18:26, Andy Shevchenko ha scritto:
>>
>> On Wed, Jul 18, 2018 at 5:06 PM, Giulio Benetti
>> <giulio.benetti@micronovasrl.com> wrote:
>>
>>>>> +       int ret;
>>>>> +
>>>>> +       ret = kstrtobool(buf, &freq_test_en);
>>>>> +       if (ret == -EINVAL) {
>>
>>
>>>> What kind of other error code you may expect and why they are not
>>>> considered as no error?
>>
>>
>>> According to documentation, kstrtobool can only fail with -EINVAL.
>>> See:
>>> https://elixir.bootlin.com/linux/v4.18-rc5/source/lib/kstrtox.c#L332
>>
>>
>> That's correct. So, what do you want to show by explicitly mentioned
>> an error code in the condition?
>>
>
> So you mean I should check for negative values instead of specific error,
> right?

Learn from the existing code.

As you found kstrtobool() returns either 0 (no error), or -EINVAL (the
only possible error code for now).
Checking ret for non-zero is enough.
Thus,

if (ret) {
 ...
 return ret;
}

should do a job.

-- 
With Best Regards,
Andy Shevchenko
