Return-Path: <rtc-linux+bncBCGLJQVNREJBBHXW2OWAKGQENGQTMMI@googlegroups.com>
Received: from mailgw01.mediatek.com ([210.61.82.183])
        by gmr-mx.google.com with ESMTPS id w7si532270pdq.0.2015.07.02.01.49.33
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Jul 2015 01:49:34 -0700 (PDT)
Message-ID: <1435826955.21679.2.camel@mtksdaap41>
Subject: [rtc-linux] Re: [PATCH] rtc-mt6397: enable wakeup before registering
 rtc device
From: Eddie Huang <eddie.huang@mediatek.com>
To: Wei-Ning Huang <wnhuang@chromium.org>
CC: LKML <linux-kernel@vger.kernel.org>, Wei-Ning Huang <wnhuang@google.com>,
	<a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<rtc-linux@googlegroups.com>
Date: Thu, 2 Jul 2015 16:49:15 +0800
In-Reply-To: <1435826216-11982-1-git-send-email-wnhuang@google.com>
References: <1435826216-11982-1-git-send-email-wnhuang@google.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, 2015-07-02 at 16:36 +0800, Wei-Ning Huang wrote:
> rtc_sysfs_add_device checks if device can wakeup before creating the
> wakealarm file in sysfs. Thus the driver must set wakeup capability
> before registering the rtc device.
> 
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index c0090b6..eab230b 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -343,6 +343,8 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  		goto out_dispose_irq;
>  	}
>  
> +	device_init_wakeup(&pdev->dev, 1);
> +
>  	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
>  					   &mtk_rtc_ops, THIS_MODULE);
>  	if (IS_ERR(rtc->rtc_dev)) {
> @@ -351,8 +353,6 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  		goto out_free_irq;
>  	}
>  
> -	device_init_wakeup(&pdev->dev, 1);
> -
>  	return 0;
>  
>  out_free_irq:

Thanks your correction.

Acked-by: Eddie Huang <eddie.huang@mediatek.com>


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
