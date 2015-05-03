Return-Path: <rtc-linux+bncBDS7HNEFSALRB4XCS6VAKGQETT2Z62A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bc3si185154wib.2.2015.05.03.02.59.14
        for <rtc-linux@googlegroups.com>;
        Sun, 03 May 2015 02:59:14 -0700 (PDT)
Date: Sun, 3 May 2015 11:59:13 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: mxc: Constify platform_device_id
Message-ID: <20150503095913.GS12076@piout.net>
References: <1430495077-31179-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430495077-31179-3-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1430495077-31179-3-git-send-email-k.kozlowski.k@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 02/05/2015 at 00:44:37 +0900, Krzysztof Kozlowski wrote :
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/rtc/rtc-mxc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
