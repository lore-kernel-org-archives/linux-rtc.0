Return-Path: <rtc-linux+bncBDKZNNNLXAHBBL565W5QKGQEFK3LMEQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id un17si307437pab.0.2016.07.05.00.18.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 05 Jul 2016 00:18:07 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O9T00CRCYY25530@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 05 Jul 2016 08:18:02 +0100 (BST)
Subject: [rtc-linux] Re: [RFC PATCH 1/2] rtc: s3c: Remove unnecessary call to
 disable already disabled clock
To: Alim Akhtar <alim.akhtar@samsung.com>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <1467630195-6929-1-git-send-email-alim.akhtar@samsung.com>
Cc: alexandre.belloni@free-electrons.com, javier@osg.samsung.com,
 pankaj.dubey@samsung.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <577B5F28.1010905@samsung.com>
Date: Tue, 05 Jul 2016 09:18:00 +0200
MIME-version: 1.0
In-reply-to: <1467630195-6929-1-git-send-email-alim.akhtar@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/04/2016 01:03 PM, Alim Akhtar wrote:
> At the end of s3c_rtc_probe(), s3c_rtc_disable_clk() being called with rtc
> clock already disabled, which looks extra and unnecessary call.
> Lets clean it up.

Does not look right. Till that place, the clocks are enabled. Then
s3c_rtc_setaie() is called which expects that clocks are disabled...
otherwise counters get mixed.

So overall this looks like wrong approach unless I am missing something?

Best regards,
Krzysztof

> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index d01ad7e..b083840 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -577,8 +577,6 @@ static int s3c_rtc_probe(struct platform_device *pdev)
>  
>  	s3c_rtc_setfreq(info, 1);
>  
> -	s3c_rtc_disable_clk(info);
> -
>  	return 0;
>  
>   err_nortc:

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
