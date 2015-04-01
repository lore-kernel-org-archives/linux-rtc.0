Return-Path: <rtc-linux+bncBDS7HNEFSALRBK6I5WUAKGQETEIVZEQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id el6si944744wib.0.2015.03.31.20.21.14
        for <rtc-linux@googlegroups.com>;
        Tue, 31 Mar 2015 20:21:14 -0700 (PDT)
Date: Wed, 1 Apr 2015 05:21:13 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: __rtc_read_time: reduce log level
Message-ID: <20150401032113.GP3849@piout.net>
References: <1427576976-22353-1-git-send-email-aaro.koskinen@iki.fi>
 <1427576976-22353-2-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1427576976-22353-2-git-send-email-aaro.koskinen@iki.fi>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 28/03/2015 at 23:09:35 +0200, Aaro Koskinen wrote :
> __rtc_read_time logs should be debug logs instead of error logs.
> 
> For example, when the RTC clock is not set, it's not really useful
> to print a kernel error log every time someone tries to read the clock:
> 
> 	~ # hwclock -r
> 	[  604.508263] rtc rtc0: read_time: fail to read
> 	hwclock: RTC_RD_TIME: Invalid argument
> 
> If there's a real error, it's likely that lower level or higher level
> code will tell it anyway. Make these logs debug logs, and also print
> the error code for the read failure.
> 

That actually may be the only error message printed for some failures.
Some RTCs don't print anything in case of error in their .read_time()
and there are in-kernel users of rtc_read_time that simply bail out
without printing anything or have a trace that is already at the debug
level.

I would agree that this would need a better harmonization and I guess we
can do that for now. I'll try to fix the in-kernel cases.

> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/rtc/interface.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 37215cf..c786818 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -31,13 +31,14 @@ static int __rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
>  		memset(tm, 0, sizeof(struct rtc_time));
>  		err = rtc->ops->read_time(rtc->dev.parent, tm);
>  		if (err < 0) {
> -			dev_err(&rtc->dev, "read_time: fail to read\n");
> +			dev_dbg(&rtc->dev, "read_time: fail to read: %d\n",
> +				err);
>  			return err;
>  		}
>  
>  		err = rtc_valid_tm(tm);
>  		if (err < 0)
> -			dev_err(&rtc->dev, "read_time: rtc_time isn't valid\n");
> +			dev_dbg(&rtc->dev, "read_time: rtc_time isn't valid\n");
>  	}
>  	return err;
>  }
> -- 
> 2.2.0
> 

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
