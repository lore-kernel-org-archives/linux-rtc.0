Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34200 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdH1SNe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 28 Aug 2017 14:13:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id l19so1385192wmi.1
        for <linux-rtc@vger.kernel.org>; Mon, 28 Aug 2017 11:13:33 -0700 (PDT)
Subject: Re: [PATCH] rtc: core: let rtc_set_time properly populate element
 wday
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <3b43da73-ff4e-4519-d1c7-266b17cc5d05@gmail.com>
 <20170826195607.s6p7u7vr3hxhwwqs@piout.net>
 <20170826195947.jnipgyuxg3ceqie4@piout.net>
 <a6ccd0ab-a6f4-1122-233b-61e69b80aa54@gmail.com>
 <7da740e6-b1e0-0a58-8b54-2e5e3e2f6c54@gmail.com>
 <20170828075458.4cdi7pet3yxeskqc@piout.net>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <9a11b823-abe0-6611-9d97-75e2a2ec7745@gmail.com>
Date: Mon, 28 Aug 2017 20:13:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170828075458.4cdi7pet3yxeskqc@piout.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 28.08.2017 um 09:54 schrieb Alexandre Belloni:
> On 27/08/2017 at 21:35:34 +0200, Heiner Kallweit wrote:
>> When having a look at the MCP794XX datasheet it became clear why the
>> mentioned weekday-related patch was submitted. This chip is quite
>> strange regarding the possible alarm match conditions:
>>
>> ALMxMSK<2:0>: Alarm Mask bits
>> 000 = Seconds match
>> 001 = Minutes match
>> 010 = Hours match (logic takes into account 12-/24-hour operation)
>> 011 = Day of week match
>> 100 = Date match
>> 101 = Reserved; do not use
>> 110 = Reserved; do not use
>> 111 = Seconds, Minutes, Hour, Day of Week, Date and Month
>>
>> When not having a proper weekday you get only either seconds or
>> minutes or hours or date match.
>>
>> So it's best to ensure that the weekday is properly populated.
>> However we can do this in the driver and don't have to touch the core.
>>
> 
> Can you do that only for mcp794xx? I received one earlier this month and
> I'll separate the driver from rtc-ds1307.c at some point.
> 
Sure, I'll submit a patch for this. Separating the driver for mcp794xx may
not be needed as it is not that different from the other chips supported
by this driver. Once I have my patch series proposal towards a ds1307_lib
in a little more clean state this should become clearer.

Regards, Heiner

> BTW, I've rebased and pushed some cleanup for this driver in:
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/log/?h=rtc-ds1307
> 
> Can you base yourself on that?
> 
OK

> Thanks,
> 
