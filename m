Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795852799;
	b=KS4cR7plH1buacz0RnqfyJcCjXgILZFzPD8kiGv9V2ODBbxeQz7OCjEujrnIGf6iVL+l
	 SCPB9FndzdSq+f5dCFyMw+jAzFKQobcYbpIE2X4i0YILhSyzNcHFW08FrPUMMBci7NqIm
	 2irOdR9dFF46pCV5K9QndraYXT44ccFVF2FhHEvRtStD1DOD71RkoWhZjWXkBUPRYb35b
	 NGhi4NOScGEtSBLfCGxOajJSLIIQFpi02UrQjCXPZzSrxha1V43L21F+giLhVjQfW5aQe
	 CVXyamvIDsRNPywUOuw5/i202kC7qZO/qG1U1CY5M1RMkSb7tBjUQn24aNjyQ36PmWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795852799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rECzFDCKo4XXlZnw/34prSvNBZQ0YYwmq2ei4FG0uow=;
	b=S3+uciOSLck8hEztHysUa51zqCvrlweDNLta7eRypnL0V8J+0qoepKqPpyBfK6GjYgke
	 x/gMHQhiobypt3KaLMY15WRPRDvUQm639/QXt6o6XNv2ET7XNwMEt/TsrRptGGyVzhQdi
	 Rk/KMRga5Jo+e9qUzB5oKL676xZUZQPhq8hQjcpKvay3AmLJQM7+O4pFw/Apkcz2PaXPT
	 lrmFOxZMCJfWsMo4e4g7FGh8ferct5rKC7UsZPrSeH0OoQwXosI5BFOmNESYx9llO4NF1
	 LnB3rAmECfNJDFXYOAbNrxgRcbcGuyIAXNxNJi4DHNS9o9xWh+gH3qcI1D+R4W3DUjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="i/U/to+v";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CF606A324
	for <linux-rtc@vger.kernel.org>; Sat, 28 Nov 2026 07:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE3CF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=i/U/to+v
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a42b34e930so7725044f8f.2
        for <linux-rtc@vger.kernel.org>; Fri, 27 Nov 2026 23:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795852797; x=1796457597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rECzFDCKo4XXlZnw/34prSvNBZQ0YYwmq2ei4FG0uow=;
        b=i/U/to+vCmL1lcMOCEc3owu39hWkCjDpqJ213buTkVu7MoriXmrx+7OGqlR5mKjN0K
         HJznAwo3QdHX+mccxMSx8rXVqDLQlnkM3P4KKsZD+//BlVONCBDPn8pZ4yevOzRiXp/I
         gJxK0s6juwE0bQ5bE/7yzG82cu1twxYL71VfcfhRCV7DMYxDCXh5JSCk5HmLwiBDbGcK
         /3LWwAPMgikzdeET6ZLrmfguyXOEAu3q8eXawDWa1Mz3qgEI2CVV/tpVSCKAYuyGlmKD
         c7Nrf1KPWTMmTIelV6zqs20Kg89Kf0hmSLldDN2UR8QXyMgoiMgC0Yrgxd++VBF30AKW
         lUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795852797; x=1796457597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rECzFDCKo4XXlZnw/34prSvNBZQ0YYwmq2ei4FG0uow=;
        b=H/3yNuhTZ96WKnR5xCct7PXFfcrIBC/LM1Fpi2CzxebQNnyGDcghYbuzZFWcZSDiVa
         kAnqswhRJjrq/uGfmQRi7C2uyc61EndiIny9boIi3gpGKUy9DfECWg9vj1onVVRipSgM
         CJ/Vbq5s/091h+bALNSGof7V5ENohlb4WYEYePkoRIsIP11OtFexlPYNIU79/6BYsp03
         8YSdCdZqF+j7kuFt/CNbeR61St0DSrjX3dSsk6mvI7yNhSsdTzsDnUltcO5Xc5do4CH8
         BHhPzl5BhTT3mNkIGELi1OtyWRNiTsJMW22Y1nSFi9Z80TQFhEVaN5b3EKcRlRU+tKwp
         zUVg==
X-Forwarded-Encrypted: i=1; AL+hErFpsUhfGgUtsvxo8hDY3fYv3hj7kqlOMJwOZgfuwtNsY3vp77OHcU2wIcUaDUBiWhAJ4bmvfoX4CA0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9QkKsRtNojbtr71Hm/whKuJ9riOR+x86S9UpKEsUQSRIfC5dX
	jiTPMyCjGqhMgNubzBvVJq0VJP4Pra8x0CiWeEH7pTR/AVMTohoPFzWflO8v7enW6iw=
X-Gm-Gg: AZFdTZed5sn+hsVwf5t6QvPVcCjeG35m4vO+e8Zv6RYc/qTe1ldGZ41n/W6djo2BJF0
	C6DE6ZL6mW2f8FwS5tW9j0cOi7psk8qvucPtGFj0Vu8QZczoJkOlzajgOZktkxwjaaIoFyv8STA
	D1YXt+6wEnXIB9uOoeTeb8/ysl0y/vbykt8asMDgZR8OeHpE5TIRbUlthJ+W61uPQa+6jiBO2sy
	35CPxla2Lfrfl4XAm2hcKIWxClNF+7anqRnOrMU4A1An/hD1A4cPFsCYSbHCKABpqrEWVEzcE+I
	Xr6fVmlYThOXJoZNC5+gXWFa9+s77AiOYMTGLEkF3dLaUgBXR3fvpPb8cCHGau9TZ3rNrN/EQHo
	uFGBfocJMglYqMetaUiOZC6nRE+lzCB9JBNx+R5mAb3gB75ewcFg4gd93M936d0g1zwmykSojbI
	RGb7qlBEz+Hr6LHLaU6G4iA8GOMFjP4fNgUIEEKV6psE0I/Cc0odafD8VFZR4w5H11IbJTqbwue
	So0FUD5kZH1hApF5KGQHkkOoihcXPKfIO6eZGJQUJtVX3c8+ueySoMml/Ts2vCJ8bccu20uOwmd
	ivlkPgGoV/7h8Vukow/bee9lsl66xgQ/FYbUUFM60l1t8dYQwGGgZSMB7bV8Rsf7nzl8sSDz2XX
	m
X-Received: by 2002:a05:6000:2893:b0:493:f3f2:2241 with SMTP id ffacd0b85a97d-4abb272746fmr52992473f8f.23.1795852797142;
        Fri, 27 Nov 2026 23:59:57 -0800 (PST)
Received: from localhost (ip-005-146-085-079.um05.pools.vodafone-ip.de. [5.146.85.79])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab6b110ba3sm42679550f8f.35.2026.11.27.23.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 23:59:55 -0800 (PST)
Date: Sat, 28 Nov 2026 08:59:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux@roeck-us.net, wim@linux-watchdog.org, vikash.bansal@nxp.com, 
	priyanka.jain@nxp.com, lakshay.piplani@nxp.com
Subject: Re: [PATCH v6 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
Message-ID: <awqJkqQ_8tXGIqo9@monoceros>
References: <20261127083807.2844507-1-shivprakash.gupta@nxp.com>
 <20261127083807.2844507-3-shivprakash.gupta@nxp.com>
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
	protocol="application/pgp-signature"; boundary="5kez4omv4kntvob6"
Content-Disposition: inline
In-Reply-To: <20261127083807.2844507-3-shivprakash.gupta@nxp.com>


--5kez4omv4kntvob6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 2/4] rtc: pcf8525: Add NXP PCF8525 RTC driver
MIME-Version: 1.0

Hello,

On Fri, Nov 27, 2026 at 02:08:05PM +0530, Shiv Prakash Gupta wrote:
> +#include <linux/i2c.h>
> [...]
> +#include <linux/mod_devicetable.h>

Both of_device_id and i2c_device_id are provided by <linux/i2c.h>
without additional build dependencies as are introduced by
<linux/mod_devicetable.h>. So please drop the latter.

Best regards
Uwe

--5kez4omv4kntvob6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsKifYACgkQj4D7WH0S
/k7agQf/dUy7wCorcL/I4owilXhYjnsXPrSYVFuZTI3zBHYDbdxpHZa80WwZlBG7
E4SFU0OwJbEJe6jfB4zfEAJno76UQtmfOsPNrRBjhVwTHfHa+eurWy0zb9D/2CE3
T9IHil5xV6MLLjEsteKu/ubZ5uOQpl/GemFXCbkkgQnOoNk3fu9vTRW3m81xJ9bm
uNWYCMXorvZ4Wx7PB2OLQd5RwRNUormhf1E7zoUUE4ilF3XfUbBOvueHDCr0dCy2
b/wJgjIiQzRLVsEcMQ1QhPUbCxlrMuzkchAgFdHqygmuxVmNh8Sz3yBHvjK4aG4Y
MLYKgxWCCTBVfnXialkv/zpFTTAkgg==
=jkpr
-----END PGP SIGNATURE-----

--5kez4omv4kntvob6--
