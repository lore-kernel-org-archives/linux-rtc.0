Return-Path: <rtc-linux+bncBDE6RCFOWIARBJXM2K2QKGQELO2VN6A@googlegroups.com>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com. [2607:f8b0:4003:c01::22f])
        by gmr-mx.google.com with ESMTPS id kr4si145437igb.0.2016.02.05.06.48.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 06:48:06 -0800 (PST)
Received: by mail-ob0-x22f.google.com with SMTP id xk3so90155858obc.2
        for <rtc-linux@googlegroups.com>; Fri, 05 Feb 2016 06:48:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454171931-27752-4-git-send-email-ldewangan@nvidia.com>
References: <1454171931-27752-1-git-send-email-ldewangan@nvidia.com>
	<1454171931-27752-4-git-send-email-ldewangan@nvidia.com>
Date: Fri, 5 Feb 2016 15:48:05 +0100
Message-ID: <CACRpkda+z19COrBBhwZks_69w-BEyOjQMHnadjdRVic+3uN_7g@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH V7 3/8] pinctrl: add DT binding doc for
 pincontrol of PMIC max77620/max20024
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
	vreddytalla@nvidia.com
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

On Sat, Jan 30, 2016 at 5:38 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:

> Maxim Semiconductor's PMIC MAX77620/MAX20024 has 8 GPIO pins
> which act as GPIO as well as special function mode.
>
> Add DT binding document to configure pins in function mode as
> well as pin configuration parameters.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes from V4:
> - Separate out from pincontrol driver

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Lee can merge this with the rest of the patches.

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
