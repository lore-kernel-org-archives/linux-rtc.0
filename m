Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810962E7390;
	Sat, 25 Jul 2026 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992395; cv=none; b=rJJjQ98/5Zc9k0CS6tnXrwk3tguwqaHHjL9JEelXjsYUtekbPKZRvgx8rX7P+B9YHsieMjSMtl154ca56oZZOCbdH9Wl+IjArF6QTCoL1P6RBBQQ8YxNxfDiS2KwaCSaxxwKeq+RcE2WomaM1qGLqndUja+VN305+Vl1v9LWcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992395; c=relaxed/simple;
	bh=OlJsO+yolSCmcH5lOlFfLgTauXrJGEh126jMhJzt1GU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kEK5dun2IYubMDIjU+h1kCf2KfXxLTLy8c1JosEa0BkUOWeJOX9I0hwZgC82Z6ZuBolPZR0GqUKK2+HXmbFXKP49odOEihaJibzYRKX2LjrC+41xi6LStfW7CmZ6A7oWwIBuMdtb6Fir3eZA/PNc99zu2+rRdvU7JT3c/nL+v4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnIk0a6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnIk0a6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA151F000E9;
	Sat, 25 Jul 2026 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784992394;
	bh=b22KXc3I8mHbQ7fmP87zt6X6NL/bYclnX56VbZ8eHxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nnIk0a6U4ppatjBmJp1By2r3xpmnrDgrv89SU2Shw5TQqTvz3z2OIXDOJ3O5KUuDu
	 v4GE7dQ3dt/8M8TNiIGXkcu4T+R+knF6fcB2zxqGEr/cS2YnfVqlZLZzv0fCfSUAgE
	 T17sxUOdn81VK49g7Z+zSaqarsTPQ55wwF7uG2KbWwVA8j4k0DLqxpQQYRkVUimqyO
	 Nn0QQZXlslXWxedVQH37wMQGCr2kF/30LFqAPRk9wy8ruLKQjtsg3ORzpDegTJJ4u2
	 ak/Wxv6DFfbAaDNDVfnIL7LsV4TPMqFT5yOqurDUJWAXIJ01ghW3V+/ixuPVH1vlDT
	 9CMI77Xp20PQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] rtc: abx80x: use regmap instead of I2C specific
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260725145718.14733-6-apokusinski01@gmail.com>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
 <20260725145718.14733-6-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:13:13 +0000
Message-Id: <20260725151314.0DA151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The true error code from devm_regmap_init_i2c is discarded and m=
asked as a hardcoded -EIO.

Pre-existing issues:
- [Critical] Missing synchronization in NVMem transfer function leads to SR=
AM address page corruption.
- [High] Unprotected read-modify-write sequences on the RTC status register=
 (ABX8XX_REG_STATUS) between process context and the threaded IRQ handler.
--

--- Patch [5]: [PATCH v2 5/8] rtc: abx80x: use regmap instead of I2C specif=
ic API ---
commit 5491aafa92a95d35d02d312fb0fd904216ed5a97
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: use regmap instead of I2C specific API
   =20
Rework the driver so that it uses regmap_* functions for communication
with the device instead of the i2c_smbus_* API. This way the support for
ABX81X RTCs which use SPI can be added later.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index b83c789e213d6..3c5ab0ffbea84 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -279,36 +283,35 @@ static irqreturn_t abx80x_handle_irq(int irq, void =
*dev_id)
>  	 * reset kicks in.
>  	 */
>  	if (status & ABX8XX_STATUS_WDT) {
> -		dev_alert(&client->dev, "watchdog timeout interrupt.\n");
> +		dev_alert(dev, "watchdog timeout interrupt.\n");
>  		handled =3D IRQ_HANDLED;
>  	}
> =20
>  	if (handled =3D=3D IRQ_HANDLED)
> -		i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
> -					  status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));
> +		regmap_write(priv->regmap, ABX8XX_REG_STATUS,
> +			     status & ~(ABX8XX_STATUS_AF | ABX8XX_STATUS_WDT));

[Severity: High]
This is a pre-existing issue, but can concurrent read-modify-write sequences
on the ABX8XX_REG_STATUS register overwrite each other's changes?

The threaded IRQ handler abx80x_handle_irq() acknowledges interrupts with an
unlocked read-modify-write. At the same time, abx80x_ioctl() does an unlock=
ed
read-modify-write to clear the BLF bit:

abx80x_ioctl()
    case RTC_VL_CLR:
        err =3D regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
        status &=3D ~ABX8XX_STATUS_BLF;
        err =3D regmap_write(priv->regmap, ABX8XX_REG_STATUS, status);

If the ioctl races with the threaded IRQ handler, could this lead to lost
interrupt acknowledgments or lost battery low flags?

[ ... ]
> @@ -702,31 +704,27 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *pr=
iv, unsigned int offset,
>  	int ret;
> =20
>  	while (bytes) {
> -		u8 extram, reg, len, lower, upper;
> +		u8 reg, len, lower, upper;
> =20
>  		lower =3D FIELD_GET(NVMEM_ADDR_LOWER, offset);
>  		upper =3D FIELD_GET(NVMEM_ADDR_UPPER, offset);
> -		extram =3D FIELD_PREP(ABX8XX_EXTRAM_XADS, upper);
>  		reg =3D ABX8XX_SRAM_BASE + lower;
>  		len =3D min(lower + bytes, (size_t)ABX8XX_SRAM_WIN_SIZE) - lower;
>  		len =3D min_t(u8, len, I2C_SMBUS_BLOCK_MAX);
> =20
> -		ret =3D i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
> -						extram);
> +		ret =3D regmap_update_bits(priv->regmap, ABX8XX_REG_EXTRAM,
> +					 ABX8XX_EXTRAM_XADS, upper);
>  		if (ret)
>  			return ret;
> =20
>  		if (write) {
> -			ret =3D i2c_smbus_write_i2c_block_data(priv->client, reg,
> -							     len, val);
> +			ret =3D regmap_bulk_write(priv->regmap, reg, val, len);

[Severity: Critical]
This is a pre-existing issue, but does this missing synchronization lead to
SRAM address page corruption?

The NVMem core does not serialize device callbacks, which means two threads
could access NVMem concurrently. If Thread A updates ABX8XX_REG_EXTRAM to
select the address page, could Thread B preempt and update the same register
to a different page before Thread A performs its bulk write?

Would Thread A then write data to the wrong SRAM page?

[ ... ]
> @@ -779,6 +809,7 @@ MODULE_DEVICE_TABLE(i2c, abx80x_id);
> =20
>  static int abx80x_probe(struct i2c_client *client)
>  {
> +	struct regmap *regmap;
>  	struct device_node *np =3D client->dev.of_node;
>  	struct abx80x_priv *priv;
>  	int i, data, err, trickle_cfg =3D -EINVAL;
> @@ -793,8 +824,27 @@ static int abx80x_probe(struct i2c_client *client)
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		return -ENODEV;
> =20
> -	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ID0,
> -					    sizeof(buf), buf);
> +	regmap =3D devm_regmap_init_i2c(client, &abx80x_regmap_config_i2c);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Unable to allocate regmap\n");
> +		return -EIO;
> +	}

[Severity: Medium]
Should this code return the actual error code from devm_regmap_init_i2c()=20
(such as -ENOMEM or -ENODEV) via PTR_ERR(regmap) instead of discarding it=20
for a hardcoded -EIO?

Masking the original error code could make debugging initialization failure=
s=20
more difficult.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725145718.1473=
3-1-apokusinski01@gmail.com?part=3D5
