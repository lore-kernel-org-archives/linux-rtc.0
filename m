Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB947729B
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235893; cv=pass; b=X2FFSDxYUFRJrl0t39oMIflJZCihHH9AbXDgV/uC/djH88DOp5PojYvWq6TEA8YRaltr7sZG/EFk6BI9uKvb+sBosSzdrfEceyBscuCIrKD3IfM2zkUKwTTMJ1pbnT1Y14R2+3BXxGuxL3xVwy4vRxotzT0B+zJ7RkIahV1h8Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235893; c=relaxed/simple;
	bh=4ua3cxV8dhkHOIff05LR1Y3qFBHcVH6d6nazxugRB7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5bbdduSQYfLU756ksnoD0/zwVkN9xElpjhNW+Qu78BgfswjgglSrbwfF2bEyAbBfG3nXnIl8qn/xKojS9i31q2CBErIfM+wuycCeqsjHUzgeCiKxX0LkdpR0W+AZg7/I7z5jTIFI3mve7bgLrCLZHRpmVQ2UD8X8t3YUMkKiBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgJHC9aj; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgJHC9aj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so21883095e9.1
        for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 07:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787235890; cv=none;
        d=google.com; s=arc-20260327;
        b=D/3E5b4MfUG6PG8/JosezO8NAk+H3qvSdrCdrIOBi/6bPtjIhGBxDezY9SZYvhwfNC
         5oirQUmTFQO6tmshP/01LtIA+ytMj7cF0XsXo3MT6EU6ottICJZzwXdJM1PTKa9zPXCS
         FXhHDTGJse0x3pNHXw6qc8luXwvRy7f0kQGYK7vvDSzHQMJITKv03Dedkl+9gvQ/F9yS
         qtW8mWr0T0gL0lkHnjz+222qbedDD8P6EbJuWJpJzvmDSJPAilJ6tt5u77TZWoXL0MIa
         MsIpizcZzaqhdSCvDxJqEsDNbIHSvjpjQpQXjWbxzQubgxSy82I/6ENPhUPhYFE6/IsF
         qO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vGtwPp5SElePleI/4XLp2bHhqRVpPgOhFZ40qM1IKko=;
        fh=oN3ddfgKzmUHiUbRYKHnpT38jYbAa42WEUEgOYRPqmQ=;
        b=iAt1wcHmG13HxrqtOuwCaSYJnsgJ47S7CWQWVrmWhKLlgv/yIwzrXom4d2IPRmSebR
         Kuf88t+1HEtORzLrLwn1TMlnBz4XujAW/THbDDQstIZJ/NCMm2piqbXr2uif+xwuTnZa
         xQLS2+J28kiJCefu+gTKSDeOo4+Wbqbfeb3gGalT4YFuEoarPj2qknqrZ2d2ODwvlgcw
         QA3P4FQq7+8k6AaMWKDJbFyMSYzflJjZPbklSNGDaqh7Nkq1OzsIXGM+UwULPUw1VA8N
         nX62ATH2AqSbBEkzi5M/ldE/HE2zG9CoMC2fo3rTqGxJFMDXtfJ81whlg9vSHSL7y4gO
         eMWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787235890; x=1787840690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vGtwPp5SElePleI/4XLp2bHhqRVpPgOhFZ40qM1IKko=;
        b=LgJHC9aj52KmTMuxMcUaG13G6DhAzNQIkedGybzGV56eGW4huMGy1TNr07pv7TOFCo
         yxApEc+jjb6vMBimUS2n5xpfE4H9fFEcHZ2S2dzKXDaByjL4oHV/sTSF1OPxN/T9WsF6
         5LIfu4he6Lllas4kcu7CiPyoPTsq48J8q0rtkelOgzTP93oX1LzK73Q1jLHEur9rhYP0
         FcZAqsWXokIJZKB1ytF/rdXgYFXYpBIwIgkYrT8y4OtDplU513IvnMPORLKje2PZkAzX
         dD7pOf0oGYioJDeDk5tuhKw1ObaUZrLwOKYbglRz8ALK36fz/QSFLyaVswfQ7+SyHSGN
         uv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787235890; x=1787840690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGtwPp5SElePleI/4XLp2bHhqRVpPgOhFZ40qM1IKko=;
        b=c8CFMCt917Q0VSIyjO2GZ4OZnBOoNopEVY28DKfOX1UsFhp3oXzqWVWICFQX99ew+y
         2+EYGPUaGP+UP35/7JtW8kS/EOisBRf0bv74vrhVc/y55MJ9whPyd0nGVQgpmNyKNXyz
         NQL48chnwgWygjhqoTFxmVzyjXuoK8DX1fGwID1tPyzg3vyJAHaH396RJXLCQnFMBD5c
         BD/jQ+Zk8OMto9Mg3ztvOMEJ/iLn0+SnlDozFYDcg5AlLWsEKtuOL1MemA/WkkP9IaZg
         K6s22sXVAsuLrYyDjzM83JXaA+/1TnEXDHEYwh0uqjRiVZpWGbYijNSsq1sROVNFKvA6
         Ozvg==
X-Forwarded-Encrypted: i=1; AHgh+RpVUNtQkYSMPfnC1n8LyJT3gjqIZu8/XQLfKq4FpDk6faiLWSUe9i32pFHVS/Pc+pwhOqa5liF4bWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpXfhOZ3q8jJkY0Xqvg6SJkV4l5rrGLWbgvexmESUM4pMMi37
	F1TQ4lYFKwOjQcu1zXOduQ+AMisbuxq6BK/qDotcs6rkuM4uHk8Qglg3tZPjcYHwC2osqaoahza
	5Mjp5an/7O+CdnWflLHBDGQudXHwU7hI=
X-Gm-Gg: AR+sD116kErNLc7qoUWhNGi71YMQb4tYLUiTR+ZglDWJPsRjqRizg8IEX4DqfpbH+km
	SPaH4jnzDVsQWTZT1MeBCTM3ks9x8snFwnXP7K7tjOxVk0WaDT04hSUMGzwQzV3vbmAAP+FSYbZ
	GKhDiH+rGoSmLa3FxiGsHZsCFr49zL6km28T8yX/e02GBfv5lE0OXX4aVGszmibqyH23LILqxYa
	9RU/D+PpP/inMjn4+SuOXKIe4ytzQoOF39RpU7CtTEMVg5UAoJHbMae4sAS/B6pEILGm8kGh/fo
	fAL24aTpWTlBus4BqcCdb8QoKMn0Qe/YISYTa1AQAdvi5nb56qshsp2hiZ/3KPSM2OAJXNzphB6
	j4QQJaeTWq9e1mq7kd48ZDXmGC7XHc9OAesAVo5pr
X-Received: by 2002:a05:600c:3590:b0:493:a966:d5b5 with SMTP id
 5b1f17b1804b1-499aa14a75bmr231032105e9.2.1787235889336; Thu, 20 Aug 2026
 07:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819105356.BD7731F000E9@smtp.kernel.org> <aoWpLvrNGHBPvFY5@shikoro>
In-Reply-To: <aoWpLvrNGHBPvFY5@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 20 Aug 2026 15:24:23 +0100
X-Gm-Features: AcwNN1XjPbCVWInvwnEJK7fURmifV1Jum9U6XzA0i7unkeraDGkwFi5MdsHj34Y
Message-ID: <CA+V-a8v23+zevx_xRS-GeHG2yk2k-M2UkPxoC76t-0JewRk9Dw@mail.gmail.com>
Subject: Re: [PATCH v4 03/15] rtc: rzn1: Fix weekday underflow when alarm
 crosses month boundary
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: sashiko-reviews@lists.linux.dev, conor+dt@kernel.org, 
	linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 2:01=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > [Severity: High]
> > This is a pre-existing issue, but does this time_after() comparison
> > allow bypassing the 1-week hardware limit on 32-bit systems?
>
> This is fixed later.
>
> > [Severity: Medium]
> > This is a pre-existing issue, but what happens if the RZN1_RTC_ALW regi=
ster
> > is uninitialized and wday is 0?
> >
> > Calling fls(0) - 1 would evaluate to -1. If the current time is a Satur=
day
> > (tm_now.tm_wday =3D=3D 6), delta_days evaluates to 0, which bypasses
> > the if (delta_days) block and leaves tm->tm_wday =3D -1.
> >
> > Since the core function rtc_valid_tm() does not check tm_wday, would th=
is
> > propagate a bogus alarm date to the caller?
>
> This looks worth investigating to me. On RZN1, ALW is default 0.
>
On T2H/N2H too.

I'll create a below patch for it:
diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 8c70dbf8c7ec..e0fdb591ba91 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -234,13 +234,24 @@ static int rzn1_rtc_read_alarm(struct device
*dev, struct rtc_wkalrm *alrm)
        if (ret)
                return ret;

+       ctl1 =3D readl(rtc->base + RZN1_RTC_CTL1);
+       alrm->enabled =3D !!(ctl1 & (RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE=
));
+
        min =3D readl(rtc->base + RZN1_RTC_ALM);
        hour =3D readl(rtc->base + RZN1_RTC_ALH);
-       wday =3D readl(rtc->base + RZN1_RTC_ALW);

        tm->tm_sec =3D 0;
        tm->tm_min =3D bcd2bin(min);
        tm->tm_hour =3D bcd2bin(hour);
+
+       /*
+        * If wday is zero, no bit is set in RZN1_RTC_ALW. This is the
+        * register's power-on reset value.
+        */
+       wday =3D readl(rtc->base + RZN1_RTC_ALW);
+       if (!wday)
+               return 0;
+
        delta_days =3D ((fls(wday) - 1) - tm->tm_wday + 7) % 7;
        tm->tm_wday =3D fls(wday) - 1;

@@ -249,9 +260,6 @@ static int rzn1_rtc_read_alarm(struct device *dev,
struct rtc_wkalrm *alrm)
                rtc_time64_to_tm(alarm, tm);
        }

-       ctl1 =3D readl(rtc->base + RZN1_RTC_CTL1);
-       alrm->enabled =3D !!(ctl1 & (RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE=
));
-
        return 0;
 }

Logs:
    On a cold-booted board with no alarm configured, the following was
    observed before the fix:

        root@rzn2h-evk:~# cat /proc/driver/rtc
        rtc_time        : 00:00:19
        rtc_date        : 2000-01-01
        alrm_time       : 00:00:00
        alrm_date       : 2000-01-07
        alarm_IRQ       : no
        alrm_pending    : no
        update IRQ enabled      : no
        periodic IRQ enabled    : no
        periodic IRQ frequency  : 1
        max user IRQ frequency  : 64
        24hr            : yes

    After the fix:

        root@rzn2h-evk:~# cat /proc/driver/rtc
        rtc_time        : 00:00:25
        rtc_date        : 2000-01-01
        alrm_time       : 00:00:00
        alrm_date       : 2000-01-01
        alarm_IRQ       : no
        alrm_pending    : no
        update IRQ enabled      : no
        periodic IRQ enabled    : no
        periodic IRQ frequency  : 1
        max user IRQ frequency  : 64
        24hr            : yes


Cheers,
Prabhakar
