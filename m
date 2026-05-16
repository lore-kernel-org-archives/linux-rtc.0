Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CE27453
	for <linux-rtc@vger.kernel.org>; Sat, 16 May 2026 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778969769; cv=none; b=pK2RQsdgyWm8t/Mj7JdmSOU3XmsMTTQJ0Br2Xjt57h/pXU9azW91V2evDNSLVcFquC28pjOWWHS9+0JeBx6BhndnBPQZXKJCVavejbPxj0+oZq/trh7qSSv9rFUAuLJ3yfbwwGHgrBNGKKcSxFJXjV3NWJIHA4WKnvbd4ata4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778969769; c=relaxed/simple;
	bh=65HFTt3mBp1NtGCq5iKKI+LYlmbhAW1WNa0HWEy5zqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owFQm7cMbTZuxU2+9L+4yzxqh5MTfE4JlGw45/EUV9TA0nVjxyiAnfaEUnLt0CPwD/dfVYWpAd82rTeUJXWr4qwrKK5iJctvkeobpKBJFL4bho189ZtLOErAEJUQ6APBCdy9/6g+2i/x8wzO7K7yPA7xG5hH1KrDeXKZJHyBDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8WtsUQQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8WtsUQQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so5214805e9.1
        for <linux-rtc@vger.kernel.org>; Sat, 16 May 2026 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778969766; x=1779574566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=65HFTt3mBp1NtGCq5iKKI+LYlmbhAW1WNa0HWEy5zqQ=;
        b=I8WtsUQQ3MidlM4hlb0jy0kBGVBbE7pVptI2E6+3H7ZqItBVSr0eMKsi5IamWLuAZd
         ZYdDgFb1H5BDc9whoWR9Xu+2y/GjorfEZjMUMNXWODA2eTiyJ0xAVgx1gNNNrLVfwwe9
         RT8irVxwGbH3+Ky8lG0bX1IWZulBGPXfYivbOVWQxgj+kWanYX/XMKuussWPiXKIRuAV
         gUHZn+LCrvO+5KUbGM4WsQ1H0XI6gvHnxhV+vr0+AgIFgfuAAJGPOKN9bPLNGc2L1A3G
         9OjjDw59/jKOuNBa12nwsrKLG+Zgvx5CZOadRnzBW/nYNdJeeXIjH7N3Pjx5/S/j8YX+
         vIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778969766; x=1779574566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65HFTt3mBp1NtGCq5iKKI+LYlmbhAW1WNa0HWEy5zqQ=;
        b=K9fzogRIG9QTQKESHKD9zY6EAPEK6Tw8Nhc6StjbX5ysFCYa8kIAJFzGFijMw3zgiw
         ZzTNcnY5wMAm4a45yoBInl6KoBw4pIVT7lherPouHQTsvP81Tyre30JgbQfg6ejGB/fs
         r6L/Bnm8YsDLXW4bAXAWLi9iWKQIcJg8OCvEbO8/rUaXQZ/4uFQZGro+5SZCLcOKg+Ms
         GsnSRE+8dw6e4zjdk/MMF3AOzRdNBGbgzaygXCVyZVD5DulbwcMq+5e4Z7oisnAU8Bot
         vCkTeyjLeIW8avjRTkFRA5MCoYv7199QLInjP+pm3FNEjPg0fKsk+NFOBW32sJeCu1zt
         zzHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XrIJlDe+JeGizO10Qw++8e8vAJwAbgzc+zydPAoSaCu9s7UHVx3GwDPX9fl8HRrPC5tlDdHY2fTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWtb4nP9Z9Ia+jMHIpU7a6UrggubasW3hhqTs4HITUVw3fxwC
	bFdliXMHsl1ABPzgkLlSjT175SRzq/+7EzI6hJK7V9yTcxaahXSexEmw
X-Gm-Gg: Acq92OF5D2oRInxJR4U9f867Q/KFJxqoiuTjfqHZ/0NVeOwZJFBWB2ZvhQQyUuiuRWG
	yUohDACq7yq2eSan3+Ts8Ugs5IlcIzu3odMG60p4sLtZh2KrJnsGFOcuEAHrw3but8m3T4i9nqw
	NpVrQmo5C7kPkRuix4m/Yvd2FHTqJ0/53EaPvlQ/xGIrVPv3vdksGPxUpZlwZaA2uQPJqY5YrcM
	GEWrpyUTUnUNfhddqbNApmou45b0rCPfwoBPGICgDlMmaJ60+tpUh9VZJowaF4r/hEUFPNJBE0v
	2mXNn0r6Ux36cplMuwrB0ZGsoQ049CfdDc18M/9e316U3bICRt43KHO6yhUFDeDnJNgA6D9ub+d
	N+3kPuzolrIYwXdRqNfWxBomy5qP9OfKzoeez8vi3IKMwXXd8ZhWAk6bfgSjHmw1vtdxjeIuHyk
	WuIlCScBk+RML1ZBMqswMJixCtQs8ILtTPwiL22w2OUYTgShx/KYNSh9v1/B51fPh6tctVfOsV8
	+/2bVNYT4QHX3HlDzoM/8yQy9fAKeIrMZkCtz2KO5z0/LS8dk+e/ts9aTi104v2CVTN0KnEQ4D5
	5wjP
X-Received: by 2002:a05:600c:4455:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-48fe60ea92dmr120229895e9.8.1778969766225;
        Sat, 16 May 2026 15:16:06 -0700 (PDT)
Received: from GMBS-DESKTOP.localdomain (20014C4C1D61E800CCC0A798ED610253.catv.pool.telekom.hu. [2001:4c4c:1d61:e800:ccc0:a798:ed61:253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19b1dsm24239272f8f.17.2026.05.16.15.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 15:16:05 -0700 (PDT)
Date: Sun, 17 May 2026 00:16:03 +0200
From: =?utf-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Dianlong Li <long17.cool@163.com>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v1] rtc: Use named initializers for arrays of
 i2c_device_data
Message-ID: <20260516221603.p5xuz5qczonz3sbz@GMBS-DESKTOP.localdomain>
References: <20260515154720.406128-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515154720.406128-2-u.kleine-koenig@baylibre.com>

Reviewed-by: Tóth János <gomba007@gmail.com>

