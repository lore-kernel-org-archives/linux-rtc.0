Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58063 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbdKHCaH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 7 Nov 2017 21:30:07 -0500
Date: Wed, 8 Nov 2017 03:30:00 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akshay Bhat <akshay.bhat@timesys.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rtc: rx8010: Fix for incorrect return value
Message-ID: <20171108023000.4oepp5pyz32c7sr3@piout.net>
References: <1509730361-23905-1-git-send-email-akshay.bhat@timesys.com>
 <1509730361-23905-3-git-send-email-akshay.bhat@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509730361-23905-3-git-send-email-akshay.bhat@timesys.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 03/11/2017 at 13:32:41 -0400, Akshay Bhat wrote:
> The err variable is not being reset after a successful read. Explicitly
> reset err variable to account for all return paths.
> 
> Reported-by: Jens-Peter Oswald <oswald@lre.de>
> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
> ---
>  drivers/rtc/rtc-rx8010.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
> index 2e06e5f..1ce2078 100644
> --- a/drivers/rtc/rtc-rx8010.c
> +++ b/drivers/rtc/rtc-rx8010.c
> @@ -223,6 +223,7 @@ static int rx8010_init_client(struct i2c_client *client)
>  					    2, ctrl);
>  	if (err != 2)
>  		return err < 0 ? err : -EIO;
> +	err = 0;

Isn't it simpler to make the function return 0 instead of err at the end?

>  
>  	if (ctrl[0] & RX8010_FLAG_VLF)
>  		dev_warn(&client->dev, "Frequency stop was detected\n");
> @@ -261,6 +262,7 @@ static int rx8010_read_alarm(struct device *dev, struct rtc_wkalrm *t)
>  	err = i2c_smbus_read_i2c_block_data(client, RX8010_ALMIN, 3, alarmvals);
>  	if (err != 3)
>  		return err < 0 ? err : -EIO;
> +	err = 0;

ditto

>  
>  	flagreg = i2c_smbus_read_byte_data(client, RX8010_FLAG);
>  	if (flagreg < 0)
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
