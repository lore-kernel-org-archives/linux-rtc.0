Return-Path: <SRS0=I/F0=UW=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED3C43613
	for <linux-rtc@archiver.kernel.org>; Sun, 23 Jun 2019 12:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2910820665
	for <linux-rtc@archiver.kernel.org>; Sun, 23 Jun 2019 12:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfFWMiv (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 23 Jun 2019 08:38:51 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42703 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFWMiu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 23 Jun 2019 08:38:50 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5BEA920005;
        Sun, 23 Jun 2019 12:38:44 +0000 (UTC)
Date:   Sun, 23 Jun 2019 14:38:44 +0200
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: abx80x: Implement procfs interface
Message-ID: <20190623123844.GA3133@piout.net>
References: <20190623120854.3179-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623120854.3179-1-marex@denx.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Marek,

On 23/06/2019 14:08:54+0200, Marek Vasut wrote:
> Implement procfs interface for polling battery status of the RTC
> via /proc/driver/rtc .
> 

Please don't, this interface is deprecated and doesn't work well. Use
RTC_VL_READ instead.

> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/rtc/rtc-abx80x.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 73830670a41f..4fab024fb508 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -78,6 +78,10 @@
>  
>  #define ABX8XX_REG_ID0		0x28
>  
> +#define ABX8XX_REG_ANA_STATUS	0x2f
> +#define ABX8XX_ANA_BREFD	BIT(7)
> +#define ABX8XX_ANA_BMIN		BIT(6)
> +
>  #define ABX8XX_REG_OUT_CTRL	0x30
>  #define ABX8XX_OUT_CTRL_EXDS	BIT(4)
>  
> @@ -548,6 +552,25 @@ static int abx80x_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
>  	}
>  }
>  
> +static int abx80x_proc(struct device *dev, struct seq_file *seq)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	int status, tmp;
> +
> +	status = i2c_smbus_read_byte_data(client, ABX8XX_REG_ANA_STATUS);
> +	if (status < 0)
> +		return status;
> +
> +	if (status & ABX8XX_ANA_BREFD)
> +		seq_printf(seq, "battery\t\t: ok\n");
> +	else if (status & ABX8XX_ANA_BMIN)
> +		seq_printf(seq, "battery\t\t: low\n");
> +	else
> +		seq_printf(seq, "battery\t\t: exhausted\n");
> +
> +	return 0;
> +}
> +
>  static const struct rtc_class_ops abx80x_rtc_ops = {
>  	.read_time	= abx80x_rtc_read_time,
>  	.set_time	= abx80x_rtc_set_time,
> @@ -555,6 +578,7 @@ static const struct rtc_class_ops abx80x_rtc_ops = {
>  	.set_alarm	= abx80x_set_alarm,
>  	.alarm_irq_enable = abx80x_alarm_irq_enable,
>  	.ioctl		= abx80x_ioctl,
> +	.proc		= abx80x_proc,
>  };
>  
>  static int abx80x_dt_trickle_cfg(struct device_node *np)
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
