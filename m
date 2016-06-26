Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBCWTXS5QKGQEZUYFZPI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q124si142869wme.3.2016.06.25.18.02.02
        for <rtc-linux@googlegroups.com>;
        Sat, 25 Jun 2016 18:02:02 -0700 (PDT)
Date: Sun, 26 Jun 2016 03:02:00 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 4/8] rtc: ac100: Add RTC driver for
 X-Powers AC100
Message-ID: <20160626010200.GZ5809@piout.net>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-5-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466391138-12862-5-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/06/2016 at 10:52:14 +0800, Chen-Yu Tsai wrote :
> +static int ac100_rtc_probe(struct platform_device *pdev)
> +{
> +	struct ac100_dev *ac100 = dev_get_drvdata(pdev->dev.parent);
> +	struct ac100_rtc_dev *chip;
> +	int ret;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	platform_set_drvdata(pdev, chip);
> +	chip->dev = &pdev->dev;
> +	chip->regmap = ac100->regmap;
> +	mutex_init(&chip->mutex);
> +
> +	chip->irq = of_irq_get(pdev->dev.of_node, 0);

Forgot that one, platform_get_irq() is probably more common but I don't
care that much. I think you can then avoid including of.h and of_irq.h.

> +	if (chip->irq < 0) {
> +		dev_err(&pdev->dev, "No IRQ resource\n");
> +		return chip->irq;
> +	}
> +

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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
