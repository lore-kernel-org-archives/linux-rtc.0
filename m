Return-Path: <rtc-linux+bncBDE6RCFOWIARBG6PU62QKGQEJISP5VA@googlegroups.com>
Received: from mail-ob0-x22d.google.com (mail-ob0-x22d.google.com. [2607:f8b0:4003:c01::22d])
        by gmr-mx.google.com with ESMTPS id ht5si123061igb.1.2016.01.28.02.04.10
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 02:04:10 -0800 (PST)
Received: by mail-ob0-x22d.google.com with SMTP id ny8so9780128obc.2
        for <rtc-linux@googlegroups.com>; Thu, 28 Jan 2016 02:04:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453198783-28383-4-git-send-email-ldewangan@nvidia.com>
References: <1453198783-28383-1-git-send-email-ldewangan@nvidia.com>
	<1453198783-28383-4-git-send-email-ldewangan@nvidia.com>
Date: Thu, 28 Jan 2016 11:04:10 +0100
Message-ID: <CACRpkdZEYw2aADQDNSi0kKns17nKZQZKY+harLhc0j3pA-5FuA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH V4 3/5] pinctrl: max77620: add pincontrol
 driver for MAX77620/MAX20024
From: Linus Walleij <linus.walleij@linaro.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	Alexandre Courbot <gnurou@gmail.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>, Stephen Warren <swarren@nvidia.com>,
	Thierry Reding <treding@nvidia.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>,
	vreddytalla@nvidia.com, Chaitanya Bandi <bandik@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jan 19, 2016 at 11:19 AM, Laxman Dewangan <ldewangan@nvidia.com> wrote:

> MAXIM Semiconductor's PMIC, MAX77620/MAX20024 has 8 GPIO pins
> which also act as the special function in alternate mode. Also
> there is configuration like push-pull, open drain, FPS timing
> etc for these pins.
>
> Add pincontrol driver to configure these parameters through
> pincontrol APIs.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>

Nice. This driver looks like a lot of hard work, but I think
it's worth it.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I guess Lee will be merging this into the MTD tree.

(I still had those comments on the DT bindings but this driver
part looks fine.)

Yours,
Linus Walleij

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
