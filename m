Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5299D3E7BA4
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539112; cv=none; b=BWYOaaZ4ZMLcgldfCSVt8aH3a4Z1PhkFy5LbyzNsPlgmu8v4+jvoFdl5XDgbM1jB8GkV1RJb5GkXeBY33sYjELyt6H7hno6kGFgqDcBFryQFs9KlMW8NjFM4dXayW27Em8ZFIBP+a/Ii82MORSX9TDXDDRkRSxQZarsMolXQFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539112; c=relaxed/simple;
	bh=VXwO83M9KpJNhhrNrPem4kfqilh6faWrFpnl5L0fdXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOFaIP7QELcbDefsmvKOn2QsfjbIO2+4Zpswc0z6KtRnecs8H9jvG2J8vUv2n1QempQpjYBDm3j44KWAtwrJhq0NkulE+r1hHvu8YYIspRl+u4Cd2CWnF9EQtuqxnZYPnPQN5m2Fkm10foKMotgaCf3eKjgz+yju8+ORZwpmSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGY8hwQa; arc=none smtp.client-ip=91.218.175.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iGY8hwQa"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VXwO83M9KpJNhhrNrPem4kfqilh6faWrFpnl5L0fdXY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789539108; v=1; x=1790143908;
 b=iGY8hwQaS6sYLw6yfPB/LbgPub9BjEcnwskjQyq5X2za4bKNw1XtamB9qOOg3+Ye9UMH07wq
 w6oFGr652TQt+G9X9int/JTpTJ9G79YAOWuwy6L24LSiMJ7pOnqmm1GnYd3y9HMff+sbDcMmDPN
 SWxWhKGXhFJPTb2NgijxRkjo=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 726c8225cd7793a8;
	Wed, 16 Sep 2026 06:11:48 +0000
X-Mizu-Trace-ID: 726c8225cd7793a8
X-Migadu-Flow: FLOW_OUT
Date: Wed, 16 Sep 2026 09:11:42 +0300
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
	linux-rtc@vger.kernel.org, Sverdlin@mva-rohm,
	Alexander <alexander.sverdlin@siemens.com>
Subject: [PATCH v4 08/10] clk: bd718x7: Support ROHM BD73800
Message-ID: <dfc72dbe7227d830040ae32c7f55cc18cf42f75d.1789538455.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1789538455.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uZgQwnt+iwcukcVS"
Content-Disposition: inline
In-Reply-To: <cover.1789538455.git.mazziesaccount@gmail.com>

--uZgQwnt+iwcukcVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD73800 PMIC has a 32.768 kHz clock gate. Add support for
controlling this clock.

NOTE: The CLKOUT pin can be muxed by an OTP option. On some OTP
configurations the CLKOUT is not outputting the clk signal.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

---
Revision history:
 v4:
  - No changes
 v2 =3D> v3:
  - Use named initializers for platform_device_id
 v1 =3D> v2:
  - No changes
---
 drivers/clk/clk-bd718x7.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index 8ddb50c67757..1698b763bcb7 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -21,6 +21,9 @@
 #define BD718XX_REG_OUT32K	0x2E
 /* BD72720 */
 #define BD72720_REG_OUT32K	0x9a
+/* BD73800 */
+#define BD73800_REG_OUT32K	0x50
+
 /*
  * BD71837, BD71847, and BD71828 all use bit [0] to clk output control
  */
@@ -123,6 +126,10 @@ static int bd71837_clk_probe(struct platform_device *p=
dev)
 		c->reg =3D BD72720_REG_OUT32K;
 		c->mask =3D CLK_OUT_EN_MASK;
 		break;
+	case ROHM_CHIP_TYPE_BD73800:
+		c->reg =3D BD73800_REG_OUT32K;
+		c->mask =3D CLK_OUT_EN_MASK;
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown clk chip\n");
 		return -EINVAL;
@@ -152,6 +159,7 @@ static const struct platform_device_id bd718x7_clk_id[]=
 =3D {
 	{ .name =3D "bd71828-clk", .driver_data =3D ROHM_CHIP_TYPE_BD71828 },
 	{ .name =3D "bd71815-clk", .driver_data =3D ROHM_CHIP_TYPE_BD71815 },
 	{ .name =3D "bd72720-clk", .driver_data =3D ROHM_CHIP_TYPE_BD72720 },
+	{ .name =3D "bd73800-clk", .driver_data =3D ROHM_CHIP_TYPE_BD73800 },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, bd718x7_clk_id);
--=20
2.55.0


--uZgQwnt+iwcukcVS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqqMx4ACgkQeFA3/03a
ocWFyAgAltfwcfF+plcebv5LiTQi4qh+SKBSP3yrkEQm4yDSOWfnN0Xz5GRPR0Hd
RwCQC/Y7pPeqj3nLROZ2GcrCSZfSrThc5Gr9sMSh5iqyboExZ85iE4qgngZi1Xns
Jtu73aGjITbuH8nWwV1sqUPjR59S58DH38r0JbwbFNutl0/6/EnmaiRRux3cYGxu
aVrAhNmH22tkUWPFN2wBEhtBnB17bgxoHlpPNjFHVin7Nc0ZKJzb4nr2ozJtiP/m
/x7Rk8972pz3pBQ3oAmxRPqGEFwkHzhfnIgpTQ0y5aI5mBviIhcb9ZV1RUsqzpjh
oOBuylNEYO3IgMxB9ILBAENZTdIpjA==
=K3Z2
-----END PGP SIGNATURE-----

--uZgQwnt+iwcukcVS--
