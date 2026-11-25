Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795593571;
	b=bJtvmKT0gdy4iKrkLGjSg3gh7vcFLJxw+QGWEMDAXP7CnypUtNGEdHsFLfBspjEdv10r
	 MkupZXKcj7WuKNI9YOKcNwRNeBpB4EWtKXQ8H4jleY0HCI4LBMSKWux3CfT1/yVAS+L/j
	 zlGcEJGsm/8Tn4AnvX31TNiUgGTObwGoLFSqD+yaZrdxA5sEDroKxxgNVoftzAdgsnORA
	 j+o9gEzs2KUtmZrv5NlSj9hQ9DyIG76bef0W4Y/g4KtSgH50vdvltIFOLh7VEsXXcXJzb
	 t4+5a0tD9Z7c/2ytby4E0d32c0OWpsoP5mPognb7UQ32XWhOuPmvdW0ns+8+rlq/1Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Dzx8SjVAV6xQtssa++DVGlU6KxNu8vkqzBWqQg9Q6ZM=;
	b=hCW11JLO3To78nCnJTrnbrWZnwaCz08/hV82YJj7buqqkW7aN0XYKfRvDBqNcJB3rjcS
	 5Q97B2rK+woTRAOHUqskPmilwqhnntzXoctDMNkJ3AjhrgHKu45CPTS/SzTxMSBBWONbg
	 8s94UAp/DfOcWdNwLLvmrr3nLx4GMEG97ASY29DS+u2mCDVgWzj3ZTCuLyO0RcUVj+DgR
	 hrxaoqtlIm6B8V8ptdh0C2pD60dEyfnqJtrraor6pOwpSuBmXLcF78q6qODdHk+do/mVk
	 vCKi0TNO2bllUZ+9SF0thl/ci5aM+7SzMX4sXHw9la2Ee4/fiPsX0A3JZje6GPWSLKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqOw5hxV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FDE606A31E
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 07:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21FDE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqOw5hxV
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-386b8f2f671so2576769eec.1
        for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 23:59:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795593570; cv=none;
        d=google.com; s=arc-20260327;
        b=WIeBnxuCRpnhzadFJnwURI9u9sJRdI/5k+gvRI3HAUITXuXgTdMSVKGYMD6y1zd8Ik
         UO8+adPTRfSbEUWOxDkRwE9g7+FXSRAZo4MJ4B9M9t8Fkhyc9qjM9tFueKqJsiPYv5Ar
         UII7axuAX5eDE5frJe0+xiJc6t27+eOBVb8MSvL6x9i8Gdm4AsrxSme9M3Z+zXP6jvCT
         sh7W+HkxHxiFyJy3hzGoqMOPYnHEaCrp/CHVvt+emyKAabWWkzX3lrWnykEF4TB7wZ5s
         P8m13wCCpJFtq0s7iyLHNdnDGlZnZ0c2dyVck/CZWRQLn5tWHaLOwt3eET1kY1lvKp0B
         meew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dzx8SjVAV6xQtssa++DVGlU6KxNu8vkqzBWqQg9Q6ZM=;
        fh=nYyuNW3kpVohc13kT0n0+GqTVBJFGb739VtfliG7Grg=;
        b=VL5v74TUttaxnXHBchmBU/ZD2g7BaUeGJB6MrxJJSe5m4xaSMdWKizE1KqNfroMZNq
         78TwVASTw9wx2ufwD++dBnPrQ9RHaCV4SofohkGiCTNEyXbMzam9hF4meHo6/xGUnrh+
         /5QfyCWzyOHJM1tPjiBMdc/SVi6Z80TKrGPah+7F4wqoOp8O8Fn+e+KKbt911a2B7g/p
         bOhP0fH7YLipVswjhu4P+sawGnk9wfNU3kzD7Hk0C9ku3cRVZyTQAI4o0fmpr1cjOmpV
         njanhlCfUpaffgck21EgSjw0jxpppteoc5xHMIrB7Y+ffoLH0GzAlZWiTnwCMLCQOmN7
         8QGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593570; x=1796198370; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dzx8SjVAV6xQtssa++DVGlU6KxNu8vkqzBWqQg9Q6ZM=;
        b=qqOw5hxVHbdW9wUIHTrZrzl8zsjoVR+ZdH+aQcGrwLf3e2q8Hb3tz/nWQ+vhjz/zuV
         S4mMF62NU7UHlyU90Txn/UpcNAgma7GvWdXgICgzeS2B2GfsjXuYw9DGRZvQo8Rre9yv
         MNUJ8mzNtI1oC2lS59TKdOL+Ja+bfwpn7uNurH2DqDE/DNL2QWNmiurdIBUg4CVEhEAD
         XCiL3VN8LTEm3kj7ewo9y9JA3W3vms+Zgf6RU76VFe52I6gH2yVNzauFz0dgZpxzwr+p
         op0mJe4H/pumM9lNykBOL4A/hVXLsNbFdjEO0hI1ECDB6mY8cYQojxA4U7oCoc8hBM+5
         bL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593570; x=1796198370;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dzx8SjVAV6xQtssa++DVGlU6KxNu8vkqzBWqQg9Q6ZM=;
        b=oWFRRuuloDVKMi33+DKx8IpfY2zbRUujuRBed2IZO2Am3XRmncJP31m4/pxX8qUZUb
         ltNQO1xJLCLWjCdl3EbPc5O46PtkZF4P2h3UDqauCUhkQ/XQtCli+dDdNKaaJwBD55ot
         3nJG/SaETLq8RFHLFUFmmybSXF16PiGC58btSCKbGh+coeQiq2g09vOT11B7ailPcxqB
         MzDMAccvkoEBCPCe4QotcqhORr5ZgjppdT3XP/kyGLxYPzgTWebbCt0ot+FkRajSV3p9
         1QMezf3w2JAYJrvMic9GVvx8oGoPW2FuGXAddX2LcwgNW7isvDZSl3K+0dE+Faf2L9X5
         NphQ==
X-Gm-Message-State: APuU4Z+O+DDHc3nn9j8fyyE3f6X3KAcn2MsUnUhd9xN/zXut6SG7kkEL
	XtqfYMQ+a5JUqjbtCsUW/fy/4bJuUYVkd6sue2AyexqJmbegk4El5YSweRzvzmxv8zLRjwQFCPI
	HXxUbKLIhsO0UuPA7ff7VlqpjIMFjfMU=
X-Gm-Gg: AZFdTZdG5X1RvqevVwfyEQ4mYHmGNHVZ5abW2tEpaOZkt0E/WMBionoG0WHmxerm6Sp
	pFFyCwdVvN1QVudAmYkQSdhDLSU+Uf0ndA9X9cy676aGpPhfKdbZJl2qx+DTIP9n/j+VxPPaOh5
	rwjCzlUFq4pRO9WNMMhg0gKiE3oUxSg3YDaCWN/M2cOv6bA+6kGzqFReP5pNRR7+4pMmh1YsiIO
	jCa1mt70M4TM6z5xzodudCS30N4mdZL2Q9uu36n14Szjejp7J3qH/k0VN2oMfm/OmZ/fjebB+yN
	E7zAgqTHClXN1NWBEaqDT0kB+IX2hxIrVMXj5TlNJwEuqGJ1JHtEX0E9GUbHqAauj2ZRpu+Ozsk
	z9ls8F1flvvtUPF7F6+k3y/brJ+pRR9VyzGgtUUk=
X-Received: by 2002:a05:7301:da86:b0:386:d481:8160 with SMTP id
 5a478bee46e88-386d48183aemr292617eec.37.1795593570201; Tue, 24 Nov 2026
 23:59:30 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp> <sashiko-outbox-232811@kernel.org>
In-Reply-To: <sashiko-outbox-232811@kernel.org>
From: Prasanth Ramesh <ragaprasanth@gmail.com>
Date: Wed, 25 Nov 2026 16:58:53 +0900
X-Gm-Features: Aa3M54qXYVyCwSQzA9Cg1aIbfxm3d6Em-tWd2Uyr-wX7BgbaSHQpmZUFH4khkzE
Message-ID: <CAG7eodFbGRuig7rq+_VforW963vkc-0JFcNdO3s6M5ZOBV+wOQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] rtc: clear the wake IRQ on unbind
To: sashiko-reviews@lists.linux.dev
Cc: linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

Sashiko is right about pcf8523 and rv8803: the I2C core already clears
the wake IRQ and the wakeup source in i2c_device_remove(), so patches
10 and 12 fix nothing. Please drop them.

For pcf85063 (11/12) only the SPI-attached RV8063 is affected, since
spi_remove() does not clear them. I'll fix the message and the Fixes
tag to a3c7f7e16ea8 ("rtc: pcf85063: add support for RV8063").

I'll send a v2 in a few days unless there are more comments.

Thanks & Regards,
Prasanth
