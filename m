Return-Path: <rtc-linux+bncBC2L7GMJYALRBQ6DVK2AKGQEZKGP76I@googlegroups.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com. [2607:f8b0:400e:c03::22f])
        by gmr-mx.google.com with ESMTPS id t69si5756652pfi.1.2016.01.04.08.45.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2016 08:45:55 -0800 (PST)
Received: by mail-pa0-x22f.google.com with SMTP id uo6so179910336pac.1
        for <rtc-linux@googlegroups.com>; Mon, 04 Jan 2016 08:45:55 -0800 (PST)
Subject: [rtc-linux] Re: rtc-palmas: correct for bcd year
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1451508726-31769-1-git-send-email-salyzyn@android.com>
 <20160104161853.GC32724@piout.net>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 rtc-linux@googlegroups.com
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <568AA1C2.2070407@android.com>
Date: Mon, 4 Jan 2016 08:45:54 -0800
MIME-Version: 1.0
In-Reply-To: <20160104161853.GC32724@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/04/2016 08:18 AM, Alexandre Belloni wrote:
> Hi,
>
> On 30/12/2015 at 12:51:45 -0800, Mark Salyzyn wrote :
>> Replace bcd2bin and bin2bcd with one that maps years 1970 to 2129
>> in a pattern that works with the underlying hardware.
>>
>> The only transition that does not work correctly for this rtc clock
>> is the transition from 2099 to 2100, it proceeds to 2000. The rtc
>> clock retains and transitions the year correctly in all other
>> circumstances.
>>
> If that transition doesn't work, it is not useful to try to support
> dates after 2099. Also, I'm concerned about the leap year handling in
> the other case. What is done right now is probably the best however, I
> couldn't find the datasheet to confirm.
>

As it stands today, if I set the date to 1970, it returns 2066, so this 
is a leap(sic) forward for this one rtc clock.

The advantages of supporting 2099+ for being able to set those years and 
not return garbage like in the 1970 case. The failure to roll over from 
2099-2100 is but a millisecond of failure for an additional 1/3 of 
century of well being, and support code is minor, albeit flawed. Without 
these additional four lines, if something sets the year to 2100, they 
will get a garbage back in return, a small price to pay IMHO.

There are dozens and dozens of other bcd-based rtc clocks that could 
gain from this example (and may not have this issue with 2099 rollover), 
so maybe this year code should be in the library?

I will remove 2099+ support if you continue to consider this rollover 
issue egregious given my rationalization.

Sincerely -- Mark Salyzyn

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
