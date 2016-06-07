Return-Path: <rtc-linux+bncBC36JT6HRIDRBQEN3W5AKGQEYKU6XTI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from resqmta-po-04v.sys.comcast.net (resqmta-po-04v.sys.comcast.net. [2001:558:fe16:19:96:114:154:163])
        by gmr-mx.google.com with ESMTPS id k1si1401104itb.1.2016.06.07.15.12.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jun 2016 15:12:15 -0700 (PDT)
Subject: [rtc-linux] Re: linux-4.7-rc2/drivers/rtc/rtc-ds1685.c: 2 * bad if
 test ?
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 David Binderman <linuxdev.baldrick@gmail.com>
References: <CAMzoamZ64+P0Np6WQj-8JYhCw+zXdG-VQ7g2-q80fSS2cq+xyQ@mail.gmail.com>
 <20160607153027.GK3363@piout.net>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, dcb314@hotmail.com
From: Joshua Kinard <kumba@gentoo.org>
Message-ID: <2e0e2f2f-6e19-6727-fbc2-0712e32da18e@gentoo.org>
Date: Tue, 7 Jun 2016 18:12:04 -0400
MIME-Version: 1.0
In-Reply-To: <20160607153027.GK3363@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 06/07/2016 11:30, Alexandre Belloni wrote:
> Hi,
> 
> On 07/06/2016 at 16:18:31 +0100, David Binderman wrote :
>> Hello there,
>>

[snip]

>> Duplicate. Also in the same file:
>>
>> [drivers/rtc/rtc-ds1685.c:265]: (style) Variable 'ctrlb' is assigned a
>> value that is never used.

This looks like it can be removed.  I believe it's a relic of before I added
the handling of either BCD or Binary modes for the SGI Octane's RTC interface.


>> [drivers/rtc/rtc-ds1685.c:812]: (style) Variable 'ctrlc' is assigned a
>> value that is never used.

This needs to be wrapped in #ifdef CONFIG_RTC_DS1685_PROC_REGS, as the value of
'ctrlc' is displayed in /proc/drivers/rtc if that kconfig option is selected on
supported systems.



-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
