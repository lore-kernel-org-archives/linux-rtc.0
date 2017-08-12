Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45991 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbdHLSMV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 12 Aug 2017 14:12:21 -0400
Date: Sat, 12 Aug 2017 20:12:16 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Cc: linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [RFCv2] rtc: ds1307: add square wave output from ds1308
Message-ID: <20170812181216.u2p3yd3ogappnzh4@piout.net>
References: <20170802052727.18289-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170802052727.18289-1-sean.nyekjaer@prevas.dk>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 02/08/2017 at 07:27:27 +0200, Sean Nyekjaer wrote:
> +static int ds1308_write_control(struct ds1307 *ds1307, u8 mask, u8 value)
> +{
> +	struct mutex *lock = &ds1307->rtc->ops_lock;
> +	int ret;
> +
> +	mutex_lock(lock);
> +	ret = regmap_update_bits(ds1307->regmap, DS1307_REG_CONTROL,
> +				 mask, value);

This access is already properly locked, you don't need
ds1308_write_control.

(I know, the function below is not necessary either but it is there for
historical reasons).

> +	mutex_unlock(lock);
> +
> +	return ret;
> +}
> +
>  static int ds1337_write_control(struct ds1307 *ds1307, u8 mask, u8 value)
>  {
>  	struct mutex *lock = &ds1307->rtc->ops_lock;

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
