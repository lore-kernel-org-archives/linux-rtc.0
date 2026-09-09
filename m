Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E949157982C;
	Wed,  9 Sep 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964487; cv=none; b=K+8MQBIeayAYxGYpF048FRbZJgCU3EEEzQAjmqIaGQFuktSSpS+sxNBY99f3ozEHkk9kPgL1Z1evcULG41SOICKZoq46/3Bt8qNuf/a4mXqIg6guzIXxd9T7RaIoqRMN8QhqRvBZRIX6NQs7WzRzuPlBVY842sQO8gvYiw5zmHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964487; c=relaxed/simple;
	bh=5ZphuIZheKokBeZCnzL7vVPrW944hqFbB8fS4HNJfWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=So+Vpm5cqefDQdWxEjOZotwHN0GThlo0WaIqoM0+vKrPTSegz55ECN5JxeUQItCFEE8nINZpm20Zw4HAUaniOli7sv2gB9bE1MpAJH1mTSrgOhAeurNixA8S0w69YPRkITYpmTaettJPiMqA5SeetHTjHawI+tWCobe9RoywX2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jp4jjyyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jp4jjyyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CDF1F00A3D;
	Wed,  9 Sep 2026 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964485;
	bh=pCe4wRAHjUOVrleH/SJn/pJ/jk5WQCArtXnv/geWzxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jp4jjyyQ+GsuQ9uVI32QAX3jNEsr09KaLjdoknaRrmqlyRdClVocaP9PUVRDqKyYC
	 1sbWuvdNSKK7P/qGT5G34AWEQ0RGW7rPjf5byxgqJ1cITuA6h4R7/VZACUv+c9IiSE
	 iyZo8mM/3Kmpu7thfb6xczxmeiETSxvxQ1yklOLbdw08yfDhDlrYE4bfZTGi5wenpy
	 O8+KObHrnXyITBy48RLcH5QtE+5dBNVMZo4EhYTsu/9tJo7YVEAKICZlENqMFBHlzF
	 DjYfcnkmL9B5GrJ4d4FqgCfo+xi88+VkUEaZs2vCkb6TQQkmv5S8sDQ90UsYZaxwd4
	 uQxaO0sZYtUiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260909141300.1368790-3-sander.speetjens@gmail.com>
References: <20260909141300.1368790-1-sander.speetjens@gmail.com>
 <20260909141300.1368790-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:34:45 +0000
Message-Id: <20260909143445.78CDF1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The device tree node reference acquired via of_parse_phandle() is =
never released.
- [High] The firmware reference is leaked on probe errors and during driver=
 unbind.
- [High] The driver leaks the wakeup source allocated by device_init_wakeup=
() on error paths and module unload.
- [Medium] The driver truncates 64-bit timestamps to 32 bits and fails to c=
onfigure RTC range bounds.
--

commit 3148e2d83cccdbeec926774910d9505646955095
Author: Jonathan Bell <jonathan@raspberrypi.com>

rtc: Add Raspberry Pi 5 RTC driver

Upstreaming the downstream Raspberry Pi 5 RTC driver.
This driver supports the custom DA9091, which is accessed through the firmw=
are
mailbox.

> diff --git a/drivers/rtc/rtc-rpi.c b/drivers/rtc/rtc-rpi.c
> new file mode 100644
> index 0000000000000..e455b4116957d
> --- /dev/null
> +++ b/drivers/rtc/rtc-rpi.c
[ ... ]
> +static int rpi_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct rpi_rtc_data *vrtc =3D dev_get_drvdata(dev);
> +	u32 data[2] =3D {RTC_TIME, rtc_tm_to_time64(tm)};

[Severity: Medium]
Does this code silently truncate the 64-bit timestamp when it assigns the=20
return value of rtc_tm_to_time64() to a u32 array element?

Since rtc->range_max is left unconfigured (defaulting to 0), the RTC core=20
does not enforce bounds checks. Thus, if a user attempts to set a date beyo=
nd=20
year 2106, the timestamp will be truncated here, leading to silent hardware=
=20
time corruption.

[ ... ]
> +static int rpi_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rpi_rtc_data *vrtc;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct device_node *fw_node;
> +	struct rpi_firmware *fw;
> +	int ret;
> +
> +	fw_node =3D of_parse_phandle(np, "firmware", 0);
> +	if (!fw_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}

[Severity: High]
Can this of_parse_phandle() call leak the device tree node reference? It=20
acquires a reference to fw_node unconditionally, but I do not see a matchin=
g=20
of_node_put(fw_node) in this function to release it once it is no longer=20
needed.

> +
> +	fw =3D rpi_firmware_get(fw_node);
> +	if (!fw)
> +		return -EPROBE_DEFER;

[Severity: High]
Does this leak the firmware reference if the driver fails probe later, or i=
s=20
subsequently unbound?=20

The rpi_firmware_get() function increments a reference count on the firmwar=
e=20
object. Since there is no cleanup on error paths, nor a devm_rpi_firmware_g=
et()=20
variant used here, the resource appears to be permanently leaked when probe=
=20
fails.

> +
> +	vrtc =3D devm_kzalloc(&pdev->dev, sizeof(*vrtc), GFP_KERNEL);
> +	if (!vrtc)
> +		return -ENOMEM;
> +
> +	vrtc->fw =3D fw;
> +
> +	device_init_wakeup(&pdev->dev, 1);

[Severity: High]
Could this leak the wakeup source allocated by device_init_wakeup() on erro=
r=20
paths and during module unload?=20

Because device_init_wakeup(&pdev->dev, 1) allocates a wakeup source, failin=
g to=20
call device_init_wakeup(&pdev->dev, 0) during probe failures leaves the wak=
eup=20
source dangling.

> +
> +	platform_set_drvdata(pdev, vrtc);
> +
> +	vrtc->rtc =3D devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(vrtc->rtc))
> +		return PTR_ERR(vrtc->rtc);
[ ... ]
> +	vrtc->rtc->ops =3D &rpi_rtc_ops;

[Severity: Medium]
Should rtc->range_max be properly configured before device registration?=20
Without configuring the bounds, the RTC subsystem permits out-of-range time=
s=20
that will trigger the truncation issue noted earlier in rpi_rtc_set_time().

[ ... ]
> +static struct platform_driver rpi_rtc_driver =3D {
> +	.probe =3D rpi_rtc_probe,
> +	.driver =3D {
> +		.name =3D "rpi-rtc",
> +		.of_match_table =3D rpi_rtc_dt_match,
> +	},
> +};

[Severity: High]
Is a .remove callback missing here to handle driver unbinds? Without it, th=
e=20
firmware reference acquired by rpi_firmware_get() and the wakeup source=20
allocated by device_init_wakeup() will be leaked whenever the driver is unb=
ound=20
by a local administrator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909141300.1368=
790-1-sander.speetjens@gmail.com?part=3D2
