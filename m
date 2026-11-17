Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937586;
	b=NJRrcfx51mhR9flggcAXjO92NjslOSTGR7xdM18eAHYHotRGdM4rBV/uC3YzHTfoVfVZ
	 ST1drff3xaTjG/X3vBtCWmQHfPNje7RUrAn+N7nbvo6fuVjkF6uo2vEALnsdeImEsqfgm
	 6Nqw+gbtT2bs41oY+VRFk2JCeCY/5uHNOYFd6zCeeWxQb5TV/kd9JuaRnRAarn5I4bpol
	 wbFEk3t4s34fUH6g4bR/0GVp4rqWHfI/xIS7Ahf4jVeB6nlDyUjohUZbKczCDBDOZUjk3
	 W811MaGcaoBmAzMuIYJAjZEiWdJfn+tFlJmaZQK6okGOjWKK/jVAgs2aophyGzB8mow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4hOafILIV+CVlRkgIEaAaXXHXtmDETAgh8Q4GfXqJ4g=;
	b=BOgNQhZ2m6Q+/LaTvw5h1jqx7hFJFYDPCg38+c3sYgOgn7nY39A3E6Ky2aUlrybwECpn
	 C+iyP/v0ZH10p2T008IsunSHWf5Y6AnPtfOkqNfy9gHcoBrieWHmqsGyXe8/fjfb6whzH
	 q0BcyJQX1WqYu75iWuMjj/eS9zkRAr9piv8NR9JzyVuteHxtwMVkUqrl/M0tc7w8Nh46f
	 kw+tx8mIaTDXS9aO2aTVXJxJA564UoNFsrOCIjMm26Vs30xw25m/S5lcRfU/QdehXrYPd
	 r/RzYYR6ZAR5DoMC32UG0c2sJ7IjKKwJHw32Uwa0e6ey/OChccTRbryQ/gCNHdH1I/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S8TNrY2D;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F58606A32F
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 17:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F58606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S8TNrY2D
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91e7fc8265aso68439506d6.0
        for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 09:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937585; x=1795542385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4hOafILIV+CVlRkgIEaAaXXHXtmDETAgh8Q4GfXqJ4g=;
        b=S8TNrY2DrGLtY+a6KQj6xzqDLI6asI7+F7/RkSkT5Iilrp9f/TqEqmTcBn/jFDjwde
         1Gnm38A+VZzriOwy+TXdGnABQSQQSBgWb0wfWBVPwBqg+x3LWgN63KEhkVfi05nHVpIo
         tS3wA+XhcZ9TfYK6gdFOZHTXvHFgQtmhThzSDlVrqA1+ZkbYTFgjdI9yqUcBrdeqhcBO
         ZlELhA7E5V3qta3tokiodv/iomoHuYYLBFrG2eaYsjnAHhQf6TaHAX+imRTviaK4H+zw
         qphfKQhp6mq2LQY2nfMNbyKD5LKM96QXharF5vIYbz0G+yCTFUAYTJiIWTe8Dmms7V/S
         WBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937585; x=1795542385;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4hOafILIV+CVlRkgIEaAaXXHXtmDETAgh8Q4GfXqJ4g=;
        b=DluTH8msDnR737PjakWBAPQqCA4j9TcqH+eRYk7ftbL+TIqPE3zBYG0lLrWrb1wnyo
         yodcGARIJhH20+ECu7TmG/62SxQn//PSe4SP2MJf7Gz0CRm7ZccGXJe7e45sezDG/I6O
         V/axhf/Ou+qi4jJGXZh5GI0obKPeaowJa+gExGz26IN15mgmXfmR1m6PhBOGz+DI1LwT
         QKZZcPMmsAklCWAA/1+fiKu5l10A1CQ9sZGwrdpmmIICQ0K3mh4k1dc+3H0qurHMxf2J
         woXkvAAK/HeAreqqyy8uxfQKjJkdYl/I/DS68Pc6zKNdqxAOr7kPEMP4rT8wwsJRUtYE
         kC7A==
X-Gm-Message-State: APuU4Z/7C8USBXr0wW7y8Ibvm0Gxn9r80iuxczQis6C1euHfOIy7LYFs
	VkuGljhtFN5sBckdDvRPkEOIGfl1OAAwYIyX0YYLT4E0kRF7gE7JevfblMHqNw==
X-Gm-Gg: AZFdTZdqhQn1vTywOgbBtEbyUXWoCeneS/IweJfONO6KPMRCSwi86XpDS1nth4F0rRR
	yT3Xnnn7lo70REgbO8MOqTcRZrFR5TrrEnaZvIVnVQf5e+Eu5IO70C0kIXFNprt9c+156Tl83Cs
	qw62hFy9gOeCZuBtgY/ATvUgSk1joYjYHLddYhqGsOLOdP2bIjVCff9okX2q+Kz111hs8gKg1Qu
	uEQeXz802IsYw6fXajMOZyvzYtLBbqHYPJPRJ8orqnemnzdFwDlx7fonGdV4ikUmr/EZlHwvPll
	hPixGoevepib/RaEs0QmVAwUhHUBVx6NVD1bzEzZSwyo+wWorIWRT1P6khfOOBefKusFxpMr2dm
	UT/UxEq0/wNIuLwrIoyqsjjU5dhndMfHWpUkCwsRBXF+veJd6EXnzMS7I4UVc+LEsojzrR1ZOrL
	U5qId0u6HcS97SNpH1yUD9I/6FeA3Rk4l+xXY+PXRtsq53dRLZJApNfBa2Dp3zYUX7TTCkgKToD
	XHAJ1wo6Et41Q0Nbb0vPbBq3DgaEVHk0UqjZqoUgaPqe7lYfVhu3rnevtX/C0NXz9Te94b3EORg
	UagTlMNH/GxDORjWjxudiVPitaNBmwr5498+k7VUhDY0h/XhElO+qDGhJYvyOP37VPbMObaa3in
	KPRM=
X-Received: by 2002:a05:6214:2c05:b0:91e:dde3:f213 with SMTP id 6a1803df08f44-91f24264fcbmr201544606d6.40.1794937585252;
        Tue, 17 Nov 2026 09:46:25 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9210fc8f89bsm7629036d6.19.2026.11.17.09.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 09:46:24 -0800 (PST)
Message-ID: <ccee564e-c705-4669-aef8-e0ed284fb776@gmail.com>
Date: Tue, 17 Nov 2026 09:46:22 -0800
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] rtc: m41t80: Support SMBus adapters without I2C block
 transfers
To: linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
References: <20261103225027.1248035-1-f.fainelli@gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261103225027.1248035-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/26 14:50, Florian Fainelli wrote:
> The M41T81 on the Broadcom BCM91250E (Sentosa) is connected to the
> SiByte SMBus controller. The controller supports SMBus byte and word
> transactions, but not the I2C block transfers required by rtc-m41t80,
> so the driver refuses to probe.
> 
> Use the I2C core's block-read emulation and provide a byte-write
> fallback, retaining native block transfers when the adapter supports
> them. Propagate transfer errors and reject short reads.
> 
> Individual byte or word reads do not latch the complete clock register
> set. Recheck seconds after reading the time on adapters without block
> reads and retry up to three times if the clock rolled over. Return
> -EAGAIN if a consistent sample cannot be obtained.
> 
> Maciej W. Rozycki proposed SMBus-only support for this RTC family in
> 2008. The same SiByte limitation was discussed again in 2018, including
> register latching, seconds rechecks and a possible regmap conversion.
> This change revisits that approach using the current I2C helpers.
> 
> RTC access and date retention across a reboot were verified on a
> BCM91250E. Host tests with mocked SMBus transfers covered native and
> fallback paths, rollover retries, short reads and transfer errors.
> Alarm operation and retention after a power-cycle were not tested.
> 
> Link: https://lkml.rescloud.iu.edu/hypermail/linux/kernel/0805.1/1778.html
> Link: https://lkml.rescloud.iu.edu/1811.1/07408.html
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Maciej, Alexandre, any feedback on this approach?
-- 
Florian
