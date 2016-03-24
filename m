Return-Path: <rtc-linux+bncBDS7HNEFSALRBTO72G3QKGQE2B5PA2Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v68si35074wmd.1.2016.03.24.15.53.01
        for <rtc-linux@googlegroups.com>;
        Thu, 24 Mar 2016 15:53:01 -0700 (PDT)
Date: Thu, 24 Mar 2016 23:52:51 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnaud Ebalard <arno@natisbad.org>
Cc: rtc-linux@googlegroups.com, Jason Cooper <jason@lakedaemon.net>,
	Sudeep Holla <Sudeep.Holla@arm.com>
Subject: [rtc-linux] Re: Intersil ISL12057 driver
Message-ID: <20160324225251.GK2570@piout.net>
References: <20160323171003.GE2570@piout.net>
 <878u18hp79.fsf@natisbad.org>
 <87lh57ldgv.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <87lh57ldgv.fsf@natisbad.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 24/03/2016 at 23:26:24 +0100, Arnaud Ebalard wrote :
> 1) Handling of the century bit
> 

This indeed needs fixing and it is quite simple. Do you care sending a
patch?

> 2) Alarm:
> 

[...]

Well, my bad, your analysis is correct and I was thinking
8bc2a40730ec74271a0573a6882871308d069f5d was in 4.5 but it will actually
be in 4.6:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8bc2a40730ec74271a0573a6882871308d069f5d

This should solve that one. And you are right, I should probably do
something more generic in the framework to handle "wakeup-source".

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
