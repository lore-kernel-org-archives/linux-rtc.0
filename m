Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792471299;
	b=ISoQn4I2fDVguUnjc7U0yYWRp5fJXXBJHVq9x2w77mSnMa6tls/B2yTtpTcSvREpUEKk
	 YXiDPeXSOAMx/6CnLPkKcQmPyN6aIfNhD4n1qGtVJLuWo/fPLSKMqnYfIbn69eY1/P1sh
	 mJRR7vY/OA0FDFHLkw0zYDkHWDLg3SEQjCpUpk6nWSy+F1yA/HTpNxhYJMUWbmmJ+poAR
	 RsCHQ0uy45FDhdOazDsS0ky3q4UNzhPdks4Iy65WnyfZnnCIEBeNGI2m1b4+X04nWUaLm
	 HD8748QTYljHjsUJLdZQDLsP6KPs5BvIqNfWQ+U8vMQGV4RzuEnvDosuLoSSiKW7Frg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792471299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=4K10gDOkZE3PD160wnpT0ljtcztdT1+fKIxqNnjTmeM=;
	b=G+doQSwfDokgvmBIgp8xVE7fUzvLOVWfESc4ZB3RrT1W/0OQCP3ETWUhk1S4mvSxihdP
	 7vZYTGi/HheB930FQgF4v40RiMV9d25uSSm+/E7//g+CFkxJi43sjV/+9smYE4q+ulsa6
	 Q/5hUG62wyRVadTyfHh0HIK28xnnRJUqvThwFziwpeHYUbvg9WwUEp9ASZLM93iXL2zIu
	 xQU0u6mfPq+PRukzPg0IWKDAoG6n+Q7kkz4WZ1jUclMnLewHdWcZWjSNaTRIhIxZ8PKtD
	 bMMcHZxZmuXpWZxM9FZummlGhyCB6ae81qgHUJEOTC3Pj6vdW9FcKx+UUzEwytBgqOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rCj6oB0T;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55A606A31B
	for <linux-rtc@vger.kernel.org>; Tue, 20 Oct 2026 04:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE55A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rCj6oB0T
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso1837230a91.0
        for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792471298; x=1793076098; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4K10gDOkZE3PD160wnpT0ljtcztdT1+fKIxqNnjTmeM=;
        b=rCj6oB0Tts/buXDRhQwBOZ/wE3fvSFwMm4Romi3Kym5+buRZo/KSyoHyNk9oVOhnrY
         LDqCvzoeLh6Ys4OJTn0CTU7ocVB+dvFL2wRQENTILVBo7ykIj5wxvrLwTFkm2cOglvqD
         a278cqvnIkQkH/yGwDQVRo+tw9il34Xs4c4r1QGkdaeW6dnN9x6dzKD09CD31+um6e8+
         Vp0bKxVrCJZ7g03nQ+C7zxsSwoUfomx4ayuQUMGFHjEhY+r2YaytKqDMMqeAAtx4Kvus
         6nd0UYEp4N//9EA9GBkMFavNmGHzLKf7JMcE8AJp25l9rHhmfn6LQUu7cG24Ss9v7ZEv
         WKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792471298; x=1793076098;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4K10gDOkZE3PD160wnpT0ljtcztdT1+fKIxqNnjTmeM=;
        b=LP+CyczqvCE/ho/UVtC28U1Q8LrhQc9IGoGBTL7GAJBRpLnlsKrdVFfg48SpdO/Od4
         FYr6pkXGB4e/YvbStBT/p7TDxJWxVhGofv2mSNeD0VNQGkptx6GYeeTqGvn3a5QITTGB
         /By8/NoxMW9LW29tk+w7eQRBBjIoo2GwuPgBoVYkowYubI0xRyETMYHc2ggvdHWi97Xy
         jFJVEObxKxfYUYHrJp+KGuwStRfnLEW3TtHeibsYF/np2V9WOG+UP3GilOabaKuxwA9q
         D4rtC4SU8b7l3Hg5kVNdVsO6AfEApfZQyDuh9hiSZZxpkOkEPBSSq9B7tCd+eqMrWajz
         0c9Q==
X-Forwarded-Encrypted: i=1; AKwUvBy/IWFZBtfUrozsNO6XhUDkTEEoKHOCFL0jW4GScoHYzlbPC8/wdb/flnB2obTHJcKEO3K3qdUbpUg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDS9MrkZzupXMeyrg996jsaMOw7OJAScbwlp5q43mcccPimfUh
	QBb+L/r4PvoKJAVWQhCUQf5x+cgXohAyLxQ2+rj5e+K5XN4de1qjuIOq
X-Gm-Gg: AYBFou2Y9rscUaJL8p6X+yyZyQ6NO58LnTWkxwHw5gjoUo/gTJPTSkPJJAF4sF4BirF
	g7a0OsKt11xO0FQwoOvpHzsAy7m9EkZ8Y6c2pPJRP02FxXq2GCvUyFfAZcGY+q45DBI4+951RzM
	GuwXsxnF7+2KNx3cgBvjuh/y95VryAXTflMQg4o7a2yciHAzyLWNkN9CLmgfusVjrKVlg73EVvr
	pzRB3PvFBdjgBDXfRaDGKHEy2v3sU6d0x0r8V/uIiKs7IHAvM64Cv2qobv/A8R30IIMItHL40hY
	tfGOq+TY26zkGeZ1QQVLHv+bxHnJdrz2cgiSqE5MEEd8nVRbzGtaCv0YUBtfQCPt2zH48B/r0Dn
	7lYXRb7g4ywvAZEq1s4tJqs5D8br5SYjLm7DxGFHzX+g38t+XsnmljAFKNyJrXPiqPPs+kt8ZNM
	LvXrpLc3JTmvZrYq+5bYcfzSkHyQNgHUDLB+ofjEUgOPwcoTglUzXgydifY276xX6sIGD7O99oo
	bJZidPUIpmK70sGah1MppMyfCYPj8sdPCnwPH8l
X-Received: by 2002:a17:90b:3851:b0:3ac:9e76:aa93 with SMTP id 98e67ed59e1d1-3acee2939b1mr7440626a91.7.1792471298112;
        Mon, 19 Oct 2026 21:41:38 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60274fc1sm2242645a91.0.2026.10.19.21.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 21:41:37 -0700 (PDT)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 2/2] rtc: Add NXP PCF85053 driver support
From: Potin Lai <potin.lai.pt@gmail.com>
To: alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: pankit.garg@nxp.com, vikash.bansal@nxp.com, priyanka.jain@nxp.com, 
 Lakshay Piplani <lakshay.piplani@nxp.com>, 
 Daniel Aguirre <daniel.aguirre@nxp.com>, potin.lai@quantatw.com
In-Reply-To: <20260914141537.3881890-2-lakshay.piplani@nxp.com>
References: <20260914141537.3881890-1-lakshay.piplani@nxp.com>
 <20260914141537.3881890-2-lakshay.piplani@nxp.com>
Date: Tue, 20 Oct 2026 12:39:05 +0800
Message-Id: <179247114505.1909331.8772243042180533977.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792471294; l=1059;
 i=potin.lai.pt@gmail.com; s=20260522; h=from:subject:message-id;
 bh=n5P1atnEZAPMo7JzNsBwROdmy+J5EY95ZUsmftBy8h0=;
 b=EdjxSeP0LCf0fvkfNg8X4WS1akYfDY8F5W5JzCUosWEW6Mg2pEAecfdbNqRFLjP+GLLWXEXrp
 qBasBTb3fAGBjoTyxOqGvZoH434FUHzjg32btWvTbtccwyuiA/ETbgh
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=j3/nMxzz1ZPpp1revghyZ8IqOnwi6RWfuxXN2XrNMRE=

On Mon, 14 Sep 2026 19:45:37 +0530, Lakshay Piplani <lakshay.piplani@nxp.com> wrote:
> diff --git a/drivers/rtc/rtc-pcf85053.c b/drivers/rtc/rtc-pcf85053.c
> new file mode 100644
> index 000000000000..2eb94b1da3ed
> --- /dev/null
> +++ b/drivers/rtc/rtc-pcf85053.c
> @@ -0,0 +1,900 @@
> [ ... skip 770 lines ... ]
> +
> +	dev_set_drvdata(dev, pcf85053);
> +
> +	if (of_property_read_string(dev->of_node, "nxp,interface", &iface))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Missing mandatory property: nxp,interface\n");

Hi Lakshay,

Would it be possible to provide a fallback default true for
`pcf85053->is_primary` if the property is omitted?

In the current implementation, nxp,interface is strictly mandatory.
However, when users instantiate the device via the sysfs new_device
interface (e.g., echo pcf85053a 0x6f > /sys/bus/i2c/devices/i2c-X/new_device),
there is no way to pass Device Tree properties. Because of this, probe
will always fail with -EINVAL.

Thanks,
Potin

-- 
Potin Lai <potin.lai.pt@gmail.com>
