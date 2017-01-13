Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBZMM4TBQKGQERA6S37Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e134si171208wmd.3.2017.01.13.08.55.01
        for <rtc-linux@googlegroups.com>;
        Fri, 13 Jan 2017 08:55:01 -0800 (PST)
Date: Fri, 13 Jan 2017 17:54:51 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Amelie Delaunay <amelie.delaunay@st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/3] rtc: stm32: remove __exit annotation on
 remove callback
Message-ID: <20170113165451.3wsyynukd3su2tcf@piout.net>
References: <20170113153311.2611510-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170113153311.2611510-1-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 13/01/2017 at 16:32:51 +0100, Arnd Bergmann wrote :
> The remove function can be called at runtime for a manual 'unbind'
> operation and must not be left out from a built-in driver, as kbuild
> complains:
> 
> `stm32_rtc_remove' referenced in section `.data.stm32_rtc_driver' of drivers/rtc/rtc-stm32.o: defined in discarded section `.exit.text' of drivers/rtc/rtc-stm32.o
> 
> This removes the extraneous annotation.
> 
> Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
