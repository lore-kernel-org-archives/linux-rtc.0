Return-Path: <rtc-linux+bncBCGLJQVNREJBBSFA5OWQKGQEWNJSGZI@googlegroups.com>
Received: from mailgw01.mediatek.com ([210.61.82.183])
        by gmr-mx.google.com with ESMTPS id ys2si531501pac.0.2015.07.30.18.32.55
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jul 2015 18:32:56 -0700 (PDT)
Message-ID: <1438306372.26690.2.camel@mtksdaap41>
Subject: [rtc-linux] Re: [PATCH] rtc: mt6397: implement suspend/resume
 function in rtc-mt6397 driver
From: Eddie Huang <eddie.huang@mediatek.com>
To: Henry Chen <henryc.chen@mediatek.com>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Alessandro
 Zummo" <a.zummo@towertech.it>, Matthias Brugger <matthias.bgg@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<rtc-linux@googlegroups.com>, <linux-kernel@vger.kernel.org>
Date: Fri, 31 Jul 2015 09:32:52 +0800
In-Reply-To: <1438267994-13934-1-git-send-email-henryc.chen@mediatek.com>
References: <1438267994-13934-1-git-send-email-henryc.chen@mediatek.com>
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

On Thu, 2015-07-30 at 22:53 +0800, Henry Chen wrote:
> Implement the suspend/resume function in order to control rtc's irq_wake flag and handle as wakeup source.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index c0090b6..9f6c9f8 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -373,6 +373,31 @@ static int mtk_rtc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int mt6397_rtc_suspend(struct device *dev)
> +{
> +	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq_wake(rtc->irq);
> +
> +	return 0;
> +}
> +
> +static int mt6397_rtc_resume(struct device *dev)
> +{
> +	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_wake(rtc->irq);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
> +			mt6397_rtc_resume);
> +
>  static const struct of_device_id mt6397_rtc_of_match[] = {
>  	{ .compatible = "mediatek,mt6397-rtc", },
>  	{ }
> @@ -382,6 +407,7 @@ static struct platform_driver mtk_rtc_driver = {
>  	.driver = {
>  		.name = "mt6397-rtc",
>  		.of_match_table = mt6397_rtc_of_match,
> +		.pm = &mt6397_pm_ops,
>  	},
>  	.probe	= mtk_rtc_probe,
>  	.remove = mtk_rtc_remove,

It looks good to me.

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
