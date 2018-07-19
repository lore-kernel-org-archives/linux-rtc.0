Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42059 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeGSLQ6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Jul 2018 07:16:58 -0400
Date: Thu, 19 Jul 2018 12:34:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        t-kristo@ti.com, linux-rtc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org
Subject: Re: [PATCH v4 3/4] rtc: omap: use
 of_device_is_system_power_controller function
Message-ID: <20180719103413.GS10204@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-4-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531372060-10532-4-git-send-email-j-keerthy@ti.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jul 12, 2018 at 10:37:39AM +0530, Keerthy wrote:
> Use of_device_is_system_power_controller instead of manually reading
> the system-power-controller property from the device tree node.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/rtc-omap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index cb19ece..3610efd 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -753,8 +753,7 @@ static int omap_rtc_probe(struct platform_device *pdev)
>  	if (of_id) {
>  		rtc->type = of_id->data;
>  		rtc->is_pmic_controller = rtc->type->has_pmic_mode &&
> -				of_property_read_bool(pdev->dev.of_node,
> -						"system-power-controller");
> +			of_device_is_system_power_controller(pdev->dev.of_node);

Nit: Continuation lines should be indented at least two tabs further,
but in this case an exception seems warranted to keep the line within 80
cols.

>  	} else {
>  		id_entry = platform_get_device_id(pdev);
>  		rtc->type = (void *)id_entry->driver_data;

Reviewed-by: Johan Hovold <johan@kernel.org>
