Return-Path: <rtc-linux+bncBDS7HNEFSALRBIN33GXAKGQE5J3ETBQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt6si14660wib.1.2015.08.20.16.07.13
        for <rtc-linux@googlegroups.com>;
        Thu, 20 Aug 2015 16:07:13 -0700 (PDT)
Date: Fri, 21 Aug 2015 01:07:12 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, a.zummo@towertech.it,
	cw00.choi@samsung.com, k.kozlowski@samsung.com
Subject: [rtc-linux] Re: [PATCH 2/4] rtc: s3c: remove unnecessary NULL assignment
Message-ID: <20150820230712.GD3769@piout.net>
References: <1439292502-22912-1-git-send-email-jy0922.shim@samsung.com>
 <1439292502-22912-2-git-send-email-jy0922.shim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439292502-22912-2-git-send-email-jy0922.shim@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 11/08/2015 at 20:28:20 +0900, Joonyoung Shim wrote :
> It's unnecessary the code that assigns info->rtc_clk to NULL in
> s3c_rtc_remove.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c | 1 -
>  1 file changed, 1 deletion(-)
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
