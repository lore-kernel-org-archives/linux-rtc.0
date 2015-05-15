Return-Path: <rtc-linux+bncBCJ7RPMX4EMBBVMK3KVAKGQEY76AXMI@googlegroups.com>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com. [209.85.213.182])
        by gmr-mx.google.com with ESMTPS id x1si19051igb.2.2015.05.15.16.46.29
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2015 16:46:29 -0700 (PDT)
Received: by igbpi8 with SMTP id pi8so9955560igb.1
        for <rtc-linux@googlegroups.com>; Fri, 15 May 2015 16:46:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1431682292-29732-1-git-send-email-xlpang@126.com>
References: <1431682292-29732-1-git-send-email-xlpang@126.com>
Date: Fri, 15 May 2015 16:46:28 -0700
Message-ID: <CALAqxLW3e79ZHwvO8-R6KJ2gCxKTZ4tnvUSUN8y+gN6UuYctXw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/2] drivers/rtc/interface.c: Change
 rtc_set_mmss() to use time64_t
From: John Stultz <john.stultz@linaro.org>
To: Xunlei Pang <xlpang@126.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
	Xunlei Pang <pang.xunlei@linaro.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, May 15, 2015 at 2:31 AM, Xunlei Pang <xlpang@126.com> wrote:
> From: Xunlei Pang <pang.xunlei@linaro.org>
>
> rtc_set_mmss() uses "unsigned long" as its second parameter which
> may have y2038 problem on 32-bit systems.
>
> Change it to use time64_t.
>
> All its call sites will be changed later(there are no problems
> leaving these call sites untouched).

This line isn't super convincing. Better to explain *why* there aren't
problems making this change first, rather then just asserting it, and
to give some confidence you'll address this, point out that sparc is
the only user of this funciton and will be updated by the following
patch in the series.

thanks
-john

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
