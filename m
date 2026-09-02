Received: from mta1.migadu.com (out-133.mta1.migadu.com [95.215.58.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A1746F4A7
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347126; cv=none; b=ixGGV4neJaE0Vy8SbbHa2rnZ7EwtIa6DnZxB5ygOkyPuL+lcUIfQE/aoITaNEsQMKKL19jkQAvQ4pr09Jpa948q9M59K5nNwluWnWgkXrdF54CJyRDhJTZfyG5mo+UuGz56DTtHlFKGtceHupW/72I6NX/Pu24/hCEjlLDQm7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347126; c=relaxed/simple;
	bh=HaNYEnH8LVUlMmFL5E2ONB5bXrGpyqsXd9iFMN8eYbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfMG+BBuhO2Le8avY35aAlbxJDbZ63MWMsZvkb1wl295ZUATuiJrsF6gyZuCqCQbW33p4m0513hmVbHw/B8Oqi3Hb1+F1QNq+uq9w1Wy0mGtfWBmo8O+RAe/1OqyiyoqvF0dbLMip9G3ZRDZjxeBq0jNXzECU1+trDdTlUsTnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pU7jKEQI; arc=none smtp.client-ip=95.215.58.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pU7jKEQI"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HaNYEnH8LVUlMmFL5E2ONB5bXrGpyqsXd9iFMN8eYbQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788347122; v=1; x=1788951922;
 b=pU7jKEQI4LlILKRWKRTcFxOiSSjBsF8PsthjYgBY1cYw9o7aWtLtNocjkzonpnnF4JA4Zn9H
 Xic+iYk9vsQlftLF1DV1YlzSB8DpPzHlYS9SlxCeXE7qszUHciEekgmMmKXFPW1BsF3XpBeZzJT
 pm8GIVQOD+t9why+K9eaBAOM=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 8e0f7be38ebc2042;
	Wed, 02 Sep 2026 11:05:15 +0000
X-Mizu-Trace-ID: 8e0f7be38ebc2042
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 14:05:11 +0300
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
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v3 06/10] rtc: bd70528: Support RTC on ROHM BD73800
Message-ID: <ea824a4e5e14912140be801c8efa4dd658ade260.1788346553.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZbYZHO2k6nhQcAFN"
Content-Disposition: inline
In-Reply-To: <cover.1788346553.git.mazziesaccount@gmail.com>

--ZbYZHO2k6nhQcAFN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

BD73800 contains similar RTC block as BD71828 and BD71815. Only the address
offsets seem different. Support also BD73800 RTC using the rtc-bd70528.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

---
Revision history:
 v1 =3D> :
  - No changes
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
2.55.0


--ZbYZHO2k6nhQcAFN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqYAucACgkQeFA3/03a
ocXMBgf/TUt9DOWU0huBBQ/MfEOupg3r4aPH5gSN10GPm11yxis34Taox4c0BSiy
SpkFzrGRLMaApCAsdx5CPAnMaYElKQUObWPEXC22cB/d2xZb+d/VjsjNJ6UHLyJx
k8AGUdsyHj3ZLmzJRhifvdadW/ddIwitkxaBAY4CrQ6fQwAEfMAH8vmcgF+LlAhR
GShYcq2CV62ppZ1iWflizgHngTGWJTRqxgc74Tf5HP1SRvr4TYCZWcR9kkKLvW8+
O5aR5L+b5+t0ZeFLGK142eKDMftxroMHrTolAp5aU3SmAgYuG+CJyaFmqPg/wB0A
ZoVGJFzpV4CMCUFmcxOL0Zw1VC91vw==
=mYIV
-----END PGP SIGNATURE-----

--ZbYZHO2k6nhQcAFN--
