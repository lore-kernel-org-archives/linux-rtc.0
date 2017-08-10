Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36135 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbdHJVFU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 10 Aug 2017 17:05:20 -0400
Date: Thu, 10 Aug 2017 23:05:18 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/4] rtc: pl031: use devm_* for allocating memory and
 mapping resource
Message-ID: <20170810210518.wsmf5jt7fkks7g6y@piout.net>
References: <20170720231745.GE31807@n2100.armlinux.org.uk>
 <E1dYKiF-0001kS-1w@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1dYKiF-0001kS-1w@rmk-PC.armlinux.org.uk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Russell,

On 21/07/2017 at 00:18:31 +0100, Russell King wrote:
> Use the devm_* APIs for allocating memory and mapping the memory in
> the probe function to relieve the driver from having to deal with
> this in the cleanup paths.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/rtc/rtc-pl031.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
> index 0d87b90b1903..5960fbd08b05 100644
> --- a/drivers/rtc/rtc-pl031.c
> +++ b/drivers/rtc/rtc-pl031.c
> @@ -310,8 +310,6 @@ static int pl031_remove(struct amba_device *adev)
>  	device_init_wakeup(&adev->dev, false);
>  	free_irq(adev->irq[0], ldata);
>  	rtc_device_unregister(ldata->rtc);
> -	iounmap(ldata->base);
> -	kfree(ldata);
>  	amba_release_regions(adev);
>  
>  	return 0;
> @@ -322,25 +320,26 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
>  	int ret;
>  	struct pl031_local *ldata;
>  	struct pl031_vendor_data *vendor = id->data;
> -	struct rtc_class_ops *ops = &vendor->ops;
> +	struct rtc_class_ops *ops;

This change should probably go in patch 3/4


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
