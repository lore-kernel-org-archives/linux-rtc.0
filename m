Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:38807 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753656AbeCFVU3 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 6 Mar 2018 16:20:29 -0500
Subject: Re: [PATCH] parisc: time: stop validating rtc_time in .read_time
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "James E . J . Bottomley" <jejb@parisc-linux.org>,
        linux-parisc@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180221214023.1045-1-alexandre.belloni@bootlin.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <c80cb9e7-6a07-bc12-5758-d2b642a315dc@gmx.de>
Date: Tue, 6 Mar 2018 22:20:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180221214023.1045-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 21.02.2018 22:40, Alexandre Belloni wrote:
> The RTC core is always calling rtc_valid_tm after the read_time callback.
> It is not necessary to call it just before returning from the callback.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge


> ---
>  arch/parisc/kernel/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
> index 4b8fd6dc22da..f2890bd240f8 100644
> --- a/arch/parisc/kernel/time.c
> +++ b/arch/parisc/kernel/time.c
> @@ -173,7 +173,7 @@ static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
>  
>  	/* we treat tod_sec as unsigned, so this can work until year 2106 */
>  	rtc_time64_to_tm(tod_data.tod_sec, tm);
> -	return rtc_valid_tm(tm);
> +	return 0;
>  }
>  
>  static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
> 
