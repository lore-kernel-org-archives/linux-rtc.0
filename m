Return-Path: <SRS0=BFTo=QZ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA406C43381
	for <linux-rtc@archiver.kernel.org>; Mon, 18 Feb 2019 14:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951432070B
	for <linux-rtc@archiver.kernel.org>; Mon, 18 Feb 2019 14:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfBROsb (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:48:31 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59823 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbfBROsb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 18 Feb 2019 09:48:31 -0500
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr [90.53.137.203])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id EBC5820009;
        Mon, 18 Feb 2019 14:48:28 +0000 (UTC)
Date:   Mon, 18 Feb 2019 15:48:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Nick Crews <ncrews@chromium.org>, linux-rtc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] rtc: wilco_ec: Make some functions static
Message-ID: <20190218144827.GU10129@piout.net>
References: <20190216013603.117969-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216013603.117969-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Enric,

You should take that one or squash it with the original commit.

On 16/02/2019 01:36:03+0000, Wei Yongjun wrote:
> Fixes the following sparse warnings:
> 
> drivers/rtc/rtc-wilco-ec.c:72:5: warning:
>  symbol 'wilco_ec_rtc_read' was not declared. Should it be static?
> drivers/rtc/rtc-wilco-ec.c:106:5: warning:
>  symbol 'wilco_ec_rtc_write' was not declared. Should it be static?
> 
> Fixes: 79c4ec4869b5 ("platform/chrome: wilco_ec: Add RTC driver")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/rtc/rtc-wilco-ec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> index 35cc56114c1c..e62bda0cb53e 100644
> --- a/drivers/rtc/rtc-wilco-ec.c
> +++ b/drivers/rtc/rtc-wilco-ec.c
> @@ -69,7 +69,7 @@ struct ec_rtc_write {
>  	u8 weekday;
>  } __packed;
>  
> -int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> +static int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
>  {
>  	struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
>  	u8 param = EC_CMOS_TOD_READ;
> @@ -103,7 +103,7 @@ int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
>  	return 0;
>  }
>  
> -int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
> +static int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
>  {
>  	struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
>  	struct ec_rtc_write rtc;
> 
> 
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
