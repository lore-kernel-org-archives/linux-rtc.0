Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10D3B42E5
	for <linux-rtc@vger.kernel.org>; Thu, 18 Jun 2026 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781833; cv=pass; b=pmD4IB1jiHMt1MD57D+xhbTOZDQYX9syeoMnT8q2JkXMKvFwWjqwswrtCMFwxWzOu/UxwGBJJ/zEMPVtm9wJc1SUeU6gue7puVUvuOBXK/f715UGunOPiayk9hObe35DXE9VD1XhQX45icGSPVEwPacQYGjGzPqxH/J5OHG9SW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781833; c=relaxed/simple;
	bh=ftOGb6HrIA4XLF+PgZmXudPusKXh3HbuMIuy1WSwPxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHan37MQUpC9PWFQcfJf+2lcjbhd38YuJBNX60Y98iPj3TF82foAvLc1FbCczj3SAVTz+OEysvCk/XHjZxzyu8EM6ytPelbFuDPkqCYXw8BY8/HVMxhm4c0ZVt5fQBP0w6MOP7gsgeqPQd+sLwu8ZlxZT8wkeoh/nnHoiQnGQ88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esiGBbDd; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esiGBbDd"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso5232115e9.2
        for <linux-rtc@vger.kernel.org>; Thu, 18 Jun 2026 04:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781781831; cv=none;
        d=google.com; s=arc-20240605;
        b=Bwif2xYzVwzXm4KWzjKeI5eCVuMDkbhNc/TXI0miU1JaaeT0AuJzV0WVjpmWkCaB0e
         fPP5v82SRnL+r7XXPHYkg1jTQVzntgTMeUAXq0CAmDx3x2Xge9azQ14KMenwZcRpU2x+
         v2Uo9C87eIThTsXvFmqaOULajhvAklfd8jYfCLVf8UBqTBmOLPvDekwhAu4FsfZRzeAj
         6BOs7RwG6fgcKXspc+QqnhdAakURvwULi5LJyo9BQwjq9uED795VFkIxiufQhNwuLgw+
         qX3SGtZvspF0ympOrxQhhPr6XR57qNIsyHRSOXBYAL2MiQI9/b2KAT4yz//zF9lr6+Hi
         Y3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O7pE6Ixio0KUcBqTkyHkIjyjk/z6EK5II6djKg6cLrY=;
        fh=UNkBsl6CvwkKu2z6BLi3O2bNIX8GVEwloxNnfOHKcFw=;
        b=iGT8/qatheKBtxAbBChABod1gDjFU3D6W39qojzgPfu0346Oye+CUcca148jT7iLjN
         W5OKPjGJBkH3jRgEXtBJqOeFC+8hwBmOhkii2rKsi8BGFrCQ6MRnsgFS57tUrqEgxJ+D
         zJ1kdVzk30USNKNkOr+OGsVgasQa1CCoROUgJI6xwaIuNOOYOnaI8DI6n+2JVGvnyAMf
         GIbayjJ8/mdhFW5evzmrxq7vCrxa7X8zZBKLnnOSFO0vmu1BoW2KDmXYc7LbdZ9saXxb
         kcIcc3XAMeSbvKlYMikbGkLyAjmkgbZ8obYt7/bLRm7Czu9ZmhtWx/j6KLV9UZccGhZO
         ed/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781781831; x=1782386631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7pE6Ixio0KUcBqTkyHkIjyjk/z6EK5II6djKg6cLrY=;
        b=esiGBbDdiJAOH7zUs3QSC/EklyV3tnmrmWZxHM5jw6+G3Kb5/gMWna6ZtQJHHwi9Ln
         foE/gYtJ19SXNC6G+skr36HCGb5iWJgB/ZsZZlwbZa+lhXqLHEbiRpfubQ53TwrSGRd+
         LQSJEKLtWfnL9bZhwT+d70ZNmwrgLcFoxw8iT51pZhoRDseE8TJM1OygSqwFO1h090Om
         tslpULxZfKYxcqLJ7imRoPxDDnX0J6xRCoOaOAAtnSFdHa6G0os+6UIlWIihqcF6IJHt
         q1aKL81Iwu7jjcGydsf9OBQmWf/Z3OiYU+38Dab4oyq4rksQp/4b2fSwLUuzK6Xv1U7J
         VuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781781831; x=1782386631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7pE6Ixio0KUcBqTkyHkIjyjk/z6EK5II6djKg6cLrY=;
        b=bekkm/oTlEtS/El8fgaeNKVwqEF4MzCThj2Gj+BLkSLu1SFc/pOJ7f0HkZz8/4l9Uw
         FTQQaoqgqzRifv43hRsKdLBriXQDM8d1cf+tVyX++WpDvcvWVfKLJT0ljIHNcK+U4sQB
         YiMXPObzQVWEpG1eqb/5eIfJnwH1ddLFKWznKWk/sfA8SxCSNvg6pbjITKeKMklD83V8
         eTD9kCd2yBvOV/n1UCHiRKXTaCs1pj78VJ9qBe+D+Ueb0VapststpYTH4ZbuQ8u/Gc7+
         61Sduo+eGudgIihC+7oTmZwT7kaf0EVFJFbzlH3tSq7SLPUAc4HohqBZ8VrESm5Y1sUX
         MzOQ==
X-Forwarded-Encrypted: i=1; AFNElJ89Px2XrazbURPGE2K12ofosfqMASAeak5VKHYqENmEAvxuihZmGvzReZ5w0aLpBPqYTnIuw873d7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLquK02W5vkvUx0Ab2MN7RamLOm9y4vJU4raZtm9W+kE+0cpA
	QR0fVP06wFsh1E5GuJcHqpoUBT6XAry18LeqeX0nNWfJ/JHYiM2cufKbmDJzMEqRnen6EP15Lgj
	hV2IMyEWn/Q3trAeIWofTsQtHMCGfJcA=
X-Gm-Gg: AfdE7cn4s2XD0/4O80puORuVTeBU7F172xu+0YMQqf0HUML8pg33hIByEMWLA8slP69
	VBsrcxu7GM+PpvWYXMx1s6dQAXvsBqhQE8k9ZuK/+kuZuCv+sxjGg9zrXxgQepUHirsG+TyWjks
	JXmBPp251BYEAMxxlWpTPfRYxz90pJ7jYZEE7ndZmmqzTy8TL4ksG0zQC6h7OKBmeyiU+TPKWJA
	mIg8vcDIygdft1R4WDzBVr2WBwMOfcOgQD/8FQIgTM6AHRm8dpKyHNBaqMuDR8XK18fOjfaxtS9
	woo8zbrH8yQEIHWPd+cLCfTm9v84Kowrbnp55AYQytAeXheOYPpDv43m608l2E/p45F3rcntq1k
	RFH7X46XjWWp3qeQ=
X-Received: by 2002:a05:600c:8b58:b0:490:3d62:f5e1 with SMTP id
 5b1f17b1804b1-4923341fd3cmr119267995e9.22.1781781830725; Thu, 18 Jun 2026
 04:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-9-prabhakar.mahadev-lad.rj@bp.renesas.com> <ajJ95P-jxChrTY9w@shikoro>
In-Reply-To: <ajJ95P-jxChrTY9w@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 18 Jun 2026 12:23:24 +0100
X-Gm-Features: AVVi8Ce8X_0PfKSaPq_0DdhjnZ-uD3CRtAOp5rNvdMgkWFj4LOFbrRZD_iGqSMw
Message-ID: <CA+V-a8sJoX2CT9fq3nxBdWOEw2vOz6tOFtP5JZAHhxkpG0WVmw@mail.gmail.com>
Subject: Re: [PATCH 08/12] rtc: rzn1: Dynamically calculate synchronization
 delay based on clock rate
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

Thank you for the review.

On Wed, Jun 17, 2026 at 11:58=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> As mentioned in another thread:
>
> >  drivers/rtc/rtc-rzn1.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> > index 06339adae71f..bc6af59744e4 100644
> > --- a/drivers/rtc/rtc-rzn1.c
> > +++ b/drivers/rtc/rtc-rzn1.c
> > @@ -71,6 +71,7 @@ struct rzn1_rtc {
> >        */
> >       spinlock_t ctl1_access_lock;
> >       struct rtc_time tm_alarm;
> > +     unsigned long sync_time;
> >       int alarm_irq;
> >       int sec_irq;
> >       bool alarm_enabled;
>
> rate =3D 32768 here...
>
Agreed (in the rzn1_rtc_probe, to be precise).

> > +             rtc->sync_time =3D DIV_ROUND_UP(2 * NSEC_PER_MSEC, rate);
> > +
> >       }
>
> ... and move this to the main body of the function.
>
>
> Then, we should have all values always initialized.
>
Agreed, I will fix it in v2.

Cheers,
Prabhakar
