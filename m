Return-Path: <rtc-linux+bncBDXZP74YUQEBB57UVS3AKGQE4EMRXKA@googlegroups.com>
Received: from mail-qk0-x234.google.com (mail-qk0-x234.google.com. [2607:f8b0:400d:c09::234])
        by gmr-mx.google.com with ESMTPS id t198si1343529ywe.3.2016.02.22.08.42.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 08:42:30 -0800 (PST)
Received: by mail-qk0-x234.google.com with SMTP id s68so57556439qkh.3
        for <rtc-linux@googlegroups.com>; Mon, 22 Feb 2016 08:42:30 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH] rtc: Add an option to invalidate dates in 2038
To: Arnd Bergmann <arnd@arndb.de>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1455995444-14146-1-git-send-email-alexandre.belloni@free-electrons.com>
 <6269543.oe8MmZQUmX@wuerfel> <20160222155653.GP2222@piout.net>
 <2768647.1bFEcFDZRI@wuerfel>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
 Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
From: "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <56CB3A1D.6030604@gmail.com>
Date: Mon, 22 Feb 2016 11:41:01 -0500
MIME-Version: 1.0
In-Reply-To: <2768647.1bFEcFDZRI@wuerfel>
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

On 2016-02-22 11:18, Arnd Bergmann wrote:
> On Monday 22 February 2016 16:56:53 Alexandre Belloni wrote:
>> One other workaround is to asked distributions
>> using systemd to stop using HCTOSYS so userspace would be responsible to
>> set the system time and in that case we won't have the 32/64 discrepancy.
>
> I'm missing a bit of background here. This seems like a fairly useful
> piece of infrastructure for the majority of the use cases (working RTC)
>
> How would the time get set when this is disabled? Is systemd able
> to read the rtc and write it back to the kernel? That could in fact
> be a nicer workaround for the problem, if it just does this before
> setting up the timerfd.
Traditional init systems on Linux have the option of using hwclock from 
util-linux to set the system time.  This is what Gentoo does by default, 
and I think Arch does it too, and I'm relatively certain that Debian and 
Ubuntu used to do it before they switched to systemd (I have no idea 
what they do now).  Based on the manpage for hwclock, it looks like 
systemd mandates that HCTOSYS is enabled in the kernel configuration, 
and then just calls hwclock to set the system timezone and correct for UTC.

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
