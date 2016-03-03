Return-Path: <rtc-linux+bncBCQJP74GSUDRBT634C3AKGQEA4ZZZ5I@googlegroups.com>
Received: from mail-ig0-x243.google.com (mail-ig0-x243.google.com. [2607:f8b0:4001:c05::243])
        by gmr-mx.google.com with ESMTPS id iq8si707732igb.0.2016.03.03.04.27.59
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 04:27:59 -0800 (PST)
Received: by mail-ig0-x243.google.com with SMTP id ww10so1967995igb.2
        for <rtc-linux@googlegroups.com>; Thu, 03 Mar 2016 04:27:59 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <2233190.1BxevBAvDE@wuerfel>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
	<1456992221-26712-9-git-send-email-k.kozlowski@samsung.com>
	<2233190.1BxevBAvDE@wuerfel>
Date: Thu, 3 Mar 2016 13:27:59 +0100
Message-ID: <CAMuHMdXUdz0=n2+Aa74f1LtwiwfV9=gkPBiJKC_DMyr1_jBe7Q@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC 08/15] rtc: at91sam9: Add missing MFD_SYSCON
 dependency on HAS_IOMEM
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>, Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brown <david.brown@linaro.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones <lee.jones@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, driverdevel <devel@driverdev.osuosl.org>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>,
	Andy Gross <andy.gross@linaro.org>,
	Linux Media Mailing List <linux-media@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Marc Zyngier <marc.zyngier@arm.com>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-soc@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PM list <linux-pm@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dmaengine@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Mar 3, 2016 at 11:55 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 03 March 2016 17:03:34 Krzysztof Kozlowski wrote:
>> index 0da40e2e4280..5c530b6b125d 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -1302,6 +1302,7 @@ config RTC_DRV_AT91RM9200
>>  config RTC_DRV_AT91SAM9
>>         tristate "AT91SAM9 RTT as RTC"
>>         depends on ARCH_AT91 || COMPILE_TEST
>> +       depends on HAS_IOMEM    # For MFD_SYSCON
>>         select MFD_SYSCON
>>         help
>>           Some AT91SAM9 SoCs provide an RTT (Real Time Timer) block which
>>
>
> This is technically correct, but the entire RTC menu is hidden
> inside of 'depends on !UML && !S390', so we won't ever get there
> on any configuration that does not use HAS_IOMEM.
>
> If we did, all other RTC drivers would also fail.

So UML has no RTC. Should/can it use RTC_DRV_GENERIC?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

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
