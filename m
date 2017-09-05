Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37386 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdIEF1R (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 5 Sep 2017 01:27:17 -0400
Received: by mail-wm0-f54.google.com with SMTP id u26so13024043wma.0
        for <linux-rtc@vger.kernel.org>; Mon, 04 Sep 2017 22:27:17 -0700 (PDT)
Subject: Re: [PATCH 0/5] rtc: ds1307: factor out more stuff from ds1307_probe
 and improve ds1307_set_time
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
 <20170826081904.ibsxi7crvi7qop3m@piout.net>
 <9ae42f67-9562-16c4-252d-9f629a31b69e@gmail.com>
 <20170826104457.sdeeacwgboeectpw@piout.net>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <6e668a34-1211-f828-9e79-ab91338a3b14@gmail.com>
Date: Tue, 5 Sep 2017 07:27:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170826104457.sdeeacwgboeectpw@piout.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 26.08.2017 um 12:44 schrieb Alexandre Belloni:
> On 26/08/2017 at 12:16:53 +0200, Heiner Kallweit wrote:
>> That's exactly my point. The driver is too big already.
>>
>> The patches so far increase size of the driver a little, only subsequent
>> patches start to reduce it.
>>
>> More things like even exporting clocks work the same on all chips
>> supporting this feature. Just the layout of the alarm registers usually is
>> quite different. Therefore it's my plan to create such a ds1307_lib with all
>> the generic code.
>>
>> If it helps I can provide the full patch set (as far as I came so far) via
>> Github, then you can check whether it's the right direction also from your
>> point of view (w/o having to review each single patch in detail already).
>>
> 
> Yes, please do that.
> 
I rebased the patch set on top of your latest ds1307 changes and published
it here: https://github.com/hkallweit/linux_rtc_ds1307/tree/rtc-ds1307

Most code went into a new rtc-ds1307-lib library in a generic form, the driver
contains mainly chip configuration info now plus chip-specific routines for
reading / setting alarm.
Now it would require very little effort to e.g. make ds3231 a separate driver
because the hwmon code is needed for this chip only.

Regards,
Heiner

>> By the way: This current patch set with the 5 patches I have to change,
>> so there will be a v2. No need for you to spend reviewing effort on it now.
>>
> 
> Ok, thanks.
> 
