Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37341C433DB
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Jan 2021 03:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3301224B1
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Jan 2021 03:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbhAYDfZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 24 Jan 2021 22:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbhAYDfY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 24 Jan 2021 22:35:24 -0500
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87550C061574;
        Sun, 24 Jan 2021 19:34:44 -0800 (PST)
Subject: Re: [PATCH 05/14] rtc: ds1685: use rtc_lock/rtc_unlock
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210119220653.677750-1-alexandre.belloni@bootlin.com>
 <20210119220653.677750-5-alexandre.belloni@bootlin.com>
From:   Joshua Kinard <kumba@gentoo.org>
Openpgp: preference=signencrypt
Message-ID: <62b9f5fb-acc0-0418-1e44-b6d0965784a4@gentoo.org>
Date:   Sun, 24 Jan 2021 22:33:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210119220653.677750-5-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 1/19/2021 17:06, Alexandre Belloni wrote:
> Avoid accessing directly rtc->ops_lock and use the RTC core helpers.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-ds1685.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index d69c807af29b..75db7ab654a5 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -658,7 +658,6 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
>  {
>  	struct platform_device *pdev = dev_id;
>  	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
> -	struct mutex *rtc_mutex;
>  	u8 ctrlb, ctrlc;
>  	unsigned long events = 0;
>  	u8 num_irqs = 0;
> @@ -667,8 +666,7 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
>  	if (unlikely(!rtc))
>  		return IRQ_HANDLED;
>  
> -	rtc_mutex = &rtc->dev->ops_lock;
> -	mutex_lock(rtc_mutex);
> +	rtc_lock(rtc->dev);
>  
>  	/* Ctrlb holds the interrupt-enable bits and ctrlc the flag bits. */
>  	ctrlb = rtc->read(rtc, RTC_CTRL_B);
> @@ -713,7 +711,7 @@ ds1685_rtc_irq_handler(int irq, void *dev_id)
>  		}
>  	}
>  	rtc_update_irq(rtc->dev, num_irqs, events);
> -	mutex_unlock(rtc_mutex);
> +	rtc_unlock(rtc->dev);
>  
>  	return events ? IRQ_HANDLED : IRQ_NONE;
>  }
> 

Acked-by: Joshua Kinard <kumba@gentoo.org>

