Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1BF3CB57F;
	Wed, 15 Jul 2026 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138493; cv=none; b=q7yqkXu6bhE/5R4ppvLtzz729qx5Fo52s3dz9o5zjSdcZ/UDbLApNBTzPQrfh1zzJ+zKkJZtOYJaUrWeXAHs8sGQ/o2XJdI4rwzZaKmoCpmWar79jSQ74Fjw1OJkNh9oNr4Q5Acb7mq98cypwS8rjjcCnTmwsKAtj21Ozv2NGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138493; c=relaxed/simple;
	bh=WVApe5VpNx1wY8noKbBLIB1nZ75rZxc1UuqR9nxWUeQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A7jhlVQ4vmAoiv9WQn7DuoFmm3BjxUVdPfPewreffMO+UF4MMcE7kBYHWLmPnmsli4etbERakeEBrEe4mYKGGGIWRzXa10rtim78SdrnnzsY7FXDt80itiriBffifJIH5gt0gYl3lYxjtMcy5ZfNViG2f5lOUgO3Pbk87do23kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQiRJPpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQiRJPpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22591F000E9;
	Wed, 15 Jul 2026 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138484;
	bh=mlxZwrSj52gIvTUPUdAYBmpMOM91NMc8x8fb2guLXC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oQiRJPpnZWv9R7Z2xH7O8qWxNmOgJ7Qz+OVrt4jR0NTAM6HOhwMXil/JASaTGkdng
	 deBtvUH2FGrZHCqGVP36zIFRL3QWrxVIWaOx+l5xDbaLYyxUXsnflnBY/pedVdGOn1
	 6oxQ9yUSnO4mxw/F4JlwgCtzosel5qarlhRFG9mQ+Iu8C3DRWC2YvSDtOG2mZHjEvE
	 Z/VOvMRd+S6+lY57v7e60Om9gdNZ2N5vVK1K/tfGWwQja0op4kD5PD6dMSi/1miLR+
	 dGPSQ3IGG2NaWjJ6GnBXXtYQZ1v3y6eLQmXLesKvPP1wr9NtoOPoE84q+cMo5wqhfo
	 LdFvD/RlTUcuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] rtc: make all reg_write callbacks take const void *
Reply-To: sashiko-reviews@lists.linux.dev
To: "Link Mauve" <linkmauve@linkmauve.fr>
Cc: linux-amlogic@lists.infradead.org, mfd@lists.linux.dev, Frank.Li@kernel.org, linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev, lee@kernel.org, imx@lists.linux.dev, ojeda@kernel.org, neil.armstrong@linaro.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260715175229.24672-4-linkmauve@linkmauve.fr>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
 <20260715175229.24672-4-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:01:23 +0000
Message-Id: <20260715180123.C22591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Implicit pointer conversions discard the 'const' qualifier, causing=
 compiler warnings.
--

--- Patch [3]: [PATCH 3/8] rtc: make all reg_write callbacks take const voi=
d * ---
commit dcceba66c45aeb1e0da5dfaf4cd7b3e0828ec69e
Author: Link Mauve <linkmauve@linkmauve.fr>

rtc: make all reg_write callbacks take const void *

This commit updates various RTC drivers to use a const void * parameter for
their nvmem_config write callbacks, aligning with the updated nvmem_config =
API.

> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index fa04ece151b8b..09da71a0009e8 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
[ ... ]
> @@ -659,7 +659,7 @@ static int cmos_nvram_read(void *priv, unsigned int o=
ff, void *val,
>  	return 0;
>  }
> =20
> -static int cmos_nvram_write(void *priv, unsigned int off, void *val,
> +static int cmos_nvram_write(void *priv, unsigned int off, const void *va=
l,
>  			    size_t count)
>  {
>  	struct cmos_rtc	*cmos =3D priv;

[Severity: Low]
Does this cause a compiler warning for discarded qualifiers?

In the body of cmos_nvram_write(), the code assigns val to a non-const
pointer just below the diff context:

    unsigned char *buf =3D val;
   =20
Should buf also be declared as const unsigned char * to avoid breaking
builds where warnings are treated as errors?

> diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
> index 6bafdec637aea..b6b401be09bb5 100644
> --- a/drivers/rtc/rtc-rv3032.c
> +++ b/drivers/rtc/rtc-rv3032.c
[ ... ]
> @@ -493,7 +493,7 @@ static int rv3032_nvram_read(void *priv, unsigned int=
 offset, void *val, size_t
>  	return regmap_bulk_read(priv, RV3032_RAM1 + offset, val, bytes);
>  }
> =20
> -static int rv3032_eeprom_write(void *priv, unsigned int offset, void *va=
l, size_t bytes)
> +static int rv3032_eeprom_write(void *priv, unsigned int offset, const vo=
id *val, size_t bytes)
>  {
>  	struct rv3032_data *rv3032 =3D priv;
>  	u32 status, eerd;

[Severity: Low]
Similar to the cmos driver, does this discard the const qualifier?

The rv3032_eeprom_write() function assigns the new const void *val to a=20
non-const pointer just below the quoted diff context:

    u8 *buf =3D val;

Should this be updated to const u8 *buf as well?

> diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> index b72eef4fb0997..73ff0491f6750 100644
> --- a/drivers/rtc/rtc-s35390a.c
> +++ b/drivers/rtc/rtc-s35390a.c
[ ... ]
> @@ -67,7 +67,7 @@ struct s35390a {
>  	int twentyfourhour;
>  };
> =20
> -static int s35390a_set_reg(struct s35390a *s35390a, int reg, u8  *buf, i=
nt len)
> +static int s35390a_set_reg(struct s35390a *s35390a, int reg, const u8 *b=
uf, int len)
>  {
>  	struct i2c_client *client =3D s35390a->client[reg];
>  	struct i2c_msg msg[] =3D {

[Severity: Low]
Does this assignment in s35390a_set_reg() trigger a discarded qualifiers
warning?

The struct i2c_msg defines its buf member as __u8 * (non-const). When the
msg array is initialized just below this hunk:

    struct i2c_msg msg[] =3D {
        {
            .addr =3D client->addr,
            .len =3D len,
            .buf =3D buf
        },
    };

Will assigning the const u8 *buf to the non-const .buf field cause a compil=
er
warning? Would it be better to explicitly cast it like (u8 *)buf to satisfy
the i2c_msg struct definition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715175229.2467=
2-1-linkmauve@linkmauve.fr?part=3D3
