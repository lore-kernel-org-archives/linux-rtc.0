Received: from mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC6477E52
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347161; cv=none; b=hsGHnIEUNC369OT6/fGBv3TFKQTtj5t3kOaWPq8h1uuqFj14OOyYQOW86rZh+PReblio2Az8ALjndt0hHAlb5fph5pLQj3uXnLGSavHbr17xDDP2Y7Gxjz0yIOS8VXn/z+XGg/0Ft30A8oktoS1Ypcede7lxIDuNFabxRsoWKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347161; c=relaxed/simple;
	bh=+RN7OEaS2RJa4iP5e8mwoll+FCOPeNzaEDLuiXoncPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsosaIOMhUGnn6EvghWuYxIvzIAV23/k2ubi20/2yVAC0WcOqgYufenEMts8C7tUyscPc0DYCPdD+8B1ouCqoRfW5lLfcC774lxBBcdBCOJKPsBKyYxJjC9Ti3zQ4WXpQhBM5ybFiB/1iUynTqrc3tbIqBZyRagRLEBZdMZM04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pqDEG48i; arc=none smtp.client-ip=91.218.175.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pqDEG48i"
X-Envelope-To: linux-rtc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+RN7OEaS2RJa4iP5e8mwoll+FCOPeNzaEDLuiXoncPY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788347154; v=1; x=1788951954;
 b=pqDEG48iUtHH1JVaqe0YWn9JOCTVnaTLlVdnS2Q9jwl8knqOFhrBpAf3WOIhcOGQT5MgcmWC
 MXJkXvWihvsFoupoB8AGwTkZa/Xkp2Y6Mgkx1KQ6L2iwmHpp4WogY063hem2Z+C+3CdDMtt0/s7
 fCeTE2ubjdpdJQ73LmBUWHFk=
X-Envelope-To: linux-rtc@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 134b9c3664a29d20;
	Wed, 02 Sep 2026 11:05:54 +0000
X-Mizu-Trace-ID: 134b9c3664a29d20
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 14:05:50 +0300
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
Subject: [PATCH v3 08/10] clk: bd718x7: Support ROHM BD73800
Message-ID: <2a74fea679420d147ab1029943ff071628dc8c5a.1788346553.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tyc7TRMBnVUQim7w"
Content-Disposition: inline
In-Reply-To: <cover.1788346553.git.mazziesaccount@gmail.com>

--tyc7TRMBnVUQim7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD73800 PMIC has a 32.768 kHz clock gate. Add support for
controlling this clock.

NOTE: The CLKOUT pin can be muxed by an OTP option. On some OTP
configurations the CLKOUT is not outputting the clk signal.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
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


--tyc7TRMBnVUQim7w
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqYAw4ACgkQeFA3/03a
ocUozAgAnGdSvHA3m4YOD+AOHJ2dXLLvGZlVIhTKUMWvU5uyyhVo/6Mr06cykIc5
5vh3FCHibs28v2vlmymfhGooJ6DLohqmhgz+hB3kEtXXoabgA95qYhl2ZMEoJFNr
Gsb6yzWqKVF5nyh5eD/xDIhiuLdwJqMqr+wBv/szYeAh0tkEjZ25FuPOq6RV8CXX
Kldq9Y8lBVKIVODVLDEs9ty9/S4p4+4trFPhylaCvxNoU22GTwLhFmeLeTI/KxLQ
lsMsOi218Vj1XcagBJHaXQf1XTaKMbbgnezmH0hU2B9yKGHOWd1V8UnSZY+Wreet
AVO0QUzI1w6kabi1F+SC8AkBAXlWAg==
=DvFa
-----END PGP SIGNATURE-----

--tyc7TRMBnVUQim7w--
