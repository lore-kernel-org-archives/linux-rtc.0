Return-Path: <rtc-linux+bncBDF47HN2VEIRBY7FVWVAKGQEVF5I4YY@googlegroups.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com. [209.85.212.177])
        by gmr-mx.google.com with ESMTPS id gt9si136116wib.2.2015.05.07.07.12.51
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 07:12:51 -0700 (PDT)
Received: by wief7 with SMTP id f7so14945256wie.0
        for <rtc-linux@googlegroups.com>; Thu, 07 May 2015 07:12:51 -0700 (PDT)
Date: Thu, 7 May 2015 15:12:45 +0100
From: Peter Griffin <peter.griffin@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, a.zummo@towertech.it,
	daniel.lezcano@linaro.org, wim@iguana.be, tglx@linutronix.de,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: [rtc-linux] Re: [STLinux Kernel] [PATCH 08/12] rtc: bindings: Supply
 knowledge of a third supported device - clocksource
Message-ID: <20150507141245.GA9793@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-9-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1431005924-21777-9-git-send-email-lee.jones@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Lee,

On Thu, 07 May 2015, Lee Jones wrote:

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> index 73407f50..daf8826 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-st-lpc.txt
> @@ -1,20 +1,23 @@
>  STMicroelectronics Low Power Controller (LPC) - RTC
>  ===================================================
>  
> -LPC currently supports Watchdog OR Real Time Clock functionality.
> +LPC currently supports Watchdog OR Real Time Clock OR Clocksource
> +functionality.
>  
>  [See: ../watchdog/st_lpc_wdt.txt for Watchdog options]
> +[See: ../timer/st,stih407-lpc for Clocksource options]
>  
>  Required properties
>  
> -- compatible 	: Must be one of: "st,stih407-lpc" "st,stih416-lpc"
> -				  "st,stih415-lpc" "st,stid127-lpc"
> +- compatible 	: Must be: "st,stih407-lpc"

You are removing the compatibles documentation for the other supported SoC's like
stih416-lpc stih415-lpc here.

regards,

Peter.

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
