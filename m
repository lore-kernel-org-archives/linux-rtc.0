Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBAVHT3CAKGQEH3RXDUY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id q4si864411wma.3.2017.01.24.09.48.49
        for <rtc-linux@googlegroups.com>;
        Tue, 24 Jan 2017 09:48:49 -0800 (PST)
Date: Tue, 24 Jan 2017 18:48:39 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Janos Laube <janos.dev@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	openwrt-devel@openwrt.org, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 08/22] rtc: Add device tree probing to the
 Gemini driver
Message-ID: <20170124174839.xn6sdgzhv4neauel@piout.net>
References: <20170122121950.10449-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170122121950.10449-1-linus.walleij@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/01/2017 at 13:19:50 +0100, Linus Walleij wrote :
> This adds bindings and simple probing for the Cortina Systems Gemini
> SoC RTC.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> RTC maintainers: please just apply this to the RTC tree when you
> are pleased with it. It is functionally orthogonal to the rest of
> the series and just in a series for context.
> ---
>  Documentation/devicetree/bindings/rtc/cortina,gemini.txt | 14 ++++++++++++++
>  drivers/rtc/rtc-gemini.c                                 |  7 +++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.txt
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
