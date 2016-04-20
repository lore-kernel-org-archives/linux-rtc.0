Return-Path: <rtc-linux+bncBCXY5EGBQUIBB4E53S4AKGQEKW4FZNA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-out.m-online.net (mail-out.m-online.net. [212.18.0.9])
        by gmr-mx.google.com with ESMTPS id 69si553380wmn.1.2016.04.19.22.09.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 22:09:04 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: pcf8563: Remove CLK_IS_ROOT
To: Stephen Boyd <sboyd@codeaurora.org>
References: <1461114739-17105-1-git-send-email-sboyd@codeaurora.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
 Heiko Schocher <hs@denx.de>
Reply-To: rtc-linux@googlegroups.com
From: Heiko Schocher <hs@denx.de>
Message-ID: <57170EED.3000305@denx.de>
Date: Wed, 20 Apr 2016 07:09:01 +0200
MIME-Version: 1.0
In-Reply-To: <1461114739-17105-1-git-send-email-sboyd@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Stephen,

Am 20.04.2016 um 03:12 schrieb Stephen Boyd:
> This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> CLK_IS_ROOT", 2016-02-02) so remove it.
>
> Cc: Heiko Schocher <hs@denx.de>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>   drivers/rtc/rtc-pcf8563.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
>
> diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> index d5e6ed96b748..b9ddbb001283 100644
> --- a/drivers/rtc/rtc-pcf8563.c
> +++ b/drivers/rtc/rtc-pcf8563.c
> @@ -533,7 +533,7 @@ static struct clk *pcf8563_clkout_register_clk(struct pcf8563 *pcf8563)
>
>   	init.name = "pcf8563-clkout";
>   	init.ops = &pcf8563_clkout_ops;
> -	init.flags = CLK_IS_ROOT;
> +	init.flags = 0;
>   	init.parent_names = NULL;
>   	init.num_parents = 0;
>   	pcf8563->clkout_hw.init = &init;
>

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
