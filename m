Return-Path: <rtc-linux+bncBCO3XAUMTIFRBXNSV2YQKGQE2HTBIVY@googlegroups.com>
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id mh4si416562igb.0.2015.10.24.07.44.45
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 24 Oct 2015 07:44:45 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: Fix alarm programming for mcp794xx
To: Tero Kristo <t-kristo@ti.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>
References: <1445581797-19693-1-git-send-email-t-kristo@ti.com>
CC: <linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-omap@vger.kernel.org>
From: Nishanth Menon <nm@ti.com>
Message-ID: <562B9955.40308@ti.com>
Date: Sat, 24 Oct 2015 09:44:37 -0500
MIME-Version: 1.0
In-Reply-To: <1445581797-19693-1-git-send-email-t-kristo@ti.com>
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

On 10/23/2015 01:29 AM, Tero Kristo wrote:
> mcp794xx alarm registers must be written in BCD format. However, the
> alarm programming logic neglected this by adding one to the value
> after bin2bcd conversion has been already done, writing bad values
> to month register in case the alarm being set is in October. In this
> case, the alarm month value becomes 0x0a instead of the expected 0x10.
> 
> Fix by moving the +1 addition within the bin2bcd call also.
> 
> Fixes: 1d1945d261a2 ("drivers/rtc/rtc-ds1307.c: add alarm support for mcp7941x chips")
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Nice catch.
Acked-by: Nishanth Menon <nm@ti.com>
> ---
>  drivers/rtc/rtc-ds1307.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index a705e64..188006c 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -718,9 +718,9 @@ static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>  	regs[3] = bin2bcd(t->time.tm_sec);
>  	regs[4] = bin2bcd(t->time.tm_min);
>  	regs[5] = bin2bcd(t->time.tm_hour);
> -	regs[6] = bin2bcd(t->time.tm_wday) + 1;
> +	regs[6] = bin2bcd(t->time.tm_wday + 1);
>  	regs[7] = bin2bcd(t->time.tm_mday);
> -	regs[8] = bin2bcd(t->time.tm_mon) + 1;
> +	regs[8] = bin2bcd(t->time.tm_mon + 1);
>  
>  	/* Clear the alarm 0 interrupt flag. */
>  	regs[6] &= ~MCP794XX_BIT_ALMX_IF;
> 


-- 
Regards,
Nishanth Menon

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
