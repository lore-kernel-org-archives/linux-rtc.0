Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769384;
	b=IfITzSH2F8H2rXt470xV3rkeUGUQkrCGrRBAHZscks7o6kjrozeyMX48o0UpBRFItYnK
	 fh+X8m9lKK2kNJ1tx2s2Id2POM2LXw6h9K29sBQKSCRkPc2RkKHmBB/qP9APar03JqwNs
	 aNTMYBCnn+6Te4yaBw1oNCMEL8Zm0ltE5bzDIUDiE/i2FkASxKS24qyxNAlBYGJvG8gO/
	 dxkG6Ms0VACXegBI3vewidznPTA+11l2kWhzAvpFE9TfJHEKmxe6DFZDxtxwI4q/jipcf
	 yvB/LW5FYm98dZzf5UWlWWmwT9uSWKrBTrMSq1xyb4sQw5v1dOyI6h1q6PKHnd4USyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=l5H/fPkMrIgjbqbAa16bsfhUN41gPrGnMmr6FVXi4LA=;
	b=pNIUny7Inh8DAQ1vqPBwlkJN9tjA+kmunj8J4aT78kzk8azWk6FbS9ndNrUSOQFuz8Qq
	 v3mMxEijlVg52afhRlvq5jntYSi3sLxejOhqY4KWJl9nPAND4XNb+u6N/MBmvyDgjYAAf
	 vbVHV6d+ZEG7/UpvkWaEnNtsjTzLzbeCWlPPceEVlXLp+gWbbkRYvSY2Sx99W9jCDATTG
	 /H70go4Luulb1uuNb3OjZuaNG42hlwytX8p4v6i0sd7vrQX7uVwJgnB+Tyiy6BhR34J3T
	 Dv85zGHZzfaZn1w/pnlADRTgLXScVUSx0N/eWkRgoWn/TffQSy+rU44EiKnnsq5hA/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lMtduL23;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079E606A692
	for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 08:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8079E606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lMtduL23
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so82974415e9.0
        for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 00:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795769383; x=1796374183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l5H/fPkMrIgjbqbAa16bsfhUN41gPrGnMmr6FVXi4LA=;
        b=lMtduL23oty35ecI++RAvCDDqiwnc4Ak+6dpQwXYAlrNx/WsKXzEzr5BaFbdfWGv0o
         MIdxQNlD99ZB3a8pdZlPzsq/4KUpCXSeNscu1C8qklmN3X0MyZyu4smG76KD/bG+zgKN
         a5t5Os6EnPqekAKT3BU784FH51GJONaBlPWvdb5hG5vVq62a5HRLgpmnLGMi6YcnoS7y
         qvGHwnA/+1VBekixkj+vGN89hIxMcptLrPhwi9kCSzPZ5+eJkd3ljI+vBaZ2ii5tpxFc
         LEwVTIzesRkK1aagdCm3Sz9dhOlgaNyOYbdqFMjJ/Rv5/L3luL0uNMhbxT/KTNBR5HLm
         K2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769383; x=1796374183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5H/fPkMrIgjbqbAa16bsfhUN41gPrGnMmr6FVXi4LA=;
        b=CjwzlLCyTd/y6FsUT7uXFwriWl5PwlgFTYP5ckot0ngylZBG06BSlKqxLsjQ3dOV4a
         BwXEVcvyiriQH035fkFq/pCd62s87x2HojAC8siyDzmk8J7ALl/n0Fjq8vhDSkdSMIXy
         YisPey5V8K1ShJBpAJCngsf0YK7cHd5kXdZI0JUOb6EYDyHrXU2MXBj1tFw+RQSoHkZA
         3lFBNassoz5TQhzlHPDpAwOXqP5sU3gqsPY9c8+TdKHIPOv5fsROwskxEyWeHqGscrHt
         pkAxEyzNdu10fhJ0unSYekNRsBayB4oL1ckk1FPnBfxbcIyCECaDB0zr1KCPDsy4rx2z
         tVQw==
X-Forwarded-Encrypted: i=1; AL+hErHwWRS/92edqEj41RI74Z/so9G9GUoLBnxqOT2xTmTmmk3airW6sIS02qiRiBTt8iLJ9bxi/lE4FD8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tpNaVFfuuMVTug09JjCX+CCKJ+ZTxrW9eRoesHzZQTpc0O8gs
	QY0j0+JEfceGWZAoIWOryOUaBqUYPSxgvCRBPrJ++uqF3YbVU5LpgU+bOcHBjzSg404=
X-Gm-Gg: AZFdTZeWqkZJJkMLc6XJFAzbhCG1kJevZ/FzS2jWzJJ/n0mbdiBHHHVmNo/EXlt6zkK
	ZkL0QZqU3WcWtNBcriAs697ZoCG5dtbPlXKl0J33pSSQ2xt4M7jJn5nHhQbwzGThTyf7fSluT/V
	LGSTE0Fp3fhWVYtzsossvQHlChWgMKRP8VK66OhDMN2FsIc1bPuH+iAbz8DF1SINIgPdYX+vn1t
	3pfK1dQfBs9SB7D7ZqJrysIpEmjXPT+uWmU95lr2MADpZqPIS6hZStVBLeidW2vd2wMSknzC+jv
	BIlYtg83ddfLXgHDJYZ+hY7PI/70sShmhe5mpaHGxUhtSQrPkREWdy0QrRaFoLG9q/vNQbTQwVY
	kA1Nxzv4d5ysP9RVE8qYLnSi6r/GWF4kA38r4Mip/TA0Ipn+mQO2iMs+OVVg9uBCjPfNArBctvp
	MJPFpjxBvULEaKlnetB0SEmVGAZnANNnH4E7SiDXJQw0wY3pIxx9M+ceEBzshpYl9xkDRGi13eM
	UvzpTV4l1q6+g68R7Z8ACoJFkyj9LUvv/xrZSWrtrxqVnkffk7k/+w6XiUjeDtYF7yoId2CGNVd
	4DjvUm8XXIA5r1zHfEuTGcEdyrqyzD1gp/puJcHJKsTTZHBWC0Lh7D7Ln76e4FMP+8PJadwGPP8
	Uk1aso29RCcH6RHCB
X-Received: by 2002:a05:600d:18:b0:4bb:abe2:bbce with SMTP id 5b1f17b1804b1-4bbabe2bcc5mr70018825e9.29.1795769382993;
        Fri, 27 Nov 2026 00:49:42 -0800 (PST)
Received: from localhost (p200300f65f19a90496f529fbcf0b312d.dip0.t-ipconnect.de. [2003:f6:5f19:a904:96f5:29fb:cf0b:312d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb884b7515sm923694825e9.13.2026.11.27.00.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:49:42 -0800 (PST)
Date: Fri, 27 Nov 2026 09:49:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux@roeck-us.net, wim@linux-watchdog.org, vikash.bansal@nxp.com, 
	priyanka.jain@nxp.com, lakshay.piplani@nxp.com
Subject: Re: [PATCH v5 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Message-ID: <awlDvq6KT4HxGNDA@monoceros>
References: <20261126071124.2383368-1-shivprakash.gupta@nxp.com>
 <20261126071124.2383368-3-shivprakash.gupta@nxp.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gv5nh37x244s5vos"
Content-Disposition: inline
In-Reply-To: <20261126071124.2383368-3-shivprakash.gupta@nxp.com>


--gv5nh37x244s5vos
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
MIME-Version: 1.0

Hello,

On Thu, Nov 26, 2026 at 12:41:22PM +0530, Shiv Prakash Gupta wrote:
> +#include <linux/i2c.h>
> [...]
> +#include <linux/mod_devicetable.h>

Please rely on <linux/i2c.h> to provide i2c_device_id and of_device_id
and drop the include for <linux/mod_devicetable.h>. The latter pulls in
several headers transitively that are not needed and that thus create
unneeded build dependencies for your driver.

Best regards
Uwe

--gv5nh37x244s5vos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsJRCEACgkQj4D7WH0S
/k4y8Af/YPMv6+VfabvAg6sjAP1iYCrA9X9sWU9HEzF33ikGj2zaSOQAbmelYcKU
MkYOqadm4ftAn3wh1m+RGl1mnfy1GNluJIXTI9zNZYGx1pj3U8dJqh1/XL74jj8A
xgaOrHFNOPOBUNkjSWBYaj0jo6IcppLUcPbLI6QT0lkZsww+UNLIAAdTGy3bKvJQ
zQELEUsrss+cgFYfjeZ40PKOh/wFEqPemnatDmeoUoMCItb7iPp3LZX0szasTHR0
Y0MOy7nJemFgnBUeFliuIZMWsjW0gTCXFOfwAA/AU9iZ6LoYjQ13w1baDZLxOSsA
hwUFXsoIF6f/koYvawaOx3iNSkWDag==
=uvjs
-----END PGP SIGNATURE-----

--gv5nh37x244s5vos--
