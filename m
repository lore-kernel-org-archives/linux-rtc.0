Return-Path: <rtc-linux+bncBDE6RCFOWIARBAWQU62QKGQEDDIXQ5Y@googlegroups.com>
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com. [2607:f8b0:4003:c06::22b])
        by gmr-mx.google.com with ESMTPS id w9si134968igl.0.2016.01.28.02.05.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 02:05:54 -0800 (PST)
Received: by mail-oi0-x22b.google.com with SMTP id p187so23465535oia.2
        for <rtc-linux@googlegroups.com>; Thu, 28 Jan 2016 02:05:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453198783-28383-5-git-send-email-ldewangan@nvidia.com>
References: <1453198783-28383-1-git-send-email-ldewangan@nvidia.com>
	<1453198783-28383-5-git-send-email-ldewangan@nvidia.com>
Date: Thu, 28 Jan 2016 11:05:53 +0100
Message-ID: <CACRpkdYSLW6_t8zauYJNd=3OMF=yo5htJHfAocBPQZtyA-Oj1Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH V4 4/5] gpio: max77620: add gpio driver for MAX77620/MAX20024
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

> MAXIM Semiconductor's PMIC, MAX77620/MAX20024 has 8 GPIO
> pins. It also supports interrupts from these pins.
>
> Add GPIO driver for these pins to control via GPIO APIs.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>

That's a fine driver, no doubt about that.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Same comment on merging through MFD etc as on the
pinctrl patch.

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
