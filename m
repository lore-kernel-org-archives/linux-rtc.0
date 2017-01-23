Return-Path: <rtc-linux+bncBDJIP47K7MERBRGETHCAKGQEWWGCPMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com. [209.85.218.67])
        by gmr-mx.google.com with ESMTPS id d20si1188438itc.1.2017.01.23.12.06.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jan 2017 12:06:28 -0800 (PST)
Received: by mail-oi0-f67.google.com with SMTP id x84so11611818oix.2
        for <rtc-linux@googlegroups.com>; Mon, 23 Jan 2017 12:06:28 -0800 (PST)
Date: Mon, 23 Jan 2017 14:06:27 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Janos Laube <janos.dev@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	openwrt-devel@openwrt.org, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 08/22] rtc: Add device tree probing to the
 Gemini driver
Message-ID: <20170123200627.uyfdayiuoqbuoxrp@rob-hp-laptop>
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

On Sun, Jan 22, 2017 at 01:19:50PM +0100, Linus Walleij wrote:
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

Acked-by: Rob Herring <robh@kernel.org>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
