Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:50698 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbeGTNy0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 20 Jul 2018 09:54:26 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 4153CB008F0
        for <linux-rtc@vger.kernel.org>; Fri, 20 Jul 2018 15:06:13 +0200 (CEST)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WYzJ8_Fwe4D2 for <linux-rtc@vger.kernel.org>;
        Fri, 20 Jul 2018 15:06:12 +0200 (CEST)
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
 <d03aec28-a33a-5a07-4305-246508185b2b@micronovasrl.com>
 <CAHp75VdSHdtJA5E=KvkUyij8CcgpyVO1b63-XBR7MnhVeWDpWA@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <27a1d79b-7651-4896-58f7-73ff73b14c22@micronovasrl.com>
Date: Fri, 20 Jul 2018 15:06:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VdSHdtJA5E=KvkUyij8CcgpyVO1b63-XBR7MnhVeWDpWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Il 20/07/2018 14:53, Andy Shevchenko ha scritto:
> On Thu, Jul 19, 2018 at 9:19 PM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>> Hi Andy,
>>
>> Il 18/07/2018 18:26, Andy Shevchenko ha scritto:
>>>
>>> On Wed, Jul 18, 2018 at 5:06 PM, Giulio Benetti
>>> <giulio.benetti@micronovasrl.com> wrote:
>>>
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       ret = kstrtobool(buf, &freq_test_en);
>>>>>> +       if (ret == -EINVAL) {
>>>
>>>
>>>>> What kind of other error code you may expect and why they are not
>>>>> considered as no error?
>>>
>>>
>>>> According to documentation, kstrtobool can only fail with -EINVAL.
>>>> See:
>>>> https://elixir.bootlin.com/linux/v4.18-rc5/source/lib/kstrtox.c#L332
>>>
>>>
>>> That's correct. So, what do you want to show by explicitly mentioned
>>> an error code in the condition?
>>>
>>
>> So you mean I should check for negative values instead of specific error,
>> right?
> 
> Learn from the existing code.
> 
> As you found kstrtobool() returns either 0 (no error), or -EINVAL (the
> only possible error code for now).
> Checking ret for non-zero is enough.
> Thus,
> 
> if (ret) {
>   ...
>   return ret;
> }
> 
> should do a job.
> 

Oh, I was pretty sure I've found an example of kstrtobool() in the way 
I've used, instead no.
Thanks for pointing me.
I correct it.

Best regards
Giulio
