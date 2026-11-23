Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467389;
	b=EM/ob6Kc7V9XAu+Z1B96ks/ecEAZutVi5P7Xi5qxUxYqVYC+KUJhaMireB8U9U1A9VmI
	 IlXVOvu/l7ht/OrJobRmcMY+XO8FYMo+yor5X7KTGogzLtYj7lN2nJfY7zubwni5h+u/3
	 6xFUfbLy9TfzYFv/uaojgXuOz7MyehHoPFKp74n1LFkytHGsM8cxyDXySv7rR4jf15gIx
	 cSXW+zWlBgdQ759TMIoSVkANjigpnL05g4+Yt8O+F46/MUDcb+qPrYOevZlSkzu1gT+0P
	 gFLto+30L5ctIotgCkfxy9ZY7BPu/hJ6YPwl/a+OLKJ2oVfErPXAJiVM4qmGXe5VONg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467389;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=uMMQm4mAWp49cFU6NJgpXckSRNY1fS9XcSuusU3yNEY=;
	b=HLAj+Ig3AjcICg+JDCSs+ZcKk8APjcUCO/oojrKRy7MlPY8QLFaaxj2SDyRMrihboHcf
	 1pHYMPSmK3+3bTQpBAprhlf5Nc758vN8J+FOauTiocDfIUPTVBUAyW10vN31dTpFQAARD
	 /ajKnl/QMkF14ydAMfjoANNBPbeX3WjDT3sWhCG/kqcVb7hClbaGCAO0UbVsQNEUnPDxJ
	 bVdSEi8DLZgcKjg+a/paJ50H2W1diDWyYMYlNqf1Hew+gN+UsYCywawLo2KPsQRXZqhrb
	 uwG7nKzN0MnHVIYqwmXPDNveIeQuLWQwK1po8EoOtD8+v8oD+67ggq8IyKLF7Z4Y7tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="Eo/ZK1MO";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849E606A335
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 20:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1849E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Eo/ZK1MO
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 67B4BC4EFD7;
	Mon, 23 Nov 2026 20:56:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D19C601E1;
	Mon, 23 Nov 2026 20:56:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4BFD411E6AA3D;
	Mon, 23 Nov 2026 21:56:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795467382; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uMMQm4mAWp49cFU6NJgpXckSRNY1fS9XcSuusU3yNEY=;
	b=Eo/ZK1MO3u8khRaCtZ61aO2y81AdlGUDjjkapEsvBJxG16pIiS1NIoAGwUwEGLDzBT/Pyd
	Xpgv4HaO2ZuTviB2D6c50Qi6NdKniE1dda5oVccPv2ung+ILqk9aqao+9cMLJbalFCXfRx
	MMRc//OCcW9j3kGniOXPayC5ebMWWH6xMDNL8n24BFUXPWSkmlIkYWMXkiR841AcWZB+br
	qgI9vwVxBv3ZUGhFGtA4l9jF+NEbX9TtkbNex6GXi/W8npOM5Ixgw1aIAoCZ15r7taoF4e
	niXdE7L/GiUJ1f917vN7jkN4WiGrLFSLnPShOPoV5bUkRUZV6+SPk+Q9PqJleA==
Date: Mon, 23 Nov 2026 21:56:20 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: filipp.dunsky@gmail.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rtc: Add Cortina Systems CS7542 RTC driver
Message-ID: <202611232056209fabb078@mail.local>
References: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
 <20261123-b4-cs7542-rtc-v2-2-31ab43f2cc8e@gmail.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-b4-cs7542-rtc-v2-2-31ab43f2cc8e@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 23/11/2026 23:27:02+0300, Fil Dunsky via B4 Relay wrote:
> From: Fil Dunsky <filipp.dunsky@gmail.com>
> 
> Adapt the vendor-derived OpenWrt calendar implementation to an OF driver
> without a platform Kconfig dependency. Decode the four-digit BCD year,
> retry reads across second changes and preserve RTCEN after programming.
> Expose the verified 2000-2099 calendar read/set operations. Do not
> advertise alarm interrupts or suspend wake until their hardware
> behaviour has been established.
> 
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
> ---
>  drivers/rtc/Kconfig      |   9 +++
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-cs75xx.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 184 insertions(+)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 73ec9230e..2937f637a 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1463,6 +1463,15 @@ config RTC_DRV_ASM9260
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-asm9260.
>  
> +config RTC_DRV_CS75XX
> +	tristate "Cortina Systems CS7542 RTC"
> +	depends on OF && HAS_IOMEM
> +	help
> +	  Support the calendar clock of the Cortina Systems CS7542 SoC.
> +	  Read and set dates in the 2000-2099 range.
> +	  Alarm interrupts are not supported.
> +	  The module will be named rtc-cs75xx.
> +
>  config RTC_DRV_CV1800
>  	tristate "Sophgo CV1800 RTC"
>  	depends on SOPHGO_CV1800_RTCSYS || COMPILE_TEST
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 46f1a0fc2..516cc6c9c 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_RTC_DRV_CADENCE)	+= rtc-cadence.o
>  obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
>  obj-$(CONFIG_RTC_DRV_CPCAP)	+= rtc-cpcap.o
>  obj-$(CONFIG_RTC_DRV_CROS_EC)	+= rtc-cros-ec.o
> +obj-$(CONFIG_RTC_DRV_CS75XX)	+= rtc-cs75xx.o
>  obj-$(CONFIG_RTC_DRV_CV1800)	+= rtc-cv1800.o
>  obj-$(CONFIG_RTC_DRV_DA9052)	+= rtc-da9052.o
>  obj-$(CONFIG_RTC_DRV_DA9055)	+= rtc-da9055.o
> diff --git a/drivers/rtc/rtc-cs75xx.c b/drivers/rtc/rtc-cs75xx.c
> new file mode 100644
> index 000000000..2ba25ac04
> --- /dev/null
> +++ b/drivers/rtc/rtc-cs75xx.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/module.h>
> +#include <linux/bits.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +#include <linux/bcd.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +
> +#define DRV_NAME	"cs75xx-rtc"
> +
> +#define G2_RTC_RTCCON		0x00
> +#define G2_RTC_RTCCON_STARTB	BIT(0)
> +#define G2_RTC_RTCCON_RTCEN	BIT(1)
> +#define G2_RTC_RTCCON_CLKRST	BIT(2)
> +#define G2_RTC_RTCCON_OSCEN	BIT(3)
> +
> +#define G2_RTC_RTCSEC		0x24
> +#define G2_RTC_RTCMIN		0x28
> +#define G2_RTC_RTCHOUR		0x2c
> +#define G2_RTC_RTCDATE		0x30
> +#define G2_RTC_RTCDAY		0x34
> +#define G2_RTC_RTCMON		0x38
> +#define G2_RTC_RTCYEAR		0x3c
> +struct g2_rtc {
> +	void __iomem		*base;
> +	struct rtc_device	*rtc;
> +};
> +
> +static u32 g2_rtc_readl(struct g2_rtc *p, unsigned int addr)
> +{
> +	return readl(p->base + addr);
> +}
> +
> +static u8 g2_rtc_readb(struct g2_rtc *p, unsigned int addr)
> +{
> +	return readl(p->base + addr) & 0xff;
> +}
> +
> +static void g2_rtc_writel(struct g2_rtc *p, unsigned int addr, u32 val, u32 mask)
> +{
> +	u32 reg = (readl(p->base + addr) & ~mask) | (val & mask);
> +
> +	writel(reg, p->base + addr);
> +}
> +
> +static void g2_rtc_write_enable(struct g2_rtc *p)
> +{
> +	u32 tmp = g2_rtc_readb(p, G2_RTC_RTCCON);
> +
> +	g2_rtc_writel(p, G2_RTC_RTCCON,
> +		      tmp | G2_RTC_RTCCON_RTCEN | G2_RTC_RTCCON_STARTB, 0xff);
> +}
> +
> +static void g2_rtc_write_disable(struct g2_rtc *p)
> +{
> +	u32 tmp = g2_rtc_readb(p, G2_RTC_RTCCON);
> +
> +	g2_rtc_writel(p, G2_RTC_RTCCON,
> +		      tmp & ~G2_RTC_RTCCON_STARTB, 0xff);
> +}
> +
> +static int g2_rtc_gettime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct g2_rtc *p = dev_get_drvdata(dev);
> +	u32 year, sec;
> +	int retry;
> +
> +	for (retry = 0; retry < 3; retry++) {
> +		sec = g2_rtc_readb(p, G2_RTC_RTCSEC);
> +		tm->tm_min = bcd2bin(g2_rtc_readb(p, G2_RTC_RTCMIN));
> +		tm->tm_hour = bcd2bin(g2_rtc_readb(p, G2_RTC_RTCHOUR));
> +		tm->tm_mday = bcd2bin(g2_rtc_readb(p, G2_RTC_RTCDATE));
> +		tm->tm_mon = bcd2bin(g2_rtc_readb(p, G2_RTC_RTCMON)) - 1;
> +		year = g2_rtc_readl(p, G2_RTC_RTCYEAR) & 0xffff;
> +		if (sec == g2_rtc_readb(p, G2_RTC_RTCSEC)) {
> +			tm->tm_sec = bcd2bin(sec);
> +			tm->tm_year = bcd2bin(year & 0xff) +
> +				      bcd2bin(year >> 8) * 100 - 1900;
> +			return rtc_valid_tm(tm);

Calling rtc_valid_tm() is not necessary because the core is validating
the tm later on.

> +		}
> +	}
> +
> +	return -EAGAIN;
> +}
> +
> +static int g2_rtc_settime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct g2_rtc *p = dev_get_drvdata(dev);
> +	int year = tm->tm_year + 1900;
> +
> +	g2_rtc_write_enable(p);
> +	g2_rtc_writel(p, G2_RTC_RTCSEC,  bin2bcd(tm->tm_sec), 0xffffffff);
> +	g2_rtc_writel(p, G2_RTC_RTCMIN,  bin2bcd(tm->tm_min), 0xffffffff);
> +	g2_rtc_writel(p, G2_RTC_RTCHOUR, bin2bcd(tm->tm_hour), 0xffffffff);
> +	g2_rtc_writel(p, G2_RTC_RTCDATE, bin2bcd(tm->tm_mday), 0xffffffff);
> +	g2_rtc_writel(p, G2_RTC_RTCMON,  bin2bcd(tm->tm_mon + 1), 0xffffffff);
> +	g2_rtc_writel(p, G2_RTC_RTCYEAR,
> +		      (bin2bcd(year / 100) << 8) | bin2bcd(year % 100), 0xffff);
> +	g2_rtc_write_disable(p);
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops g2_rtcops = {
> +	.read_time		= g2_rtc_gettime,
> +	.set_time		= g2_rtc_settime,
> +};
> +
> +static void g2_rtc_enable(struct device *dev, struct g2_rtc *p)
> +{
> +	u32 tmp;
> +
> +	if ((g2_rtc_readb(p, G2_RTC_RTCCON) & G2_RTC_RTCCON_RTCEN) == 0) {
> +		dev_info(dev, "rtc disabled, re-enabling\n");

This is too verbose.

> +		tmp = g2_rtc_readb(p, G2_RTC_RTCCON);
> +		g2_rtc_writel(p, G2_RTC_RTCCON, tmp | G2_RTC_RTCCON_RTCEN, 0xff);
> +	}
> +	if (g2_rtc_readb(p, G2_RTC_RTCCON) & G2_RTC_RTCCON_CLKRST) {
> +		dev_info(dev, "removing RTCCON_CLKRST\n");

Ditto.

> +		tmp = g2_rtc_readb(p, G2_RTC_RTCCON);
> +		g2_rtc_writel(p, G2_RTC_RTCCON, tmp & ~G2_RTC_RTCCON_CLKRST, 0xff);
> +	}
> +}
> +
> +static int g2_rtc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct g2_rtc *p;
> +
> +	p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	p->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(p->base))
> +		return PTR_ERR(p->base);
> +
> +	platform_set_drvdata(pdev, p);
> +
> +	g2_rtc_enable(dev, p);
> +

No, don't unconditionally enable the RTC, you have to enable it once you
know the time is know (that is, in .set_time). You then need to return
-EINVAL from .read_time when the time is know to be invalid.

> +	p->rtc = devm_rtc_allocate_device(dev);
> +	if (IS_ERR(p->rtc))
> +		return PTR_ERR(p->rtc);
> +	p->rtc->ops = &g2_rtcops;
> +	p->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	p->rtc->range_max = RTC_TIMESTAMP_END_2099;

Doesn't the RTC support a larger range, there are century bits. Does it
consider 2100 to be a leap year?

This can be checked with
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc-range.c


> +	/* Alarm interrupt generation has not yet been verified. */
> +	clear_bit(RTC_FEATURE_ALARM, p->rtc->features);

Not necessary as the alarm callbacks are not implemented.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
