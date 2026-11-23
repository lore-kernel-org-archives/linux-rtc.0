Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471264;
	b=zRD5RX9oFf/rA7W6AwZffE1ssr7Os6xGRo5urXOaEpZyKr7ez+psHRNcgRNTm6Cvovq5
	 06dtSOJMfJYBYvKOXWq/1bOYr9qIcUkP2UHg71RpZQYv1KmJafWiLeTfSQR/3sUPa5XBw
	 zbxTX/rWeD84GnNzwQo0ixjVctPXW51RHU/6udGL3V0PZKm/5Boa+IHmVw9OWgigdee7e
	 2FeaV5nK8jLwoZlk+dOcSRgbePsoNLYqBXhp5Fh8bncJjunjmXwR34UiabY1xp++GDhKZ
	 cZuYEWFRPdt1wSxrktHU3aDO749ez8eHgZqmumFrbCm2C4dC17Wr3/zmvoN1c73jRwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=xhzf2GAdeOLD6c0v2imXIzwLHmXmZhjtZ0JwUowL8Qw=;
	b=c4M/9QouRdt8zOr2C0JoJt1bqRpDRtQwYijU82qlqqh2BkxPSo231MKgumSjqkjrt9HU
	 VpbEcgBKw2t6dNnWD90SH2RpvcNSOeY3srSF43w6MbR+eL3u6ClVHiSS/LkWmIUOTjP/3
	 a9CWeEDHhbHw4AjkCABQS18tCqOuhCIsN7sMIRuLHyvQIZSGcdvr5pQtITyrBR/3CDYnw
	 Q7M3GuHPMTAJfzcrYneU8WtNBtnOxpdLZAZvRrn1b+qP9OykEt43TN+JpQBALHPbRm1ov
	 PqrUPNgRXcj90B+hl/01C/GxjFTia3w+UOC+4GW0/KhphNtEA6KTwdfFqCNhOmSiG1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UIoZ4/lH";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6574C606A335
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 22:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6574C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UIoZ4/lH
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so30953275e9.1
        for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 14:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471263; x=1796076063; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xhzf2GAdeOLD6c0v2imXIzwLHmXmZhjtZ0JwUowL8Qw=;
        b=UIoZ4/lHvTVxtimwt0Xz7waHMYTyE06yZOAZu9jyPKlAbl9WKxPJy9S5PhRsFU/bgY
         HUUzexKAtSFnEBTU/UIlxzb9AyZq68R7egGteyDpJthY8yLIwdKmkFzVnSdr7+dgClWc
         UloOzdtLM6pr8k/g3+AdtJt2sWi8yQ+lP69K+sgwalHUl8ZDBjNiVEOC+Te/bdMTVEpA
         hN/qONV4hJoQcDpZg+W8/PfTb8ScloP6eDIS5qwv8wW7XWygW2bvEel5XCmCtA5oCxto
         8tYWlI+6RJXAyhMUJMbBMKcC7zZ2RIsbuQu2gQJEhIyClLkvHrlep7WHWAQ2k9A3qzVI
         3q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471263; x=1796076063;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xhzf2GAdeOLD6c0v2imXIzwLHmXmZhjtZ0JwUowL8Qw=;
        b=ci5XxpxJvIHTTsgIxB9aOJX10UyLDN1lzT2k04NH7BKPSvxtIWNnY5bSeDWKk1EHT3
         N092oZ6v+7GtyrwRl960YjyqUb+H1c202LznNwrXnbLcbw4+p4o97mnpKpF9S7SSX2L+
         RzN7Mtj/+gm8GasOOMZI1ato+X5VaI7Dszen0cEzTmvl3FTXuPjpOP4rMS13JpHFFTN+
         bXv8L3ldj1fMXZItWp22WtBoVeT+iBbYU6X/TrdOVsX6GAZM1nfQr1gvSlpJmW1K1MzY
         lUss2GlEOzrM9InPtaZo/OKili58Gbkhdemzx0E/0FTG8pptvLNgF4lBz7r7//6Wr3t8
         Q51A==
X-Forwarded-Encrypted: i=1; AL+hErEPMPofzdofYgT8tm+6VY/eL1Cn5ZN6WxaxVkwlnqLFJ1RZqwVyNG8T40GhTtiX8fwch9KQmqzk7v4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XWzC4uGoi/AajCY2q5W3DpYknSfXBguCcCmZ1td6uzBcKCI87
	cnpNE/9UFb00CTG+IN8puZqr0PiiLNBvpo8cuuSoki6rJwMHcp6zvtJb
X-Gm-Gg: AZFdTZfcCHat+gnTuv200riXbRcypRJPfBM7F4RLnKGIrrVHF8IKklQrpLovatJGU/X
	pMSmhY5INbYm84yjRQMn39mwnWRF98j4O+71SBSl8hg9wDdinyjBv6oa2cDJICsqSSyhlnDwpEG
	C8urE9tT73nJonOhphSG3j92zq6WZBQOmWmtYHKc6JgjxGltwqM2L3p1ApbWPGeI85s9kuJDAlo
	oq75XReargEPIagE5PKi3LH3Q7TN6fJ57BUJ8iCsV08b0nXAq8Ly/tDcmH7gXHbevXgm75FtJTm
	RfTRs3HqLxEox6v+wu/Gbm6Ew4/frLGduywHSqDYOblBXz90/KNRU6b9MVjEKpMlchRaaEHQEg6
	LXvB0FoX5HDPZbnkC9ncY7adxk/kjxEDnoYjIoiYTu6HVzkcR5X7q5WPmSd9AxzdIxsQlf+FWaZ
	nS+IQ5SbW1+uoT63FsWD4r5SG3gQGux4Y6L+Rzt7FhyWO1pSuxohfFcx+imCw9OvgfP8Nd+jQ+0
	V1xCopbA6sUufWhbaMo1yzbVBCRCBxh0/PPS5FjkSeJ3T/XS+tWqmgXPFTvj0JkUdCI39MPEJ7G
	sATQKSOp/eNtE8cKN2WfEJT0pKshS9eL2GX1cAH0pk3LrKVUcKe3HpE=
X-Received: by 2002:a05:600c:1384:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4bb88816c44mr270320725e9.15.1795471262627;
        Mon, 23 Nov 2026 14:01:02 -0800 (PST)
Received: from [127.0.1.1] (ip-024-180.users.dtel.ru. [91.210.24.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm434896805e9.7.2026.11.23.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:01:01 -0800 (PST)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rtc: Add Cortina Systems CS7542 RTC driver
Date: Tue, 24 Nov 2026 01:00:59 +0300
Message-ID: <179547125963.75567.6386430167092445665@gmail.com>
In-Reply-To: <202611232056209fabb078@mail.local>
References: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
 <20261123-b4-cs7542-rtc-v2-2-31ab43f2cc8e@gmail.com>
 <202611232056209fabb078@mail.local>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thanks for the review. I have sent v3:

https://lore.kernel.org/all/20261124-b4-cs7542-rtc-v3-0-53902bfbe0ae@gmail.co=
m/

Probe now leaves the enable/reset state alone. read_time returns EINVAL
when RTCEN is clear or CLKRST is set, and only set_time enables the clock
and clears its reset state after programming a known time. I removed
the redundant rtc_valid_tm call, the two probe messages and the ALARM
feature clearing.

I also checked the year field and the calendar on Almond+. The vendor
register definition gives BCDYEAR bits 15:0 to year data, with bits 31:16
reserved. Using a separate RAM-only range fixture, the hardware passed
2099 to 2100, February 28 to March 1 in both 2100 and 2200, and February
28 to February 29 in 2400. Century carries into 2200 and 2400 passed too.
The 1970 and 2038 first-second/boundary checks, year 2000 leap day, and
9999-12-31 23:59:58 to 23:59:59 also passed. I therefore changed the
advertised range to 1970-9999. These are specific boundary tests, not a
hardware sweep of every year.

An exact-driver RAM run separately checked reprobe with RTCEN disabled
and CLKRST set: probe preserved control, reads returned EINVAL, and
setting current UTC enabled the RTC and resumed counting. Each run
restored current UTC before returning to installed OpenWrt, then I
verified restoration again from fresh host UTC. Firmware was not flashed.
Full independent ARM built-in/module builds and source tests passed.

Thanks,
Fil
