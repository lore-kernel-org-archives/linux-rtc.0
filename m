Return-Path: <rtc-linux+bncBDL3F4G2ZAIBB35I66UAKGQE53WDFMI@googlegroups.com>
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id br7si765912pdb.2.2015.04.02.16.44.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 16:44:47 -0700 (PDT)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NM700GP6DYLP630@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Fri, 03 Apr 2015 08:44:45 +0900 (KST)
Message-id: <551DD46C.6030207@samsung.com>
Date: Fri, 03 Apr 2015 08:44:44 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
MIME-version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-samsung-soc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [rtc-linux] Re: [PATCH] rtc: rtc-s3c: Remove one superfluous
 rtc_valid_tm() check
References: <1427985116-20314-1-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1427985116-20314-1-git-send-email-k.kozlowski@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 04/02/2015 11:31 PM, Krzysztof Kozlowski wrote:
> The s3c_rtc_gettime() returns already result of rtc_valid_tm() on
> obtained time so get rid of another call to rtc_valid_tm().
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 1d3a4c58fec4..a0f832362199 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -497,9 +497,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
>  	device_init_wakeup(&pdev->dev, 1);
>  
>  	/* Check RTC Time */
> -	s3c_rtc_gettime(&pdev->dev, &rtc_tm);
> -
> -	if (rtc_valid_tm(&rtc_tm)) {
> +	if (s3c_rtc_gettime(&pdev->dev, &rtc_tm)) {
>  		rtc_tm.tm_year	= 100;
>  		rtc_tm.tm_mon	= 0;
>  		rtc_tm.tm_mday	= 1;
> 

s3c_rtc_gettime() return the value of rtc_valid_tm(). Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi

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
