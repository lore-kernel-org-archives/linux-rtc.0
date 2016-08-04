Return-Path: <rtc-linux+bncBDHZXHXDRAMBB5HUR26QKGQEL4UC3OA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id d201si2736215pfd.2.2016.08.04.14.58.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2016 14:58:11 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 2/4] rtc: rtc-pm8xxx: Add support for
 pm8018 rtc
To: Neil Armstrong <narmstrong@baylibre.com>, andy.gross@linaro.org,
 david.brown@linaro.org, lee.jones@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com
References: <1468936286-2710-1-git-send-email-narmstrong@baylibre.com>
 <1468936286-2710-3-git-send-email-narmstrong@baylibre.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Stephen Boyd <sboyd@codeaurora.org>
Message-ID: <97671c78-d7ad-9cef-f647-6e7cc8b9234e@codeaurora.org>
Date: Thu, 4 Aug 2016 14:58:09 -0700
MIME-Version: 1.0
In-Reply-To: <1468936286-2710-3-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/19/2016 06:51 AM, Neil Armstrong wrote:
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index 795fcbd..976f5f6 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -393,6 +393,16 @@ static int pm8xxx_rtc_enable(struct pm8xxx_rtc *rtc_dd)
>  	return 0;
>  }
>  
> +static const struct pm8xxx_rtc_regs pm8018_regs = {
> +	.ctrl		= 0x11d,
> +	.write		= 0x11f,
> +	.read		= 0x123,
> +	.alarm_rw	= 0x127,
> +	.alarm_ctrl	= 0x11d,
> +	.alarm_ctrl2	= 0x11e,
> +	.alarm_en	= BIT(1),
> +};

This is the same as pm8921_regs, so why do we need to duplicate it?
Can't we point the new compatible at the same data?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
