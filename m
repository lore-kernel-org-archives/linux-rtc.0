Return-Path: <SRS0=UNq1=NY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B239CC43441
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Nov 2018 11:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE1C2250E
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Nov 2018 11:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnCFl0SL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE1C2250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeKMVsD (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:32870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbeKMVsC (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 13 Nov 2018 16:48:02 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7403D21780;
        Tue, 13 Nov 2018 11:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542109815;
        bh=c9MD4wfEzkWA7U4ezcY7uPoOQOfw7W9NLNII7Nh/qrU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EnCFl0SL638gijOpLpJ0vo6VQcsgeK+e+dyexdV5+uPbTWW3rm0cosmj04qIdMedZ
         2nTy2HyJ3BNFiciP15gQJVCYe0ZOqpBzIvWrvprSlbbzhTE8+kchi9JEBivPuz7VFs
         m+xznybqKqRShZTavtTYABRKCvg1G3cM87bGBbrg=
Received: by mail-lj1-f179.google.com with SMTP id t9-v6so10542503ljh.6;
        Tue, 13 Nov 2018 03:50:15 -0800 (PST)
X-Gm-Message-State: AGRZ1gK1sTit7GdHy/3YCZhiMTGcZDx2phVAaafZJaMViDpWCBwnP791
        vyyZY6V5tT6if/js42qCSPCjEEC1fEpoZmtP2jM=
X-Google-Smtp-Source: AJdET5dYgyM8K6JOCN/zWsS65hr42ofQZKNiIpNA1BknoWgugn+Z/MEuG5YXwlUWQ00gPDj7LAoS5NPYxcCSgskFYYc=
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr3234507lji.60.1542109813513;
 Tue, 13 Nov 2018 03:50:13 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181113113303eucas1p130a8d53b363d8ff378389e2cfc6f6cc6@eucas1p1.samsung.com>
 <20181113113250.15527-1-m.szyprowski@samsung.com>
In-Reply-To: <20181113113250.15527-1-m.szyprowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 13 Nov 2018 12:50:02 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeKOEh9=eNB4FPGUJKykjPQK=6eM69AAw210FRD3SD7qA@mail.gmail.com>
Message-ID: <CAJKOXPeKOEh9=eNB4FPGUJKykjPQK=6eM69AAw210FRD3SD7qA@mail.gmail.com>
Subject: Re: [PATCH] rtc: s3c-rtc: Avoid using broken ALMYEAR register
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-rtc@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, 13 Nov 2018 at 12:33, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> (RTC,ALM)YEAR registers of Exynos built-in RTC device contains 3 BCD
> characters. s3c-rtc driver uses only 2 lower of them and supports years
> from 2000..2099 range. The third BCD value is typically set to 0, but it
> looks that handling of it is broken in the hardware. It sometimes
> defaults to a random (even non-BCD) value. This is not an issue
> for handling RTCYEAR register, because bcd2bin() properly handles only
> 8bit values (2 BCD characters, the third one is skipped). The problem
> is however with ALMYEAR register and proper RTC alarm operation. When
> YEAREN bit is set for the configured alarm, RTC hardware triggers alarm
> only when ALMYEAR and RTCYEAR matches. This usually doesn't happen
> because of the random noise on the third BCD character.
>
> Fix this by simply skipping setting ALMYEAR register in alarm
> configuration. This workaround fixes broken alarm operation on Exynos
> built-in rtc device. My tests revealed that the issue happens on the
> following Exynos series: 3250, 4210, 4412, 5250 and 5410.

Does it mean that alarm set for 20.11.2019 will be triggered also this
year on 20.11.2018 (and any other year as well)?

Best regards,
Krzysztof

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 75c8c5033e08..58e03ac3578b 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -327,7 +327,6 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>         struct rtc_time *tm = &alrm->time;
>         unsigned int alrm_en;
>         int ret;
> -       int year = tm->tm_year - 100;
>
>         dev_dbg(dev, "s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
>                 alrm->enabled,
> @@ -356,11 +355,6 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>                 writeb(bin2bcd(tm->tm_hour), info->base + S3C2410_ALMHOUR);
>         }
>
> -       if (year < 100 && year >= 0) {
> -               alrm_en |= S3C2410_RTCALM_YEAREN;
> -               writeb(bin2bcd(year), info->base + S3C2410_ALMYEAR);
> -       }
> -
>         if (tm->tm_mon < 12 && tm->tm_mon >= 0) {
>                 alrm_en |= S3C2410_RTCALM_MONEN;
>                 writeb(bin2bcd(tm->tm_mon + 1), info->base + S3C2410_ALMMON);
> --
> 2.17.1
>
