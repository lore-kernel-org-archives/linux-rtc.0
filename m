Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73E42122C
	for <linux-rtc@vger.kernel.org>; Thu,  3 Sep 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421985; cv=none; b=BLIgkTLVfeEQBz3AmMT9JEVx93+2kUkc/LZvxaUvcqDs7zC7nHuMehjZ46ZcXtmV8Bbblp2VKqTfu+jg+TphlmisQqsXIFqwo6ONDVLBtbINDnVuYJTXTyuDMvzOxhA1H4sBiRwqZdR0zOVKEcNo+SQulSrZNBoESL++dkHPQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421985; c=relaxed/simple;
	bh=WFDqwfiLhzlLAxGgLTojwoFhRArb9ZzqLhJka+qIiuk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1ZWxv340ecf6QwD+yTxTZzJxFoFNSDgY2q/CsegQLRqpJDezQo4hzWkbqCNdTiB3Icyy9my/d3/yZ56cwNUXMiN8YpLih2v1rvhcu9kBb2xuyLYxCGJtzZbAvg6QsNxqXsmBENvySMPQUYoRKgh/hXD7evllEIcIR99TCk+vbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF0Jy4lg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF0Jy4lg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14811F01559
	for <linux-rtc@vger.kernel.org>; Thu,  3 Sep 2026 07:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788421984;
	bh=WFDqwfiLhzlLAxGgLTojwoFhRArb9ZzqLhJka+qIiuk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=IF0Jy4lggG3pPTXJSNQn+Rwh3TEOTpmyYfE+DktBqwRfZizfuvky4VwQFHfIeBC9g
	 1Nvf13iOUS0CPr1zHbrJNiAOxeOk7imw4esLbQkd7NNdIgJdl08bL1c2MuCMyv9MOt
	 b8QgYJYpmquHHzxgaPdO3fmLu7DnkxCUXCtwzimGit5homuLPZhJYrnheqV6fAWKwx
	 33isIPhWeQksPDx4G+0QmVXUiiBzMDajY+Y6nETg4Xg1apQi3keNH5aO3+Umy+WZ89
	 OXZTXQPMGegc+JM8/erWgWF50CS+s7ayA3nQcK3i978tPyKVMJdNXyPXYBlS6RWH4w
	 r5xFkQxPMOmSg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c86945164so18947441fa.1
        for <linux-rtc@vger.kernel.org>; Thu, 03 Sep 2026 00:53:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxJ/yTqNkM4FNW13O15hTencsoE6TD+9IIGUFX5426vHeXrZUfFSZ0ZfgxuWdPrICRfA0/3qFpNw7s=@vger.kernel.org
X-Gm-Message-State: AFuF++lPfFSXtlGJ4P2+OKE+xbTPxvSjv1Lx/8z/QRLiBq4IwTX41vBj
	nzzjCeuAKk+Bo3OxdflN3+7thihrD2CAssdW3rS8SWjGbIthGP+yeSL9fOHzKNvBpbKqswocyue
	YKpMiLDIo+hv2rrXiFfW2UM5wWfe5+tpNk0ojk2VIVg==
X-Received: by 2002:a05:651c:2117:b0:3a3:52a7:3a1c with SMTP id
 38308e7fff4ca-3a352a73adfmr18741561fa.4.1788421983258; Thu, 03 Sep 2026
 00:53:03 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 00:53:01 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 00:53:01 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <57832670-6066-424d-a75f-4eb1f1f0cf73@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788346553.git.mazziesaccount@gmail.com>
 <5eb294e68b8d5d2c1d3a12b14a55dd2a9c075a09.1788346553.git.mazziesaccount@gmail.com>
 <CAMRc=MchpaOib+jgMniG7=BBYwB1yqLvJG1sMkjXfRaMFPodgA@mail.gmail.com> <57832670-6066-424d-a75f-4eb1f1f0cf73@gmail.com>
Date: Thu, 3 Sep 2026 00:53:01 -0700
X-Gmail-Original-Message-ID: <CAMRc=McED871rSf-_3Ahjjxg7QO56cZRuf_2=Xc7+Q4kwMGqnQ@mail.gmail.com>
X-Gm-Features: AcwNN1W51dTT611YKOF8alZj0OVA9lXPGK61Ff-vrlum5Ji76Da9N2L8zMOMPh4
Message-ID: <CAMRc=McED871rSf-_3Ahjjxg7QO56cZRuf_2=Xc7+Q4kwMGqnQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] gpio: bd73800: Support ROHM BD73800 PMIC GPIOs
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Michael Walle <mwalle@kernel.org>, mfd@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-rtc@vger.kernel.org, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sep 2026 07:00:24 +0200, Matti Vaittinen
<mazziesaccount@gmail.com> said:
>>
>> Why not return PTR_ERR_OR_ZERO(devm_gpio_regmap_register())?
>
> How strongly do you feel about it? It's not a big deal, but I always
> find it a bit harder to read when functions / macros are called inside a
> parameter list. Thus I'd rather keep it like this, just for the sake of
> my own eyes :)
>

If you need to respin, please change it, if not, I've given my Ack and LGTM.
Same above.

Bart
