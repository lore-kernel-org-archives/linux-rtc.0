Return-Path: <rtc-linux+bncBDE6RCFOWIARBPMHUC7AKGQEIZFXEQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com. [2607:f8b0:4003:c06::236])
        by gmr-mx.google.com with ESMTPS id w188si37841itc.3.2016.09.01.03.32.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 03:32:28 -0700 (PDT)
Received: by mail-oi0-x236.google.com with SMTP id r205so30187526oih.3
        for <rtc-linux@googlegroups.com>; Thu, 01 Sep 2016 03:32:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1472630725-25465-1-git-send-email-Julia.Lawall@lip6.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Sep 2016 12:32:28 +0200
Message-ID: <CACRpkdZV6mF2XvY8DiV3GM8yksNLXiag4_i6EXaosSZAc784-Q@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: constify rtc_class_ops structures
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Alessandro Zummo <a.zummo@towertech.it>, kernel-janitors@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wan ZongShun <mcuos.com@gmail.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Baruch Siach <baruch@tkos.co.il>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Aug 31, 2016 at 10:05 AM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> Check for rtc_class_ops structures that are only passed to
> devm_rtc_device_register, rtc_device_register,
> platform_device_register_data, all of which declare the corresponding
> parameter as const.  Declare rtc_class_ops structures that have these
> properties as const.
(...)
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
