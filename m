Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9838236F
	for <linux-rtc@vger.kernel.org>; Sat, 22 Aug 2026 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391556; cv=none; b=ID7xa/6Ma5e7y3AWd4oU1ycYzPscTLCU9usEMcpZ7y+9iJChwjdCRFRvJKPDW+IA6ffL7G54l4ZKO7hg6X7dlzx26E7sdtmSV/jvqyPuAb9uZPhKMksAtKYrYm+tuoY740y+7un0R7dJSyxtu8P298g4FlBZf8JI+Z5Jq5EJrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391556; c=relaxed/simple;
	bh=ykcZF4zblq+YGeQRn36CBvu3+BfdinMrf67cPmb+4mI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TWJhG2xk7/yIYkiwfHmXOykAtFVDUYh/WkGrPgkovk8bVDZ74Cq5dEE1jzWI4w8lx5Qqzr9xHciCKH1IcCkKKLrSCRPBvoqX8IHXlySoCYXEoRxmjWlbvVeqbbwrWnEoAkPeuhmOuPcfgACy7yVjrWTWW2imAFNnsTk9Wq5pWZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChnxYd5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChnxYd5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CD41F000E9;
	Sat, 22 Aug 2026 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787391554;
	bh=TMQKfjbo3xkS2nGBrzFOZB81iBF5ErbmPcg36jV/3tU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ChnxYd5/r+y9+HraFgzeNsyyB+QDrum+NAh4g5zddz7mn+5mASku5ucJQDaJtj62+
	 8LRYFYbO9tq/nFPCh2NV1UyQQuxzuYJ4TUsN122tV3/zCk04/PO/Dpr5Pc2CiWzYqo
	 2O7H2lzFmxMtALIlQosVdyyGqlzxOobQ+mlJKPisYKuzitsKLEfmSSR4knitiYqPSt
	 NvFtlH3Z7wbfRff48B9WIz2S960caFC+EXgsBu0EmNJckskz9p+Qi7zGGzhiAynpft
	 VRA37U+CeIwqPFBSs8CYYG6OmobARByZiJuvrrdKHSF4uV2GouBOnf4pRwt0NC8o5L
	 p3gI5WsmJgqXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: rv3028: configure backup switch mode from device
 tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dhaval Shiroya" <dhaval.shiroya@siliconsignals.io>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260822092911.318342-1-dhaval.shiroya@siliconsignals.io>
References: <20260822092911.318342-1-dhaval.shiroya@siliconsignals.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:39:14 +0000
Message-Id: <20260822093914.95CD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Removal of the `RTC_PARAM_BACKUP_SWITCH_MODE` userspace parame=
ter breaks the userspace ABI.
- [Medium] Introduction of an undocumented, un-prefixed, and hardware-speci=
fic DT property `backup-switch-mode`.

Pre-existing issues:
- [High] The clock provider registered during probe is never removed, leavi=
ng a dangling pointer in the OF clock provider list when the driver is unbo=
und.
--

--- Patch [1]: [PATCH] rtc: rv3028: configure backup switch mode from devic=
e tree ---
commit 55d9a6511b8e26eb9e90d9e9a4a3d1d04b2c0f1b
Author: Dhaval Shiroya <dhaval.shiroya@siliconsignals.io>

rtc: rv3028: configure backup switch mode from device tree
   =20
Enable and set the backup switch mode directly from the device tree at
probe, instead of requiring a userspace RTC_PARAM_BACKUP_SWITCH_MODE
ioctl on every unit.

> diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
> index d96f6bb68850d..5dde1aed76dd7 100644
> --- a/drivers/rtc/rtc-rv3028.c
> +++ b/drivers/rtc/rtc-rv3028.c
[ ... ]
> @@ -852,8 +789,6 @@ static const struct rtc_class_ops rv3028_rtc_ops =3D {
>  	.read_offset =3D rv3028_read_offset,
>  	.set_offset =3D rv3028_set_offset,
>  	.ioctl =3D rv3028_ioctl,
> -	.param_get =3D rv3028_param_get,
> -	.param_set =3D rv3028_param_set,
>  };

[Severity: Critical]
Does removing the param_get and param_set callbacks break existing userspace
ABI?

Existing applications or scripts (like hwclock) that rely on querying or
modifying the backup switchover mode via the RTC_PARAM_GET and RTC_PARAM_SET
ioctls will encounter failures, as the API has been entirely removed from t=
he
driver.

[ ... ]
> @@ -920,6 +855,65 @@ static u8 rv3028_set_trickle_charger(struct rv3028_d=
ata *rv3028,
[ ... ]
> +static int rv3028_set_bsm_from_dt(struct rv3028_data *rv3028,
> +				  struct i2c_client *client)
> +{
> +	u32 val_old, bsm_dt, bsm_bits;
> +	int ret;
> +
> +	if (device_property_read_u32(&client->dev, "backup-switch-mode",
> +				     &bsm_dt))
> +		return 0;

[Severity: Medium]
Is this new device tree property documented in the binding schema?

Adding an undocumented, un-prefixed property that requires raw
hardware-specific bit values (0, 1, or 3) instead of a standard
vendor-prefixed property (e.g., "microcrystal,backup-switch-mode") will
trigger warnings during dtbs_check.=20

The device tree schema likely enforces unevaluatedProperties: false, which
will flag this missing schema definition as an invalid configuration.

[ ... ]
> @@ -1005,11 +999,14 @@ static int rv3028_probe(struct i2c_client *client)
[ ... ]
> -	set_bit(RTC_FEATURE_BACKUP_SWITCH_MODE, rv3028->rtc->features);

[Severity: Critical]
Does removing this capability flag cause the kernel to reject userspace
attempts to configure the parameter?

This reinforces the ABI break mentioned above, preventing any userspace
process with access to the RTC device node from interacting with the backup
switchover mode.


While reviewing this patch, I noticed a pre-existing issue in the surroundi=
ng
clock registration code:

drivers/rtc/rtc-rv3028.c:rv3028_clkout_register_clk() {
    ...
    of_clk_add_provider(node, of_clk_src_simple_get, clk);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this leave a dangling pointer in the
OF clock provider list when the driver is unbound?

The clock object is allocated and registered using devm_clk_register(), mea=
ning
devres automatically frees the clk structure when the device is unbound.
However, of_clk_add_provider() is a non-managed API that registers the clock
provider globally.=20

Because this driver lacks a .remove callback to unregister the provider, a
subsequent clock lookup after unbind could attempt to use the freed structu=
re,
leading to a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822092911.3183=
42-1-dhaval.shiroya@siliconsignals.io?part=3D1
