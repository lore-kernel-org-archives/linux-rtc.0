Return-Path: <rtc-linux+bncBDS7HNEFSALRBF536KZAKGQE5PLCFNA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id d185si703409wmf.0.2015.11.30.11.03.51
        for <rtc-linux@googlegroups.com>;
        Mon, 30 Nov 2015 11:03:51 -0800 (PST)
Date: Mon, 30 Nov 2015 20:03:50 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Geliang Tang <geliangtang@163.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: fix module reference count in rtc-proc
Message-ID: <20151130190350.GI22136@piout.net>
References: <9d57abe4fe1acdbc4a63496142ea4b78f152e621.1446868545.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <9d57abe4fe1acdbc4a63496142ea4b78f152e621.1446868545.git.geliangtang@163.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 07/11/2015 at 12:00:21 +0800, Geliang Tang wrote :
> rtc-proc.c is not built as a module. Thus, rather than dealing with
> THIS_MODULE's reference count, we should deal with rtc->owner's
> reference count.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  drivers/rtc/rtc-proc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
Both patches are applied, thanks.

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
