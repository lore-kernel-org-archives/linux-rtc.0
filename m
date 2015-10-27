Return-Path: <rtc-linux+bncBDS7HNEFSALRBXMAYCYQKGQEUK2PMFY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q6si487233wiz.0.2015.10.27.15.53.16
        for <rtc-linux@googlegroups.com>;
        Tue, 27 Oct 2015 15:53:16 -0700 (PDT)
Date: Tue, 27 Oct 2015 23:53:15 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 04/19] rtc: isl12057: enable support for the
 standard "wakeup-source" property
Message-ID: <20151027225315.GJ22331@piout.net>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-5-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1445422216-29375-5-git-send-email-sudeep.holla@arm.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 21/10/2015 at 11:10:01 +0100, Sudeep Holla wrote :
> Though the isl12057 rtc driver should and will continue to support the
> legacy "isil,irq2-can-wakeup-machine" property to enable RTC as the
> wakeup source, we need to add support for the new standard property
> "wakeup-source".
> 
> This patch adds support for "wakeup-source" property in addition to the
> existing "isil,irq2-can-wakeup-machine" property.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/rtc/rtc-isl12057.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
Applied, thanks.

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
