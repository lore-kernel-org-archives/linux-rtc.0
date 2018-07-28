Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:55567 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728542AbeG1ORr (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 28 Jul 2018 10:17:47 -0400
Date: Sat, 28 Jul 2018 14:51:20 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@airtame.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        rkhudolii@airtame.com, attila@airtame.com
Subject: Re: [PATCH] rtc: pcf85063: preserve control register value between
 stop and start
Message-ID: <20180728125120.GA28585@piout.net>
References: <20180715213153.8606-1-alvin@airtame.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180715213153.8606-1-alvin@airtame.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 15/07/2018 23:31:53+0200, Alvin Šipraga wrote:
> Fix a bug that caused the Control_1 register to get zeroed whenever the
> RTC time is set. The problem occurred between stopping and starting the
> RTC clock, wherein the return value of a successful I2C write function
> would get written to the register.
> 
> Also update variables of the start and stop functions to be more
> consistent with the rest of the driver.
> 
> Signed-off-by: Alvin Šipraga <alvin@airtame.com>
> ---
>  drivers/rtc/rtc-pcf85063.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 

Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
