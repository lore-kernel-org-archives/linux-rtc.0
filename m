Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBTGZWHCQKGQEXO2L4IY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id y19si1001565wmd.0.2017.02.21.08.37.32
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Feb 2017 08:37:32 -0800 (PST)
Date: Tue, 21 Feb 2017 17:37:20 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: rtc-linux@googlegroups.com, alex@digriz.org.uk,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH 1/5] rtc: m48t86: verify that the RTC is
 actually present
Message-ID: <20170221163720.m6hp27t4z7q4pgwl@piout.net>
References: <20170215163527.5697-1-hsweeten@visionengravers.com>
 <20170215163527.5697-2-hsweeten@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170215163527.5697-2-hsweeten@visionengravers.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 15/02/2017 at 09:35:23 -0700, H Hartley Sweeten wrote:
> The RTC is an optional feature at purchase time on some Technologic
> Systems boards. Verify that it actually exists by checking if the
> last two bytes of the NVRAM can be changed.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> ---
>  drivers/rtc/rtc-m48t86.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 

I've applied that one. Alex, if you are fine with the mach-orion5x
changes, I can take them for 4.11. Else, this will wait for 4.12.

> diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
> index 4dc4af4..41ac5d6 100644
> --- a/drivers/rtc/rtc-m48t86.c
> +++ b/drivers/rtc/rtc-m48t86.c
> @@ -201,6 +201,37 @@ static ssize_t m48t86_nvram_write(struct file *filp, struct kobject *kobj,
>  static BIN_ATTR(nvram, 0644, m48t86_nvram_read, m48t86_nvram_write,
>  		M48T86_NVRAM_LEN);
>  
> +/*
> + * The RTC is an optional feature at purchase time on some Technologic Systems
> + * boards. Verify that it actually exists by checking if the last two bytes
> + * of the NVRAM can be changed.
> + *
> + * This is based on the method used in their rtc7800.c example.
> + */
> +static bool m48t86_verify_chip(struct platform_device *pdev)
> +{
> +	unsigned int offset0 = M48T86_NVRAM_LEN - 2;
> +	unsigned int offset1 = M48T86_NVRAM_LEN - 1;
> +	unsigned char tmp0, tmp1;
> +
> +	tmp0 = m48t86_readb(&pdev->dev, offset0);
> +	tmp1 = m48t86_readb(&pdev->dev, offset1);
> +
> +	m48t86_writeb(&pdev->dev, 0x00, offset0);
> +	m48t86_writeb(&pdev->dev, 0x55, offset1);
> +	if (m48t86_readb(&pdev->dev, offset1) == 0x55) {
> +		m48t86_writeb(&pdev->dev, 0xaa, offset1);
> +		if (m48t86_readb(&pdev->dev, offset1) == 0xaa &&
> +		    m48t86_readb(&pdev->dev, offset0) == 0x00) {
> +			m48t86_writeb(&pdev->dev, tmp0, offset0);
> +			m48t86_writeb(&pdev->dev, tmp1, offset1);
> +
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
>  static int m48t86_rtc_probe(struct platform_device *pdev)
>  {
>  	struct m48t86_rtc_info *info;
> @@ -231,6 +262,11 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
>  
>  	dev_set_drvdata(&pdev->dev, info);
>  
> +	if (!m48t86_verify_chip(pdev)) {
> +		dev_info(&pdev->dev, "RTC not present\n");
> +		return -ENODEV;
> +	}
> +
>  	info->rtc = devm_rtc_device_register(&pdev->dev, "m48t86",
>  					     &m48t86_rtc_ops, THIS_MODULE);
>  	if (IS_ERR(info->rtc))
> -- 
> 2.10.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
