Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591787;
	b=OZyJNSHnId/ZhToel1v/HevyDA6brmcc8uPCE21wPTLjwRpoThXX/KGD9yfduHT94rC3
	 3QzRWtwrEbGztCosncrvVJwpQdhmvN19EChZbbtZ6Tr0UbCknzw5764UWy2g51af27nUG
	 PBWYmBkDK5ktQ+G1ZqI272ZAm0emwq2f+9nh5896vA7OMcaLGMRorwKQAJbBGgRnkCmdM
	 Vd//4GkK0H29ajnFHyu3e0XL/rioOcwL6AZcQM7e48P8KsPCZ2C81RyKk6HWYIpIDHL4E
	 QjmN+ZRU3tELDqUbPocO417+2O711s/U9W7pjpS4UvqCSCVM8MAhZHzGmIWfduh/DEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591787;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K4N+z+qZkTaLCmo/VXO6ehCCwqsZm8UjOH4rKUfK5go=;
	b=U5wD6zhbYDNKcZGJA/l/kqIbioH71E1xseGbSgCms2cYY86TCzlXY06AG8i0AgauHs19
	 fPYPeDdArn+pYuEEN2H8utF29hdmLruR/xwPRXSFM3g9oTtT0cJ+5I5Z2dYIMie2EYNmD
	 ntgu3Sc/qm+3nrDp6PWUR4Fml/CfEUAgVQxrrsV0rtCO9lB0lVXvlwnqnkSCfRt8mQ4kR
	 Sj6EohIXQhKYgyBS9YibTdr/JYpN/Aw84A77hlzeNBsButRxKRoRRsFerzCx6jY0jlXTF
	 tBgP9pne9SSlRxWeGrq3HmC/TAWa/4hACQRgGXSfio5EQLfUKwzRSq4GzgynPDtt4zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBI0c2gK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02B606A31E;
	Wed, 25 Nov 2026 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBI0c2gK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3FA1F000D0;
	Wed, 25 Nov 2026 07:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591787;
	bh=K4N+z+qZkTaLCmo/VXO6ehCCwqsZm8UjOH4rKUfK5go=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lBI0c2gK320ivmsG0O2ZdnN1GMrIWh8lk4P2pCRrwZ1KyIUUyiDHP96LYAKrEsio+
	 1joiAEZI+boLyx0VeR+FMrC0uoshI+yaml2dtyXyX4EgLyvYBPpX07wvTcGUI4nwZx
	 VIiEJC3HJtjnAWI6eP8En+VbJMw1/Gw22VWI2CKgwuywrsZtgrvHambO2+nDSM5Bzl
	 t5HEz1nE04tMlu45VLVxnq8yhrg1MEMW+nPncQRerzLudsRe82XyUZbXQDO76zASm8
	 AN9UamQV54mWbYgXAr3RQw1ai4rmjNmIkrc+6TTKyt7iVtWWW90XYPx6gcf7gcra1x
	 BoXEW8yTM4a9A==
Message-ID: <sashiko-outbox-232800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] rtc: pcf85063: clear the wake IRQ on unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Prasanth R" <ragaprasanth@gmail.com>, linux-rtc@vger.kernel.org
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261125072026.2997493-12-prasanth.r@lineo.co.jp>
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
 <20261125072026.2997493-12-prasanth.r@lineo.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 07:29:46 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rtc: pcf85063: Fixes trailer cites 05cb3a56ee8c instead of
  a3c7f7e16ea8f
--

commit 02e3d5d53e616f78f39dfc9fe5c12cd70b022082
Author: Prasanth R <ragaprasanth@gmail.com>

> rtc: pcf85063: clear the wake IRQ on unbind
>
> The driver has no remove callback, so the wake IRQ set with
> dev_pm_set_wake_irq() and the wakeup source enabled with
> device_init_wakeup() are never released on unbind.
>
> When the driver is bound again, dev_pm_set_wake_irq() finds the old wake
> IRQ, warns "wake irq already initialized" and returns -EEXIST, so the
> driver prints "failed to enable irq wake".
>
> Use the device-managed variants so both are released on unbind.
>
> Compile-tested only.
>
> I used an AI assistant (Claude) to find this and write the change.
>
> Fixes: 05cb3a56ee8c ("rtc: pcf85063: add alarm support")
> Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>

[Severity: Low]
In 05cb3a56ee8c ("rtc: pcf85063: add alarm support"), this driver only
registered an i2c_driver, and the I2C core's i2c_device_remove() already
calls dev_pm_clear_wake_irq() and device_init_wakeup(dev, false) on
unbind.  The unbind leak only became possible when SPI support was added
via rv8063_probe(), since spi_remove() does not clear the wake IRQ or
wakeup source.  Should the Fixes tag instead be:

  Fixes: a3c7f7e16ea8 ("rtc: pcf85063: add support for RV8063")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125072026.2997=
493-1-prasanth.r@lineo.co.jp?part=3D11
