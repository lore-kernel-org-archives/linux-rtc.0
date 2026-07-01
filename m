Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844B481A9E;
	Wed,  1 Jul 2026 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909751; cv=none; b=ZjscdGfSa0wghSEWtYytNf09ER9+Qr4tl+vRffHkI7p4M4/ULxSoevNY1ytHbRo6HrA+fN3Hml2Z0Var/uk5UCSb3Ihg3boHrTp7zM9iqfYAm7P5ELoPbXcACm0n+Jz8g/YKSGeLA0XjfqejOdBBmUyopgK48POrFrTC5ihFxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909751; c=relaxed/simple;
	bh=R9FIIyC7v3yveCxvL9Sv1vZG8pY5UgbwEw7oji3WHXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ss8Zf0h2eNY91WYfItCvcLOe236XhXLv9znEM+HWji6Gg8xu8DJ1K4cCB0JERrrm8AwTz6lCJpN4mLmBChbi+ggW7r/x5RvKiMYJYV/77D5oMuGDwogwmeR/NfzPowMOHVbaDQhnegHTHs5Y8qLhmJ9sXPNJXCGfFcZiAv+Ay+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GVd6D98n; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GVd6D98n"
Date: Wed, 1 Jul 2026 15:42:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782909747; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=IvyP+6IBPo+SaCxxlxcFooQLBfZsZ2IQR6meFJNWH0U=;
	b=GVd6D98nTKzRfR7N6XBoHPEIFSrR+XSx7395C2O9sfsMpzevU0JZxH18gRX/q/66qzY7Ly
	u6LC8cGO2kFC8wbH6IMeP3GIwpfP6an6ny7rdxEGPnnqetkE8013xocU/W4I4TeZ5wjPxX
	p2HAEKShkuY/ItN9wZPORiZNzPBJ6S0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 4/8] rtc: bd70528: Support RTC on ROHM BD73800
Message-ID: <d9f5b1c6b165699627c7cf127a7ec64d28e15cca.1782909323.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1782909323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opg1Xu82DhyF1m53"
Content-Disposition: inline
In-Reply-To: <cover.1782909323.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--opg1Xu82DhyF1m53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

BD73800 contains similar RTC block as BD71828 and BD71815. Only the address
offsets seem different. Support also BD73800 RTC using the rtc-bd70528.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/rtc/rtc-bd70528.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
index 482810b61495..fd415e327ea6 100644
--- a/drivers/rtc/rtc-bd70528.c
+++ b/drivers/rtc/rtc-bd70528.c
@@ -8,6 +8,7 @@
 #include <linux/mfd/rohm-bd71815.h>
 #include <linux/mfd/rohm-bd71828.h>
 #include <linux/mfd/rohm-bd72720.h>
+#include <linux/mfd/rohm-bd73800.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -284,6 +285,12 @@ static int bd70528_probe(struct platform_device *pdev)
 		bd_rtc->bd718xx_alm_block_start =3D BD72720_REG_RTC_ALM_START;
 		hour_reg =3D BD72720_REG_RTC_HOUR;
 		break;
+	case ROHM_CHIP_TYPE_BD73800:
+		bd_rtc->reg_time_start =3D BD73800_REG_RTC_START;
+		bd_rtc->bd718xx_alm_block_start =3D BD73800_REG_RTC_ALM_START;
+		hour_reg =3D BD73800_REG_RTC_HOUR;
+		break;
+
 	default:
 		dev_err(&pdev->dev, "Unknown chip\n");
 		return -ENOENT;
@@ -344,6 +351,7 @@ static const struct platform_device_id bd718x7_rtc_id[]=
 =3D {
 	{ .name =3D "bd71828-rtc", .driver_data =3D ROHM_CHIP_TYPE_BD71828 },
 	{ .name =3D "bd71815-rtc", .driver_data =3D ROHM_CHIP_TYPE_BD71815 },
 	{ .name =3D "bd72720-rtc", .driver_data =3D ROHM_CHIP_TYPE_BD72720 },
+	{ .name =3D "bd73800-rtc", .driver_data =3D ROHM_CHIP_TYPE_BD73800 },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, bd718x7_rtc_id);
--=20
2.54.0


--opg1Xu82DhyF1m53
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmpFCywACgkQeFA3/03a
ocXD8Qf8DPGjAv6Z697J0P6vwwgEi6/pfKwWCGv14HNNOKH5tHiqqtPGFw5ZhW1C
Ch36520fY578Krn2pwAlXMU4Yz6hiHNW/g/U3vIgHAYCr+bH+2c00/1yHDTuDlmw
cF5I30ELpEpXSW1L0M41KmdN7kR/gTa8Hzr5EGk2XQ697BIj0VjuyupPZZul7IQg
0RP1FvdQqXffQcqLIJVtLFOfbK07D5cp8qBpEQ6/qbq5SU9Yec+9R3IYiLRKOF66
LbYKpuokxlYPNJzBJqaT35NAGsMNDRqgTK5R3qTxMHUkKyHdB/4+3nWGwt8f4mE+
xEA7PVsJLxDjSuVT0zNmcZmjnvNIRA==
=9kOM
-----END PGP SIGNATURE-----

--opg1Xu82DhyF1m53--
