Return-Path: <rtc-linux+bncBC2JFQ6TUUPRB7PXSO4QKGQE4HNTGUY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com. [2a00:1450:400c:c09::22b])
        by gmr-mx.google.com with ESMTPS id e64si365974wmi.3.2016.04.30.11.39.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Apr 2016 11:39:57 -0700 (PDT)
Received: by mail-wm0-x22b.google.com with SMTP id g17so83096392wme.1
        for <rtc-linux@googlegroups.com>; Sat, 30 Apr 2016 11:39:57 -0700 (PDT)
Date: Sat, 30 Apr 2016 19:39:54 +0100
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: stmp3xxx: check for failure
Message-ID: <20160430183954.GD25043@sudip-laptop>
References: <1460392435-23803-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20160415210715.GF25196@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160415210715.GF25196@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Apr 15, 2016 at 11:07:15PM +0200, Alexandre Belloni wrote:
> Hi,
> 
> On 11/04/2016 at 22:03:55 +0530, Sudip Mukherjee wrote :
> > stmp3xxx_wdt_register() can fail as platform_device_alloc() or
> > platform_device_add() can fail. Lets check for the return value from
> > both platform_device_alloc() and platform_device_add() and return the
> > error value accordingly which is now propagated from probe.
> > 
> 
> Well, this may have been intentional. The RTC doesn't need the watchdog
> driver to be present to work correctly. However, I agree that failing
> silently is not nice.
> 
> Did you have any particular issue? Maybe simply adding a dev_err() or
> two would be fine.

I didnot have any particular issue. I will send a new patch with some
error message there.

regards
sudip

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
