Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBIFH6XFAKGQEXP2HGMY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id o207si1639148wme.0.2017.07.05.14.01.20
        for <rtc-linux@googlegroups.com>;
        Wed, 05 Jul 2017 14:01:20 -0700 (PDT)
Date: Wed, 5 Jul 2017 23:01:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, Po-Yu Chuang <ratbert@faraday-tech.com>
Subject: [rtc-linux] Re: [PATCH 2/3 v2] rtc: gemini: Augment DT bindings for Faraday
Message-ID: <20170705210119.fzzc2hqlj3hftmi7@piout.net>
References: <20170530075332.3740-1-linus.walleij@linaro.org>
 <20170530075332.3740-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170530075332.3740-2-linus.walleij@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 30/05/2017 at 09:53:31 +0200, Linus Walleij wrote:
> The Gemini RTC is actually a standard IP block from Faraday
> Technology called FTRTC010. Rename the bindings, add the
> generic compatible string and add definitions for the two
> available clocks.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Po-Yu Chuang <ratbert@faraday-tech.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Add Rob's ACK.
> ---
>  .../devicetree/bindings/rtc/cortina,gemini.txt     | 14 -----------
>  .../devicetree/bindings/rtc/faraday,ftrtc010.txt   | 28 ++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/cortina,gemini.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
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
