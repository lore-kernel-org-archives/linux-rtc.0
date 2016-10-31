Return-Path: <rtc-linux+bncBDJIP47K7MERBJ6O3PAAKGQETQEZPRQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com. [209.85.218.65])
        by gmr-mx.google.com with ESMTPS id a3si1292400itc.0.2016.10.30.23.39.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2016 23:39:35 -0700 (PDT)
Received: by mail-oi0-f65.google.com with SMTP id 128so2478587oih.3
        for <rtc-linux@googlegroups.com>; Sun, 30 Oct 2016 23:39:35 -0700 (PDT)
Date: Mon, 31 Oct 2016 01:39:33 -0500
From: Rob Herring <robh@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Maarten ter Huurne <maarten@treewalker.org>,
	Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [rtc-linux] Re: [PATCH v2 2/7] Documentation: dt: Add binding info
 for jz4740-rtc driver
Message-ID: <20161031063933.wvsby4tgdbgc7zrp@rob-hp-laptop>
References: <20161030230247.20538-1-paul@crapouillou.net>
 <20161030230247.20538-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161030230247.20538-3-paul@crapouillou.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Oct 31, 2016 at 12:02:42AM +0100, Paul Cercueil wrote:
> This commit adds documentation for the device-tree bindings of the
> jz4740-rtc driver, which supports the RTC unit present in the JZ4740 and
> JZ4780 SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> 
> v2:
> - Remove 'interrupt-parent' of the list of required properties
> - Add the -msec suffix for the DT entries that represent time

Sorry, I told you the wrong suffix. It should be '-ms' as documented in 
.../bindings/property-units.txt. I never can remember which is why I 
wrote the doc to begin with. With that fix,

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
