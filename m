Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CEE3B6BFA;
	Fri, 31 Jul 2026 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524692; cv=none; b=ML2UdLrzXqhJHAxjjkRrbzviSC3qsOiOfp+r9RPyrUDbQdHeP50MnT3NbrxGmizH6h99TKgMBfd6FBU3yJSY+ZBRIh2zNocgz2rA72xc9GGcb/uvE/tPCzzZRYI23rFZDv4EZTDKCMfkM5Z9J1R6zt96YdZ/8O5sy2pBlUuhXQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524692; c=relaxed/simple;
	bh=imyYxyxaCLJ/mvRJCbUGirvtfosEh5n7xz3m6sQCOn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gp8yNi+zVL0641RDg6aCjTG5vdQ6pjz1ILG4X06ZoAPl4GWKSyAODg/azweB2sFraVppK727oasz/1lDGS/mp3kRz5uymXtbZPOza7OU06BWthCGfiouZOVwTRdL1BdFZJJL/CTAxqcrkRlvnnzDYwBvaHBB1hLJGE4UAetqgfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n26CYXFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n26CYXFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548A81F00AC4;
	Fri, 31 Jul 2026 19:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785524690;
	bh=ICb3bKjTv1PyeJpIKhnSN37lQMThM4PqHy3ZbIKDt1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n26CYXFcAmOhgbwQ0wd7qtb8M9eaU8gHEG505Yerc+/s02bSbCJ0GYAOljmKvXIl7
	 NHlf0c59ooHGTjskWD0Kz3cWrXQ8Bhr104/CBPB7YU9jeQXhhI5pnVJDGQcBrSg8t2
	 5ucGohNpla6S4NHZcq1te+WGe0YqhMo0fKiXMbhjhJ3LeDOKpostUazxC4hn/2Gaix
	 LXK09ovCyCFq4Z7BvV4F1vp/wR9HHVj37G4N3Hg5ZifZWQXu+cn7wC10J4ion1wGLZ
	 hbCmymtrFazSuyYiKXNJIJh2+YQTEXJ7JE+QnZJ8Jc2v5NKweM/wyznnrCB+7/ruy1
	 EZwm9tG2JhDTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] rtc: abx80x: add irq to struct abx80x_priv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260731184831.44037-5-apokusinski01@gmail.com>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-5-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:04:49 +0000
Message-Id: <20260731190450.548A81F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Read-modify-write of the status register introduces a race conditi=
on that loses interrupts.
- [High] Unconditional failure in `abx80x_read_alarm` due to incorrect hand=
ling of `i2c_smbus_read_i2c_block_data` return value.
--

--- Patch [4]: [PATCH v3 4/8] rtc: abx80x: add irq to struct abx80x_priv ---
commit be354d8ef94de08e1314876fad55888243ca019f
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add irq to struct abx80x_priv
   =20
This adds the irq field to struct abx80x_priv so the interrupt number is not
strictly tied to the i2c_client structure. This allows it to be more easily
accessed for ABX81X SPI clocks.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -299,11 +300,12 @@ static irqreturn_t abx80x_handle_irq(int irq, void =
*dev_id)

[Severity: High]
This is a pre-existing issue, but I noticed a potential race condition with
the status register.

In abx80x_handle_irq(), there is a read-modify-write sequence:

	status =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
	...
	i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
				  status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));

If a hardware interrupt (such as an RTC alarm or watchdog) sets a new flag
in ABX8XX_REG_STATUS exactly between the read and write calls, wouldn't the
write operation write back a 0 for the newly set bit and inadvertently clear
it without handling it?

This same pattern appears to be present in abx80x_ioctl() as well:

	tmp =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
					status);

Could this cause hardware interrupts or status flags to be silently dropped?

>  static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct abx80x_priv *priv =3D i2c_get_clientdata(client);
>  	unsigned char buf[7];
> =20
>  	int irq_mask, err;
> =20
> -	if (client->irq <=3D 0)
> +	if (priv->irq <=3D 0)
>  		return -EINVAL;
> =20
>  	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,

[Severity: High]
This isn't a bug introduced by this patch, but does this error check work
as intended?

i2c_smbus_read_i2c_block_data() returns the number of bytes read (which
would be 7) on success.

Looking at the code just below this in abx80x_read_alarm():

	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
					    sizeof(buf), buf);
	if (err)
		return err;

Wouldn't this evaluate to true on a successful read, causing the function
to prematurely abort and pass the byte count back as an error code?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731184831.4403=
7-1-apokusinski01@gmail.com?part=3D4
