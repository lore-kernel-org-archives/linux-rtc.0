Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795652336;
	b=Y35VRNcqN7AJo3LQKjqEY9taJ40ErMSqg6k4bIsAM+P4o7zNE+0+hLAluDMw6/sDOg93
	 YnbzlZLW17rUt14WWZhStqgpbf0/Lu2Boj0jv5AhHAhQxdm/CVjiXw8PefwZMiwh5mh8N
	 8ihU1nZC50Zl293QEMAvLJCPC429iFOYMUgeExhrHraOHXnXkBBvDgSYAZPyJvoP1Srih
	 /N+5PYoj0LwLqqq4y/M1MmD2wa5YAYgrrWGfU0ehkGxtr0qI2RgxG68nbYTFCefrMvmwA
	 Va9mjCUYMNU53sEyAD2sYgvT3z/tfuK6KGYaH/I0FOdmvTKQuT5WnYkVLxz0LFJblMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795652336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=hs+NtO3DvgsubFp6mHbpOQTQRimp/H6VNRhIAEyqZUM=;
	b=Lt9/1NVO9pk3mj2Im3vuppmocKE9tbevD1wXDhww/017iSCI1syzIruyTzkdut7GqMrF
	 9H3MY9bt2117UbQc6S/lBZCjjjyBUgimBwGFKXKq0us6QdgclcSI8VhROY13ZKjMBp2eK
	 RG3kT9YBkSSzAAuIMzzDRWRSWb/c7hCFgO+5iKB0jb/grZxRW8+ISv4r9Ehe9bOg4SHHA
	 gL9sp3X/s+byBDgB1HIzE68sF5fggVBKVcmZa+o9DdN5MKph0NeelnJO1owH23YrofYcl
	 jUfYX8ESSkd/EuUy2MAf691CvrTfcq+HiFH05kHQx2a7nEemYJgPaqCaOoQVs1g6XcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UycSEH8Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D368606A31E
	for <linux-rtc@vger.kernel.org>; Thu, 26 Nov 2026 00:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D368606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UycSEH8Z
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3869f03af6aso5596596eec.1
        for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 16:18:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795652335; cv=none;
        d=google.com; s=arc-20260327;
        b=o3B/H+mLp6vNhQzJfvwmi93UJjEex8D//RSQNT4hhADzSu0Q6sdHI01CP/o36K+ylZ
         Uph3B20nRpDmIbV5bVJv/i9/RNz3/GmXyF8h7JkGWD4bOBxdgIDjiH5A0TYdwV4/2/eL
         CqNYDIGwcv7ngr269Lz900hbj0l0FnjzNRqm09RhZUkc/51TzyYqSy4bDti3nRhcv6s8
         Uje/5RBBVWBXE4HjozysfOOAR0bqFeXUV6Kz1RlmN7EZ6LqcrCT/M0RIQPCoyn2DwtF3
         2jsvn7gm5hbO+844EaFiAf8X/pdWauJ+h6iAEONVmfoCH2DbE6sOmze3o5OuNXw2jhxK
         PzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hs+NtO3DvgsubFp6mHbpOQTQRimp/H6VNRhIAEyqZUM=;
        fh=rgijsfqM2nisG36YgcKMsG2XGuo7gSVhwljqBxltR64=;
        b=jmMSN8vW9hP0zc2FVdp+rJ5Lodr3p+FY0bq09FszSOFVBlmg6gnIGtGGLvMDezwdWf
         GuOlbDoTBs0u2qcvRj3CA7e6Br8HkECCMCcCbkOHXB38qd3/2WKfJKL1B03z0LNYzbC8
         /N1XP4xYAZrPgAcEALWGLTnH6wAdw2Yr/rbFn0PpdPXAA97SypJms7vHqcNrpxQpM/zL
         qyvT42vUnw79vkCv9qIlx4xnScWSRGtLupfiqonu+Ema4CfJ/ZBljecXEMezbSG06I8p
         ZxXz1rmRL81ipfRfNp7R3pnw/lx6yLI93kwvIlAVnb3WrKZXLoNDkYnIPUxUTbjXSLTf
         sbuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795652335; x=1796257135; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hs+NtO3DvgsubFp6mHbpOQTQRimp/H6VNRhIAEyqZUM=;
        b=UycSEH8ZwEGmtjAiiKZzzKPXsvhkj19uhXggKtWFXyWu2vMQo/JLUIKlQXD5cthNlO
         yEXLjbJv6yoeAFGBm9yrdDkeTw80TluMS8qeQq/+4Y/doq1Zhy3mLG+G/7vKG/i1QMxm
         a60S+vfnU9kGJgD6aGyUWUIkDYgtH1FdaBtK26wX9GPDx2TyU6LnDiMqXFngG6YHIfnf
         aEM0+bzuM4kym/1WgUUX+UGk8aot6GJXfeG6H1oxiKeeKUQ7WS6seKR4HU0DJbV5OyG1
         6fcMNAmWFPOPbFYJNshMHcz8S6u2AtwGpOOh8eoj6drSkdutfnIOOOZBGwJMfG0+KR7G
         7E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795652335; x=1796257135;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hs+NtO3DvgsubFp6mHbpOQTQRimp/H6VNRhIAEyqZUM=;
        b=fnnMCi1pgh7NFCyOjiOgUzlD3CoUco7txmUdJm/vaIqel2Ja63LMrk5RBrON42QWsw
         ytNGiKd9bemcOFiqxn4JydnrE5h8NlLjhEn/icAQX/bEaliyQNgAFv0a5Dgr967Z07dF
         1eQduzd50S4buVCEYVOeXMUjzy+vSc9KlpG3ze5tLU7H5ojO87K4ybbpn7RVKe5DZWwB
         j28i7PU+IdlDqE4r99UugnNPaqoJzAOScn+qtMfd2xc7uFtK/HzJUNj6c7jg+gIKg4pV
         5T6fLPFkjN5IR5pIO5UIThSi1keWEg5Fm5rniyhnF8/tOdDpxP5PpEOiBpuTQhZyHf4g
         oKhQ==
X-Forwarded-Encrypted: i=1; AL+hErHJlxYoe1YuVNK5vyNlmtppu15Y2z7z6+a7Is7zwbuKWr8FbxNLhm6r7gj5qlXCO8SwJ64cpXfNB9U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8j6SDPTMMNZcjKhQA6ciMTPEPIadPlLGeDFMbO+EEKP0OoReU5
	RD0D0K89cDAm0/yzcdlcDec8hEVkxwQcdyn7mnYAxcLX3AfXxKFGIiZrPqLmcp2hUhRQsQUGdyO
	MgmiX6TQ4DyVR64uPTTURaPGbhmAapcA=
X-Gm-Gg: AZFdTZdG+OHGesoOrLIp7kR63bETmimC0VqQQNS4iXpVP82JEBJEgE0b97ck1RYq0Zd
	woU3w4TwQHZzuwBZzLeoZtLihVAsMQUiSua6sQoK9fYYkO8mYbGhfqu64izWNyG0Ocs4x/nAHL3
	UbY+pR5KmKYcahkF1Ek10NAxfe5+Z+Eg0aJlgle8oMmQUFE95oPWoaHLnLGIAUQ8l7ftT6/rzmx
	PZhzmq7BQfVNPUXLz3owWT5HtGgtNVjre9vUocG2Py0suQ+0qHtivORdDi4HparPqswk3BoOSu3
	oMl0WFvf0l86t5GWhho6TxfoDrBEMrRL5Z+Wdow4brn8quDJv1MxLOJ78uJcys0pxCl4JeXpIZQ
	P+MeOLV6V9O6hxP5kooIQKwREnI6ZyKC1repM4Bk=
X-Received: by 2002:a05:7301:4283:b0:386:96fb:28c with SMTP id
 5a478bee46e88-38696fb2022mr18962402eec.18.1795652335244; Wed, 25 Nov 2026
 16:18:55 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125072026.2997493-1-prasanth.r@lineo.co.jp>
 <20261125072026.2997493-9-prasanth.r@lineo.co.jp> <84e1cc8b3977f011950e68ca69c46dff1a395175.camel@crapouillou.net>
In-Reply-To: <84e1cc8b3977f011950e68ca69c46dff1a395175.camel@crapouillou.net>
From: Prasanth Ramesh <ragaprasanth@gmail.com>
Date: Thu, 26 Nov 2026 09:18:19 +0900
X-Gm-Features: Aa3M54qYngOgeBcgTcKEBPIYWY5OQaxOihLdYD94YpYTWZ1b5b1X3H2CZvSNV8c
Message-ID: <CAG7eodE36AzthJZmMhTTPn5BHjD_PFAabBn=yiyVU++gAbDEXg@mail.gmail.com>
Subject: Re: [PATCH 08/12] rtc: jz4740: clear the wake IRQ on unbind
To: Paul Cercueil <paul@crapouillou.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Support Opensource <support.opensource@diasemi.com>, CL Wang <cl634@andestech.com>, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Prasanth R <prasanth.r@lineo.co.jp>
Content-Type: text/plain; charset="UTF-8"

> Should probably Cc: stable@vger.kernel.org then.

Will add it in v2.

> (Your family name is R?)

R is an initial from my father's name (Rameshbabu), "Prasanth R" is
how my name is written officially.

> I see devm_device_init_wakeup() can return an error, which should be handled.

Working in v2, it now fails the probe with dev_err_probe() suggested by Marco.

Thanks & Regards,
Prasanth
