Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A263B14D4;
	Fri, 31 Jul 2026 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524578; cv=none; b=o+BqB80Z3Q6Ow8+PO/v8yfn5ZmKV4Dx5W+ulhyU8iVxEvlOUaloV3mByKC7sg9Uiopy9d/XE5r3LHOm9DJWumHZFZHva8OmAYSSHGdbRqj9sTtxcxZVutazDYRS8hWZ9DDPYGaoR0A4f81jCkgdD749oOBKNf9yKhYRRKa+3bKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524578; c=relaxed/simple;
	bh=Sxk0wqTCliXyPRH/1z52qtAayY4Gc3NUA3t5qYr8t4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z6wd7rdaXp7RHfGfyLLAF3mFPetPArBZuzEnDDBlMg4EoxZ/X3VLed7uyfQdwXD4SGEBRrvEB0G41diAZU37vkBHlm9NZM8Cs1XKFkurlz2o/eO09f28XofpBNpOc3CjOzg3j7/bkWvKNSQvP07KfjhJ9BAhBOq44aJIn/1rBNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSeeKsQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSeeKsQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F771F00AC4;
	Fri, 31 Jul 2026 19:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785524577;
	bh=aWmlj5o5afD5NfrsGmC9eNMt5B17Zqf6dzxfAJYwC+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cSeeKsQkW7iQgoURyjsKourzJ+FhWNFB4nmGpdzHI5TbGB2HWM2r/HU4FqZE/opyw
	 HJ7UAEjkfxjXM++0OHgoSEvfaq6B4lIIDdXqBwlRuseBuWkI6KKiWnUl9aPN72B0tr
	 1XwQGcH3BqXPRWPSKSYIKTR7CaDXu3JbzczjikA6TBCkFg0ujPs9GzK+9uWXiwfpEv
	 6x/L0qpF05q7HTndQw/OsEj/04yZF0WCkfAqfj7GfylzO9od0HC7JHwnPF3uslTOIz
	 /sf6pT5yHrnj8yZwW0GlqBam+HEBGy3hxhA413sIkCn49vaXBnQXmaIZn72kFOeFxL
	 4af1m2YKXbVaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] rtc: abx80x: add mutex protection for register
 writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260731184831.44037-3-apokusinski01@gmail.com>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-3-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:02:55 +0000
Message-Id: <20260731190257.45F771F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Build failure due to jumping over a `__cleanup__` variable declarat=
ion in a switch statement.

Pre-existing issues:
- [High] Shared IRQ handler unconditionally returns IRQ_HANDLED and clears =
the status register, risking interrupt storms and breaking battery low dete=
ction.
- [High] Missing mutex protection on I2C reads allows them to interleave wi=
th and silently break multi-step configuration key write sequences.
--

--- Patch [2]: [PATCH v3 2/8] rtc: abx80x: add mutex protection for registe=
r writes ---
commit d3bc95e6c97e9f4f1dbb461f4986e984a4ccd25a
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add mutex protection for register writes

The ABX80X RTC driver performs multi-step register operations such as
NVMEM transfers or register writes preceded by a configuration key
write. Add a mutex to serialize all the register writes to protect
these sequences against race conditions.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 5486d9d0b1e5d..8d791b9ec7d21 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -219,6 +221,7 @@ static int abx80x_rtc_read_time(struct device *dev, s=
truct rtc_time *tm)

[Severity: High]
This is a pre-existing issue, but should I2C reads like those performed in
abx80x_rtc_read_time() also be protected by the new mutex?

If an unprotected I2C read interleaves with a protected multi-step write
(such as abx80x_rtc_set_autocalibration()), it can reset the configuration
key on the hardware. This would cause the target register write to be
silently ignored.

>  static int abx80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
[ ... ]
> @@ -263,6 +268,8 @@ static irqreturn_t abx80x_handle_irq(int irq, void *d=
ev_id)
>  	struct rtc_device *rtc =3D priv->rtc;
>  	int status;
> =20
> +	guard(mutex)(&priv->lock);
> +
>  	status =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
>  	if (status < 0)
>  		return IRQ_NONE;

[Severity: High]
This isn't a bug introduced by this patch, but does this interrupt handler
unconditionally clear the status register and return IRQ_HANDLED later in
the function?

If a shared device or spurious interrupt triggers abx80x_handle_irq(),
returning IRQ_HANDLED for unrelated interrupts prevents the core IRQ
subsystem from disabling a stuck shared line.

Additionally, writing 0 unconditionally clears all flags, including
ABX8XX_STATUS_BLF, which prevents userspace from detecting a low battery.

[ ... ]
> @@ -539,6 +559,8 @@ static int abx80x_ioctl(struct device *dev, unsigned =
int cmd, unsigned long arg)
>  		return put_user(tmp, (unsigned int __user *)arg);
> =20
>  	case RTC_VL_CLR:
> +		guard(mutex)(&priv->lock);
> +

[Severity: Low]
Does this cause a build failure?

The guard macro declares a cleanup variable inside the switch statement
without a surrounding compound block. Any other ioctl command jumping to the
default label will bypass the variable's initialization, which GCC usually
flags as a hard error.

>  		status =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
>  		if (status < 0)
>  			return status;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731184831.4403=
7-1-apokusinski01@gmail.com?part=3D2
