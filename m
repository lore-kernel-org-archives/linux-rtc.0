Return-Path: <rtc-linux+bncBDJIP47K7MERBWFD6C7AKGQE6LUWY2A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com. [209.85.218.68])
        by gmr-mx.google.com with ESMTPS id 125si714682itw.2.2016.09.16.08.38.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2016 08:38:00 -0700 (PDT)
Received: by mail-oi0-f68.google.com with SMTP id v62so3458423oig.1
        for <rtc-linux@googlegroups.com>; Fri, 16 Sep 2016 08:38:00 -0700 (PDT)
Date: Fri, 16 Sep 2016 10:37:59 -0500
From: Rob Herring <robh@kernel.org>
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Keerthy <j-keerthy@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v5] rtc: omap: Support ext_wakeup configuration
Message-ID: <20160916153759.GA12050@rob-hp-laptop>
References: <20160908105203.8641-1-m.niestroj@grinn-global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160908105203.8641-1-m.niestroj@grinn-global.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Sep 08, 2016 at 12:52:03PM +0200, Marcin Niestroj wrote:
> Support configuration of ext_wakeup sources. This patch makes it
> possible to enable ext_wakeup and set it's polarity, depending on board
> configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
> notify about power-button presses. Handling power-button presses enables
> to recover from RTC-only power states correctly.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> ---
> Hi,
> 
> This patch adds support for ext_wakeup using generic pinconf device-tree
> bindings, with one added custom property.
> 
> Changes v4 -> v5 (suggested by Rob):
>  * Don't use GPIO defines in ti,input-polarity, use optional ti,active-high
>    boolean instead.
>  * Use '-' instead of '_' in node name.
> 
> Changes v1 -> v4:
>  * This is a total reimplementation, so it is not based on any of the previous
>    patch versions. This approach has been suggested by Tony and Grygorii
>    in [1].
> 
> Patch was developed on 4.7, rebased on 4.8-rc5, tested using chiliBoard.
> 
> [1] http://www.spinics.net/lists/devicetree/msg131516.html
> 
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  21 +++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/rtc/Kconfig                                |   1 +
>  drivers/rtc/rtc-omap.c                             | 168 ++++++++++++++++++++-
>  3 files changed, 182 insertions(+), 8 deletions(-)

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
