Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609327;
	b=QiBg2H1tR5LIMEUFn4iJJb4ukc8KbuaBbQSaeiL8JgcfccmvbmdNjQtm5xCfYiUwW1g9
	 lTbATzGmpIZ3rHMAzfmOduBg0UQhVhawDdjEVU+Gz2uDHBtw4p65+OMkM3X9tz/uFz5QI
	 5aRvFwJITjTMZT1g6C+lGgIeBpMkTXAzyDktu63KjgMkMpCtiOfj94BsejurGf+0xTNhW
	 4x1lbIjc5zZ7Bn5RoBFHu/+srrEGncKfPLiLrxns6poFGHU0in3YmTg2HkbiS6Oa9yVLq
	 s6sEwhahoQJE+HfTt+FCu/t/fNVEQazy76Vgv0eomBLj1FxT5jYTWMvndU73+ZzAQPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=hyOIUkBiiGC7R0HE2rH0btA9JAG/DNgt99PlnyFYoQU=;
	b=kbhS4LyqlmZL/bRdRMDx5ZPLSxhyGdZlfXr/jyq6yS3UfKdihDiGDf7M/RO1wUshFs7F
	 WwlacQ2msAzqzhEEfIl3KL5Evxc0I+NlNaQrRYUSAAU9WQWfguUJFK6e9A6xMd5zPy28O
	 IfSzGCjamDz9p8kk3jWyYnfzfbBrDc+BFbWBRevYmIMW7myItd4KAWN6tQS012kbrN1Qb
	 9izFCB4XeexznA3CfZTbtPD0Qg3U9yQmiqoqtgbJrgSd/bugP9Lu/ATW0UbklFD+t3q4+
	 1Oi/yswljJK3hD+Gkqkwz0H4fE6HjSIHalrcrpyDm0KA8E7WF+bhTTNOzy92IMaboEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h7SFGbKd;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284C606A31E
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 12:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A284C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h7SFGbKd
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb606491faso30491605e9.3
        for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 04:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795609325; x=1796214125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hyOIUkBiiGC7R0HE2rH0btA9JAG/DNgt99PlnyFYoQU=;
        b=h7SFGbKdhWpTX2pCsFEQvxmOJ5qQMcyTQKv844BIonMf9rSB0d8GYifglijORxMaP1
         OjJ+2p57Dmz6oLZwS9bAmb7SdBNYTAozVqtZAoxPjaSNHN0h4zoaNGqbaXEEub1NGcMS
         n+HU7JwlLVrxv+Fw6YNoXkIBo+Pbkb/MmUW2ZpyvNSfwdTJejgdNOx8IBBFXtvto5oHS
         qvwa2duSV9t8+qikgXx9yC/sMflZoKOHG8mYK2rZSmBqDtpbIFq2taD90NhbKfNi3KSJ
         DisWi0VAsRyLPm5nfrTnYpbtrHQHr5keFVr2P8zEfcLg+SRUxrYXTqAL+iY/b4R9KUG9
         lUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609325; x=1796214125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hyOIUkBiiGC7R0HE2rH0btA9JAG/DNgt99PlnyFYoQU=;
        b=YxGBA85XoawQHbZo7B/GeHvEsvYJ/M9M5WTl5njGUV5BpWKn84z11n0NVXnVVGSxye
         gwUa5c250rCoJbCBUiLVA7xpfhxgJ+uZxWVQkLyXgpOdovcZABm0CpOCODEvRkkK7tuc
         qaQk0GsJ1I/zh685RP9Uj/soGBNd11LhcwTpxOaEBYTkppcQUndWniRQeEihAlGETzSD
         pW2YXio1yPQMbechJbpp1NlyYsMe8wTE90TOSrzJGK6gAOpLLXbfMldBdcZpWi4IItaH
         o1SYCSs9Up1JEOkTBKhfndNxCRSxQVULHBgc5PcDCKZD+uHXN045jeI/ZTlbNVjfYhBK
         ttNQ==
X-Forwarded-Encrypted: i=1; AL+hErGYaxzkIsxKxFv2j/G9wF3+YypMWc8REiw58sDBW0dU2jsnDMnwY7UA4rbFOzutTdLrtKZrArtY0m0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sJooyQ9PWA6DMz6GevNs9ZH5F8vo9Zirhkp4dSUImb+QiwyGE
	rjSAF7mgkPyIVnYKwegOyw3ddAGPLnPrIMifH8hgU5bYDX977p/Ea65hl2S/uBZW
X-Gm-Gg: AZFdTZe95+rOQON2mvyuxe1HSzgsNkqe2Amjj8dVvKsus7KnTl3lyesrhOxzNcAmDVj
	NVc5CSBwyQFDq28SGqlGxnUHTLPSFHdAVWRQ93KS0T97BCdkTmTouGyd15oQrgCCWQLqcHHwsvC
	J9Q+wxebGNOXjNmLl7jkIbZLQ6dG9sXlUKg7Cedl2Dj8d1KntrsV9Qvuq/dKXN0C6Lt5LUV7plw
	fnm768Ww6R8wx0Z6/cImKy7j7Jxb4rVwbDFxCaj0qd9/fmVW4/wGkRQrZ7A/gaFRvCZG5M1SseE
	n2c9Dpb+XNdL8iaRgT8gYFllXM2ZCNEWUXBwJkVGAn64a0EIz/vlZQfwBeHtO0fMPLHG2k0vuRH
	Vn8j3s4teyD0nCOSWBINixxLX8Egx4cnm7AU+6gxg8OzumRV3lH17YS8XN2uNzciTZ+yQZ5Z5do
	5nRNHEM2SPKrTixcSD9+EkAwqfv3j5eV0OLfQT7halnGrno6gFVzmYPunZlhw5chMx5RQaiOOZq
	DDCUjm4gk5Tc1m10jnRLrscDytPFIXUWwa/c5dEB98+UjSr9xVB1HWgeqANW9W9QhoPW0MnAUam
	gWVxirvBg3Exq6HbUUxja80viUjQl2GEQ67rPAqdNKVNoaBOJG5ivOhYGF8T6VsEWL1iErp5ZJW
	wLYfpNcRYyBYSGeaStFXL4DcWxiVS9+Orox28AzA9mFsvr3RwqKJfEOWHw6zTHdw=
X-Received: by 2002:a05:600c:4584:b0:4a7:c366:d791 with SMTP id 5b1f17b1804b1-4bb887e266amr342488965e9.1.1795609324876;
        Wed, 25 Nov 2026 04:22:04 -0800 (PST)
Received: from DESKTOP-FC89F7R.localdomain (205-pool1.nat.godollo.uni-mate.hu. [192.188.242.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm291140835e9.1.2026.11.25.04.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:22:04 -0800 (PST)
Date: Wed, 25 Nov 2026 13:21:59 +0100
From: =?utf-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
To: Thorsten Blum <blum@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence98@sch.bme.hu>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: sd2405al: Fix BCD encoding of the month
Message-ID: <awbShJwiqqw8GtZz@DESKTOP-FC89F7R.localdomain>
References: <20261124134110.237481-2-blum@kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124134110.237481-2-blum@kernel.org>

> 
> Add 1 to tm_mon before converting it to BCD.
>

Reviewed-by: Tóth János <gomba007@gmail.com>

