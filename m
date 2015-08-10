Return-Path: <rtc-linux+bncBDS7HNEFSALRBN65UKXAKGQEMZ7PCOQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ec7si326902wib.3.2015.08.10.07.01.26
        for <rtc-linux@googlegroups.com>;
        Mon, 10 Aug 2015 07:01:26 -0700 (PDT)
Date: Mon, 10 Aug 2015 16:01:26 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: festevam@gmail.com, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: rtc-cmos: Remove unused variable
Message-ID: <20150810140126.GG3411@piout.net>
References: <1439210865-8611-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439210865-8611-1-git-send-email-fabio.estevam@freescale.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Fabio,

Thanks for that patch but I fixed it in tree just a bit before you ;)

On 10/08/2015 at 09:47:44 -0300, Fabio Estevam wrote :
> Remove unused variable 'err' and fix the following build warning:
> 
>  drivers/rtc/rtc-cmos.c:851:7: warning: unused variable 'err' [-Wunused-variable]
> 
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/rtc/rtc-cmos.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index 916bd1f..c2e90c6 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -848,7 +848,6 @@ static int cmos_aie_poweroff(struct device *dev)
>  	 */
>  	if (cmos->alarm_expires == t_now + 1) {
>  		struct rtc_wkalrm alarm;
> -		int err;
>  
>  		/* Cancel the AIE timer by configuring the past time. */
>  		rtc_time64_to_tm(t_now - 1, &alarm.time);
> -- 
> 1.9.1
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
