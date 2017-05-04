Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBXOFVTEAKGQEJUOBY5Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f136si112414wme.1.2017.05.04.05.47.25
        for <rtc-linux@googlegroups.com>;
        Thu, 04 May 2017 05:47:25 -0700 (PDT)
Date: Thu, 4 May 2017 14:47:14 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, moritz.fischer@ettus.com,
	linux-watchdog@vger.kernel.org, linux@roeck-us.net, wim@iguana.be,
	a.zummo@towertech.it, rtc-linux@googlegroups.com,
	alex.williams@ni.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: ds1374: wdt: Fix issue with timeout
 scaling from secs to wdt ticks
Message-ID: <20170504124714.hdfsolo7lqvrde7o@piout.net>
References: <1493071512-5718-1-git-send-email-mdf@kernel.org>
 <1493071512-5718-2-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1493071512-5718-2-git-send-email-mdf@kernel.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 24/04/2017 at 15:05:11 -0700, Moritz Fischer wrote:
> Fix commit 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")
> 
> The issue is that the internal counter that triggers the watchdog reset
> is actually running at 4096 Hz instead of 1Hz, therefore the value
> given by userland (in sec) needs to be multiplied by 4096 to get the
> correct behavior.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/rtc/rtc-ds1374.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
