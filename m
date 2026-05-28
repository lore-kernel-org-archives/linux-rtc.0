Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092ED3F0760
	for <linux-rtc@vger.kernel.org>; Thu, 28 May 2026 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974513; cv=none; b=U3kK7DNEb3MdGA7twGFbmCa/fqAfdLRnHoEP7mH5k4rZUfapdOebZrSMHvDwT6Ed3USnWNORhBMOn/HtZdYZvQ0PxBHimUUNnXhkMIrDjogOG96shsWQ8U4C0/3t8TpBgE1ZglHEStNYNYgS+m/xD182+UIpQ/oQQ9cPtDIlFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974513; c=relaxed/simple;
	bh=WczCRnxFIfbJSk+Li++oRjyPTMZ8/2+ILcMc1xcFWPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZ47CyvdUGHyh/1d07JGQ4mO3fpZ3SCXbQ8lEX6uIkbh3B2brZNsZYt8oXBUyLzxnrqemsSpZ+jVG8RzUsM4mK7gKDxB4plGKoPgu9ZgTpAbjiIBFYiwzRc0J4xaJrU04mdsLPkYXCuM+59TjOIWI4c6PRgXHltZqcapjLup7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhocV33q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhocV33q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77291F00A3F
	for <linux-rtc@vger.kernel.org>; Thu, 28 May 2026 13:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779974511;
	bh=WczCRnxFIfbJSk+Li++oRjyPTMZ8/2+ILcMc1xcFWPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bhocV33qxdQDCW1JiL/qfTm1FVjBxspYkBlbRPwOyOp3aK5TI1NQSIeDDPmcsiwoi
	 UKw7JPj7bPXv/pnqyPNvJzfE4YK3q+XuQ9vWiDiCDHDCohDdazyR3Xo0P04+OPDM03
	 fCBahWsV7zRZIL9WUYfBSJdFMLjuJaI4A/Cjp+Z9xFUDZygcH9cosTOKmt54uax0TF
	 kjQ4YDD2+joNTTuoJjzyov/bYioUvqIuNVhKyPQz1jiK9xhzRHBy/SojW7tl/ENrc0
	 heDfi5DhxR8bHQH1n25/6HRjZ1tKf9C31tRocRmbpqwjlFYNaHeQlE82t88sMPt4+L
	 Zk+8pRFLVaj7A==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a884815606so13914408e87.0
        for <linux-rtc@vger.kernel.org>; Thu, 28 May 2026 06:21:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9SRTG8KEGWBpfKeXW8Feh5UDpzdzfy11gGJTG3u1yabKr9w7SsheWJ3kZnLZFFT7P59NVqS+ITSBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywai+8RnKu3TzAajbRshVtl4FoBAMpWtBwcSmCZnVsDzO38TavI
	Kb4f7OlmpU0A3LK0FrN/xV+oExPv9exdDltwu6mD1WjTi7mRMLgITOKt3bShG7ah6Z3XxO9BM4i
	gJfti9YQfIYIUa/SpZLXZgBtDbierWLo=
X-Received: by 2002:ac2:5594:0:b0:5a8:6df4:6ad7 with SMTP id
 2adb3069b0e04-5aa3239eebamr5916994e87.14.1779974510431; Thu, 28 May 2026
 06:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779950275.git.u.kleine-koenig@baylibre.com> <d14b9076b2c7703708bcc5cc35f339cd97fc10cd.1779950275.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <d14b9076b2c7703708bcc5cc35f339cd97fc10cd.1779950275.git.u.kleine-koenig@baylibre.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 28 May 2026 15:21:38 +0200
X-Gmail-Original-Message-ID: <CAD++jLkug4Q3XZbsyFAGMre47A-G_9jd6=Nk6m-iHipXm7CoVg@mail.gmail.com>
X-Gm-Features: AVHnY4L8ZQEo6oCaX_r6b-iZZdK0XNz743h3p9zf0vvzpKnJPXJQd-y34D5kroU
Message-ID: <CAD++jLkug4Q3XZbsyFAGMre47A-G_9jd6=Nk6m-iHipXm7CoVg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] rtc: Use named initializers for platform_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Karel Balej <balejk@matfyz.cz>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:48=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:

> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous union.
>
> While touching these arrays unify spacing and usage of commas.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
