Return-Path: <rtc-linux+bncBDA7X7F2WUEBBFMJSK6QKGQEXODTSDY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com. [2a00:1450:400c:c09::231])
        by gmr-mx.google.com with ESMTPS id i193si479329wmg.1.2016.08.05.05.20.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Aug 2016 05:20:37 -0700 (PDT)
Received: by mail-wm0-x231.google.com with SMTP id o80so33623786wme.1
        for <rtc-linux@googlegroups.com>; Fri, 05 Aug 2016 05:20:37 -0700 (PDT)
Date: Fri, 5 Aug 2016 13:22:01 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Andy Yan <andy.yan@rock-chips.com>, mark.rutland@arm.com,
	devicetree@vger.kernel.org, a.zummo@towertech.it,
	pawel.moll@arm.com, rtc-linux@googlegroups.com,
	ijc+devicetree@hellion.org.uk, mturquette@baylibre.com,
	sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
	lgirdwood@gmail.com, linux-rockchip@lists.infradead.org,
	robh+dt@kernel.org, alexandre.belloni@free-electrons.com,
	broonie@kernel.org, dianders@chromium.org, galak@codeaurora.org,
	zyw@rock-chips.com, linux-clk@vger.kernel.org
Subject: [rtc-linux] Re: [RESEND PATCH v5 1/5] mfd: RK808: Add RK818 support
Message-ID: <20160805122201.GW5243@dell>
References: <1464850228-17244-1-git-send-email-w.egorov@phytec.de>
 <20160608141735.GE14888@dell>
 <5759277D.7090101@phytec.de>
 <577C77DF.9060706@rock-chips.com>
 <577CBB62.8080806@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <577CBB62.8080806@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

[...]

> Lee, you have already applied this series. But I can't find the patches
> in your kernel tree.
> I would like to read the device ID from the register in the probe functio=
n.
> Do you want me to base my changes on top of this series or send a new
> version?

Please rebase and resend the series.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
