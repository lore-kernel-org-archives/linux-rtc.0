Received: from vinatta.cz (vinatta.cz [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08ED30C34A;
	Thu, 28 May 2026 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957640; cv=none; b=jXCDDfZkoNAQHtEhrNajlzlN1dy7di35EwuWgMtM0/7/Tr866g7mwxUbAn2P2uuotO04ryvbmytuFF5tcdXT/w9YNKpPNAjiXssdDC5PgL1MQ7gxIPt1ndECjaglIFkxYXaWk3PdRWmnSIeE1r1QvB9kSo1EtDfl0LkL52/kXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957640; c=relaxed/simple;
	bh=hbTxqBhmRzh5qEhtmmqSxMZrR1fcZVJBDnekfUYevmQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Cc:Subject:
	 References:In-Reply-To; b=LzmUopuv/GhWgvaWPWqcG+F4rvX9SKWuAqYQqLOfIp5rJeiFwJNSdnM1ImS8Dvsdw3DFDg0kUagY4gDCI2IYJSnIjWXUtUADr+yecQ+eoWIN7jW/us44KL3c3x5aoMVH7zfuC8K1mE4Rj7ccdSAk9AgnJZs8N6G2WuTL0lkraY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=vinatta.cz; dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b=Mk0NQ0aK; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinatta.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vinatta.cz header.i=@vinatta.cz header.b="Mk0NQ0aK"
DKIM-Signature: a=rsa-sha256; bh=qgwa+0R+XFn6p6bqyj4g6FOJ3XZRc6X9G5oNCLDxasY=;
 c=relaxed/relaxed; d=vinatta.cz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@vinatta.cz; s=default; t=1779957617; v=1; x=1780389617;
 b=Mk0NQ0aKSh7SbxTr8wKXtLX+td5K82EuzmGtzBO3w384Xyt7Ds+1n6tk3ZwCMUbcOrSJuw8m
 +DloLdPVC3Hu2d6ht/pPovN/zBJqnfelbXx5SEecyeGUcLf5+n7AoDFuiLe2lKga7t02B1ac+yL
 9am6IjgF1zUcWOS4h91PwB1wnEB0y0A88AwAaO44UcGhKJbW4DmNUBgFSxk8YKtzwPaJCaxLRug
 moYFHrOZsE0+556cQh6GmrfR9eNZoXS47I1kfyk5alwQFgutqaTWY4oNKofFD++Seot+/a5oWxE
 i+p58yLzS8lHT1gZfjLe3WcMcVeXaS8rRkpFYa00rkHEg==
Received: by vinatta.cz (envelope-sender <karel@vinatta.cz>) with ESMTPS id
 dab5865d; Thu, 28 May 2026 10:40:17 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 10:40:17 +0200
Message-Id: <DIU6BCZABXFD.1TVSGC0VM835C@matfyz.cz>
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>
From: "Karel Balej" <balejk@matfyz.cz>
Cc: "Matti Vaittinen" <mazziesaccount@gmail.com>, "Chanwoo Choi"
 <cw00.choi@samsung.com>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] rtc: Use named initializers for
 platform_device_id arrays
References: <cover.1779950275.git.u.kleine-koenig@baylibre.com>
 <d14b9076b2c7703708bcc5cc35f339cd97fc10cd.1779950275.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <d14b9076b2c7703708bcc5cc35f339cd97fc10cd.1779950275.git.u.kleine-koenig@baylibre.com>

Uwe Kleine-K=C3=B6nig (The Capable Hub), 2026-05-28T08:48:12+02:00:
> diff --git a/drivers/rtc/rtc-88pm886.c b/drivers/rtc/rtc-88pm886.c
> index 57e9b0a66eed..13aa3ae82239 100644
> --- a/drivers/rtc/rtc-88pm886.c
> +++ b/drivers/rtc/rtc-88pm886.c
> @@ -78,7 +78,7 @@ static int pm886_rtc_probe(struct platform_device *pdev=
)
>  }
> =20
>  static const struct platform_device_id pm886_rtc_id_table[] =3D {
> -	{ "88pm886-rtc", },
> +	{ .name =3D "88pm886-rtc" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, pm886_rtc_id_table);

Acked-by: Karel Balej <balejk@matfyz.cz> # for Marvell 88PM886
