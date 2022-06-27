Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9147CC433EF
	for <linux-rtc@archiver.kernel.org>; Mon, 27 Jun 2022 07:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiF0Hhf (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 27 Jun 2022 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiF0Hhe (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 27 Jun 2022 03:37:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6612460D6
        for <linux-rtc@vger.kernel.org>; Mon, 27 Jun 2022 00:37:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1o5jJJ-00020Y-5n; Mon, 27 Jun 2022 09:37:29 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1o5jJG-00048R-Rb; Mon, 27 Jun 2022 09:37:26 +0200
Date:   Mon, 27 Jun 2022 09:37:26 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        a.fatoum@pengutronix.de
Subject: Re: [PATCH -next] rtc: rv8803: fix missing unlock on error in
 rv8803_set_time()
Message-ID: <20220627073726.GD19026@pengutronix.de>
References: <20220627073549.3976620-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627073549.3976620-1-yangyingliang@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-rtc@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, Jun 27, 2022 at 03:35:49PM +0800, Yang Yingliang wrote:
> Add the missing unlock before return from function rv8803_set_time()
> in the error handling case.
> 
> Fixes: c27fee16fab1 ("rtc: rv8803: re-initialize all Epson RX8803 registers on voltage loss")

That's not the commit breaking it. Should be:

Fixes: f8176e0bb83ff ("rtc: rv8803: initialize registers on post-probe voltage loss")

With that fixed:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/rtc/rtc-rv8803.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
> index fe1247e771b9..3527a0521e9b 100644
> --- a/drivers/rtc/rtc-rv8803.c
> +++ b/drivers/rtc/rtc-rv8803.c
> @@ -315,8 +315,10 @@ static int rv8803_set_time(struct device *dev, struct rtc_time *tm)
>  
>  	if (flags & RV8803_FLAG_V2F) {
>  		ret = rv8803_regs_reset(rv8803);
> -		if (ret)
> +		if (ret) {
> +			mutex_unlock(&rv8803->flags_lock);
>  			return ret;
> +		}
>  	}
>  
>  	ret = rv8803_write_reg(rv8803->client, RV8803_FLAG,
> -- 
> 2.25.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
