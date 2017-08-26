Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35670 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbdHZKRC (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 26 Aug 2017 06:17:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id a47so1200145wra.2
        for <linux-rtc@vger.kernel.org>; Sat, 26 Aug 2017 03:17:01 -0700 (PDT)
Subject: Re: [PATCH 0/5] rtc: ds1307: factor out more stuff from ds1307_probe
 and improve ds1307_set_time
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <cb381496-4d55-996d-e2ae-18880330e386@gmail.com>
 <20170826081904.ibsxi7crvi7qop3m@piout.net>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9ae42f67-9562-16c4-252d-9f629a31b69e@gmail.com>
Date: Sat, 26 Aug 2017 12:16:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170826081904.ibsxi7crvi7qop3m@piout.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 26.08.2017 um 10:19 schrieb Alexandre Belloni:
> Hi,
> 
> Could you explain were you are going with this because this is a lot of
> churn that takes a lot of my reviewing time and this doesn't seem to end
> soon.
> 
> I want that driver to stop growing, maybe by creating a library. Some of
> the supported RTCs doesn't share much more than the time and date layout
> and should be in a separate driver.
> 
That's exactly my point. The driver is too big already.

The patches so far increase size of the driver a little, only subsequent
patches start to reduce it.

More things like even exporting clocks work the same on all chips
supporting this feature. Just the layout of the alarm registers usually is
quite different. Therefore it's my plan to create such a ds1307_lib with all
the generic code.

If it helps I can provide the full patch set (as far as I came so far) via
Github, then you can check whether it's the right direction also from your
point of view (w/o having to review each single patch in detail already).

By the way: This current patch set with the 5 patches I have to change,
so there will be a v2. No need for you to spend reviewing effort on it now.

Regards, Heiner


> On 25/08/2017 at 21:30:09 +0200, Heiner Kallweit wrote:
>> Final goal of the refactoring is to abstract everything that the chips
>> have in common and handle it in generic code. Then we can get rid of
>> all the "switch (chip)" and "if (chip == xxx)" code.
>>
>> To give one example:
>> A lot of chips have a bit for setting 12hr / 24hr mode. However some
>> chips have this config bit in the timekeeping registers, others in
>> a config register, and on some chips it's inverted.
>> But the functionality of the bit is always the same.
>>
>> Ultimately adding support for a chip just requires to add one config
>> structure member.
>>
>> The way to reach this goal is a long one and to faciliate reviewing
>> the patches I'll split them into series of 5 to 10 patches.
>>
>> Heiner Kallweit (5):
>>   rtc: ds1307: factor out determining the chip type
>>   rtc: ds1307: factor out trickle charger initialization
>>   rtc: ds1307: factor out fixing the weekday
>>   rtc: ds1307: introduce constants for the timekeeping register masks
>>   rtc: ds1307: improve ds1307_set_time to respect config flag bits
>>
>>  drivers/rtc/rtc-ds1307.c | 256 ++++++++++++++++++++++++++---------------------
>>  1 file changed, 140 insertions(+), 116 deletions(-)
>>
>> -- 
>> 2.14.1
>>
> 
